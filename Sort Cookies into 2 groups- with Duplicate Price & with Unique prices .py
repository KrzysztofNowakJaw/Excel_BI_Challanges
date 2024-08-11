#Link to challange
#https://www.linkedin.com/posts/crispo-mwangi-6ab49453_excelchallenge-crispexcel-powerquery-activity-7228259213892808704-nVRV?utm_source=share&utm_medium=member_desktop

import pandas as pd
import numpy as np

# Definiowanie as dictionary
data = {
    'cookie': [
        'Chocolate Chip', 'Oatmeal Raisin', 'Sugar Cookies', 'Peanut Butter', 
        'Double Chocolate', 'White Chocolate Nut', 'Snickerdoodle', 
        'Gingerbread', 'Shortbread', 'M&M Cookies', 'Lemon Poppy Seed', 
        'Pumpkin Spice'
    ],
    'price': [
        8.50, 7.75, 6.50, 7.25, 9.00, 9.00, 7.00, 
        8.50, 7.50, 8.75, 7.50, 8.50
    ]
}

# Create data frame
df = pd.DataFrame(data)

Counted = df.groupby("price").count()
Duplicated = Counted.loc[Counted.cookie > 1]
Uniques = Counted.loc[Counted.cookie == 1]

D = Duplicated.merge(df,how="inner",on="price")
U = Uniques.merge(df,how="inner",on="price")

Results = {
    'Duplicated':D['cookie_y'],
    'Uniques': U['cookie_y']
}
Answer = pd.DataFrame(Results)

Answer
