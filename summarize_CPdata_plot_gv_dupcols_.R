# summarize_CP_tables_SD_plot.R
# R script to select mean intensity data from CellProfiler object results files
# and summarize by well (designed for Cytation imager data)
# handles duplicate column names caused by a bug in cellprofiler as of 1/2025
# To use: Run the script.
# Will be prompted for a file

# ---- Setup ----
require(tidyverse)
require(readr)
require(stringr)


# ---- Prompt for an object file ----
# no message will be displayed
objectFile <- file.choose()

# Read the data from the file
objectData <- read_csv(objectFile,
                    locale = locale())


mean_intens <- objectData %>% 
  group_by(`Metadata_Well...9`) %>% 
  summarise(nCells = n(),
            Mean = mean(Intensity_MeanIntensity_APC),
            MeanSD = sd(Intensity_MeanIntensity_APC),
            IntDen = mean(Intensity_IntegratedIntensity_APC),
            IntDenSD = sd(Intensity_IntegratedIntensity_APC))

# 
# edge_intens <- objectData %>% 
#   group_by(Metadata_Experiment, Metadata_Well) %>% 
#   summarise(Edge_Mean = mean(Intensity_MeanIntensityEdge_Green),
#             Edge_MeanSD = sd(Intensity_MeanIntensityEdge_Green),
#             Edge_IntDen = mean(Intensity_IntegratedIntensityEdge_Green),
#             Edge_IntDenSD = sd(Intensity_IntegratedIntensityEdge_Green))
# 
# merged_intens <- left_join(mean_intens, edge_intens)

# ---- Save new file ----
objectName <- str_sub(basename(objectFile), 1, -5) # name of the file without higher levels or extension
parentDir <- dirname(objectFile) # parent of the file
outputFile = paste(objectName, "_summary.csv") # spaces will be inserted
write_csv(mean_intens,file.path(parentDir, outputFile))

# ---- Plot ----
p_mean <- ggplot(objectData,
                 aes(x=`Metadata_Well...9`,
                     y=Intensity_MeanIntensity_APC)) + 
  geom_violin(trim=FALSE) +
  stat_summary(fun.data=mean_sdl,
               geom="pointrange", color="red")

outputPlot = paste(objectName, "mean plot.pdf")

# plot size can be changed according to the number of panels
ggsave(file.path(parentDir, outputPlot), width=20, height = 14)
