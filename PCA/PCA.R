

wine <- read.table("wine.tsv", header = TRUE, sep = "\t")
wine <- wine[, -1]

non_normal_pca <- princomp(wine)

# Normalize each column in wine
wine <- scale(wine)

normal_pca <- princomp(wine)

normal_pca_noc_cor <- princomp(wine, cor = FALSE)

# Scree plot for non-normalized PCA
plot(normal_pca, type = "l", main = "Scree Plot - Non-normalized PCA")

biplot(normal_pca)