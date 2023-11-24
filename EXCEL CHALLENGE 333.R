
#Task: Extract the string before any alphabet is repeated. Hence, in case of "Apple", the answer is "Ap". In case of "Debt", no alphbet is repeated. Hence answer is "Debt"
#Link to challange: https://www.linkedin.com/feed/update/urn:li:activity:7133665545949691904/


library(tidyverse)


Task <- data.frame(String = c("Banana","Cattle","Oops","Dance","Grass","Uncopyrightable","Sydney","Indianapolis","Excel"))


StopBefore <- function(x) {

word <- tolower(x)
split_word <- strsplit(word, split = "")[[1]] #Split word into list of letters
duplicated_letters <- duplicated(split_word) #Check if value is duplicated (TRUE/FALSE)
first_duplicated <- match(TRUE, duplicated_letters) # Check position of first duplicate
if (!is.na(first_duplicated)) {
  result <- paste(split_word[1:(first_duplicated - 1)], collapse = "") #Take values from first to duplicate - 1
  result <- str_to_title(result) #Caitalize first letter
} else {
  result <- str_to_title(word)
}
print(result) 
}


Answer <- Task |>
  rowwise() |> # Aplly per row
  mutate(Answer = StopBefore(String)) # Apply function to String column


Answer
