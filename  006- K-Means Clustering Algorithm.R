#Link tovchallange
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_excelchallenge-powerquerychllenge-excel-activity-7162949660976902144-I6qg?utm_source=share&utm_medium=member_desktop


# Load necessary library
library(tidyverse)

# Create a vector of values
values <- c(1, 2, 5, 21, 22, 23, 51, 52, 53, 72)

# Create a data frame from the vector of values
df <- data.frame(Values = values)

# Initialize an empty list to store the clustering results
all_clusters <- list()

# Loop over values from 2 to 4 for the number of clusters
for (i in 2:4) {
  KMeans <- kmeans(x = df$Values, centers = i)
  Answer <- KMeans$cluster
  
  # Add clustering results to the list
  all_clusters[[i]] <- Answer
}

# Combine all clustering results into a single vector
Results <- unlist(all_clusters)

# Create a data frame to display clustering results for different values of K
Answer <- data.frame(
  `Result if K=2` = Results[1:10],
  `Result if K=3` = Results[11:20],
  `Result if K=4` = Results[21:30]
)

# Print the final results
print(Answer)

#optional purrr solution
map(2:4, ~ kmeans(df$Values, centers = .x)$cluster)
