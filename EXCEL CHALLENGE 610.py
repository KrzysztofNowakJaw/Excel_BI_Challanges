#Challange
#https://www.linkedin.com/posts/excelbi_excel-challenge-problem-activity-7274634412707753984-pDhU?utm_source=share&utm_medium=member_desktop

import pandas as pd

data = {
    "Sentence1": [
        "snowflakes danced in the air",
        "city skyline was a sight to behold",
        "sun slowly descended below the horizon",
        "sound of crashing waves against the shore",
        "old man sat alone on the park bench",
        "children played joyfully in the meadow",
        "majestic eagle soared high above the mountains",
        "aroma of freshly baked bread wafted through the air"
    ],
    "Sentence2": [
        "leaves on the trees rustled as the wind danced through the air",
        "It was a breathtaking sight in the skyline",
        "line is not drawn horizontally",
        "waves after waves",
        "the old park had a rusted bench",
        "vast meadow had a carpet of greenery",
        "mountains host many eagles high atop the majestic peaks",
        "bread's aroma was floating in the air"
    ]
}

df = pd.DataFrame(data)
print(df)


def UCW(x,y):
    xs = set(str.split(x))
    ys = set(str.split(y))
    return len(xs.symmetric_difference(ys))

#UCW(x, y) to funkcja, która przyjmuje dwa argumenty.
#df.apply(lambda row: operacja(row['kolumna1'], row['kolumna2']), axis=1) - Metoda apply() iteruje po wierszach DataFrame, a lambda row: operacja(row['kolumna1'], row['kolumna2']) przekazuje odpowiednie wartości z każdej kolumny jako argumenty do funkcji UCW().
#axis=1 oznacza, że funkcja jest stosowana do wierszy, a nie do kolumn.    

df['wynik'] = df.apply(lambda row: UCW(row['Sentence1'], row['Sentence2']), axis=1)

# Użycie zip() i map() do wykonania operacji na dwóch kolumnach
df['wynik2'] = list(map(lambda x, y: UCW(x, y), df['Sentence1'], df['Sentence2']))



df
