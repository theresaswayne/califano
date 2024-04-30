# run this code in sections!

temp <- list.files("/Users/theresaswayne/Desktop/output/cells", full.names = TRUE, pattern = "\\.csv$")
cells <- readr::read_csv(temp, id = "file_name")
write.csv(cells, file = "/Users/theresaswayne/Desktop/output/2024-04-29_cells_merged.csv")

temp <- list.files("/Users/theresaswayne/Desktop/output/cytoplasm", full.names = TRUE, pattern = "\\.csv$")
cyto <- readr::read_csv(temp, id = "file_name")
write.csv(cyto, file = "/Users/theresaswayne/Desktop/output/2024-04-29_cytoplasm_merged.csv")


temp <- list.files("/Users/theresaswayne/Desktop/output/nuclei", full.names = TRUE, pattern = "\\.csv$")
nuclei <- readr::read_csv(temp, id = "file_name")
write.csv(nuclei, file = "/Users/theresaswayne/Desktop/output/2024-04-29_nuclei_merged.csv")
