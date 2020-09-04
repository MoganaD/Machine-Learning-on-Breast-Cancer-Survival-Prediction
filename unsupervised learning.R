#1.Import data
###Import your own dataset from your device
data1 <- read.csv (file="C:/Users/Mogana Darshini/OneDrive/unsupervised learning/Manuscript/Analysis/data1.csv")

#2.describe data
dim(data1) ##will give the details of number of columns and rows
str(data1) ##will describe the structure of the data

#3.Load libraries
library(factoextra)
library(cluster)
library(magrittr)

#4.Compute Gap Statistics to determine total number of clusters
fviz_nbclust(data1, kmeans, method = "gap_stat")

#5. Compute hierarchical clustering
res.hc <- data1 %>%
  scale() %>%                    # Scale the data
  dist(method = "euclidean") %>% # Compute dissimilarity matrix
  hclust(method = "ward.D2")     # Compute hierachical clustering

print (res.hc)

#6.# Visualize using factoextra
# Cut in five groups and color by groups
fviz_dend(res.hc, k = 5, # Cut in five groups
          cex = 0.5, # label size
          k_colors = c("#2E9FDF", "#00AFBB", "#E7B800", "#FC4E07", "1D08A5"),
          color_labels_by_k = TRUE, # color labels by groups
          rect = TRUE # Add rectangle around groups
)

#6.k means clustering
set.seed (20)
kmeans_clustering <- kmeans(data1, 5)
#inspect 'kmeans_clustering'
str(kmeans_clustering)
#cluster: a vector of integers (from 1:k) indicating the cluster to which each point is allocated.
#centers: a matrix of cluster centers.
#withinss: vector of within-cluster sum of squares, one component per cluster.
#tot.withinss: total within-cluster sum of squares. That is, sum(withinss).
#size: the number of points in each cluster.

print(kmeans_clustering)
kmeans_clustering$cluster #variables in each cluster
kmeans_clustering$size #total 

# Scatter plot of x
fviz_cluster(kmeans_clustering, data = data1,
             palette = c("#1D08A5", "#00AFBB", "#E7B800", "#08A508", "#A50822"), 
             geom = "point",
             ellipse.type = "convex", 
             ggtheme = theme_bw()
)