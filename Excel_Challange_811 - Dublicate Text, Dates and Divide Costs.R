'https://onedrive.live.com/personal/e11b26eeaacb7947/_layouts/15/Doc.aspx?sourcedoc=%7Bce07abc4-0d13-48ef-8d01-08cca892a22c%7D&action=default&redeem=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VjU3JCODRURGU5SWpRRUl6S2lTb2l3QmtpUUI3QVN3QWRuT3BjWVh5azlBaHc_ZT1WMFNJRU0&slrid=a4c7c8a1-5013-a000-41f4-edb1da9ce429&originalPath=aHR0cHM6Ly8xZHJ2Lm1zL3gvYy9lMTFiMjZlZWFhY2I3OTQ3L0VjU3JCODRURGU5SWpRRUl6S2lTb2l3QmtpUUI3QVN3QWRuT3BjWVh5azlBaHc_cnRpbWU9WjBuRlp5XzczVWc&CID=028f9b49-8972-4e26-97d4-d26dbe322400&_SRM=0:G:39'

df <- read_xlsx(File_name,range = "A2:H6") |> janitor::clean_names()

df

Answer <- df |>
  group_by(item) |>
  complete(quantity = seq(from = 1,to = max(quantity))) |>
  fill(everything(),.direction = "up") |>
  mutate(NRows = n(),
         material_cost = material_cost/NRows,
         installation_cost = installation_cost/NRows,
         quantity = min(quantity) ,
         code = as.character(code))|>
  select(names(df))

Answer$item <- 1:nrow(Answer)

Answer |>
  janitor::adorn_totals()


