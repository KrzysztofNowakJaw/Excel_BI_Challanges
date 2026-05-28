# Załadowanie bibliotek
library(DBI)
library(odbc)

# Konfiguracja połączenia
con <- dbConnect(
  odbc::odbc(),
  Driver = "ODBC Driver 18 for SQL Server", # lub "ODBC Driver 17 for SQL Server"
  Server = "databoxfabb.database.windows.net",
  Database = "FABB",
  UID = "REKRUTACJA",
  PWD = "dfAtVkwUSgDjiZXvAMQK3", # <-- wpisz hasło otrzymane przez SMS
  Port = 1433,
  Encrypt = "yes",
  TrustServerCertificate = "no"
)

part_catalog <- dbGetQuery(con, "SELECT * FROM PART_CATALOG_TAB")
customers <- dbGetQuery(con, "SELECT * FROM CUSTOMER_TAB")
orders <- dbGetQuery(con, "SELECT * FROM ORDER_TAB")
order_lines <- dbGetQuery(con, "SELECT * FROM ORDER_LINE_TAB")
cut_process <- dbGetQuery(con, "SELECT * FROM CUT_PROCESS_TAB")

# Szybki podgląd
glimpse(orders)
glimpse(order_lines)
names(part_catalog)
names(customers)
names(orders)
names(order_lines)


names(cut_process)
glimpse(cut_process)

# Sprawdzenie połączenia
dbListTables(con)

# Zamknięcie połączenia po zakończeniu pracy
dbDisconnect(con)
