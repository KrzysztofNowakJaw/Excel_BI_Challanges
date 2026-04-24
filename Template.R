library(readxl)
library(tidyverse)

source(file = 'EBI_Load.R')
source(file = 'EBI_remove.R')

#df <- read_xlsx(File_name,range = "B3:E10")

#Ex <- read_xlsx()
library(DBI)
library(RPostgres)

# Read the Excel file
df <- read_xlsx(File_name, range = "B3:E10")

# Connect to PostgreSQL
con <- dbConnect(
    RPostgres::Postgres(),
    dbname = "postgres",
    host = "localhost",
    port = 5432,
    user = "krzysztofnowak",
    password = "DomowySQL"
)


# Export dataframe to PostgreSQL
dbWriteTable(
    conn = con,
    name = "Excel_Challenge_963",
    value = df,
    overwrite = TRUE,
    row.names = FALSE
)

# Close the connection
