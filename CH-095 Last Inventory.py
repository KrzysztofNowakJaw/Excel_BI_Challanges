#link to challange
#https://www.linkedin.com/posts/omid-motamedisedeh-74aba166_powerabrquery-excel-powerabrqueryabrtips-activity-7227780686835818497-012e?utm_source=share&utm_medium=member_desktop

import pandas as pd

# Ścieżka do pliku
#file_path = '/Users/krzysztofnowak/Desktop/Excel_BI_Challanges/CH-095 Last Inventory.xlsx'


df = pd.read_excel(file_path, sheet_name=0, usecols="B:G", skiprows=1, nrows=6)

Melted = pd.melt(df, id_vars="Product",value_name="Last Inventory")

Cleaned = Melted.dropna().groupby("Product")

Result = Cleaned.tail(1).sort_values("Product")

Result.drop(columns=['variable'])
