## code to prepare `selected_phylogeny` dataset

selected_phylogeny <- sort(c("Actinobacteria", "Bacteroidetes", "Euryarchaeota",
                             "Firmicutes", "Proteobacteria", "Spirochaetes",
                             "Tenericutes", "Planctomycetes", "Verrucomicrobia",
                             "Chlamydiae", "Crenarchaeota"))
# save data into the package
usethis::use_data(selected_phylogeny, overwrite = TRUE)

# usage
usethis::use_data("selected_phylogeny")
