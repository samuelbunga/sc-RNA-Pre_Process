library(tidyverse)
library(Seurat)

args <- commandArgs(trailingOnly = TRUE)

data <- as.sparse(read.delim(file=args[1], sep="\t", header=T, row.names=1))
data_df <- as.data.frame(data)

# removing gene ids
#row.names(data_df) <- str_replace(row.names(data_df), regex("_.*"), "")

# converting 'mt' genes to uppercase if exists
rnames <- str_replace(row.names(data_df), 'mt-','MT-')

row.names(data_df) <- NULL
data_mat <- as.matrix(data_df)
row.names(data_mat) <- rnames
data_df	<- as.sparse(data_mat)

# writing out
write.csv(data_df, sep=",", quote=F, file=args[2])
