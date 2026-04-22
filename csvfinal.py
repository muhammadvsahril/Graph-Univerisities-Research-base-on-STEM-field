import pandas as pd

df_wiki = pd.read_csv('wikidata.csv')
df_dbpedia = pd.read_csv('dbpedia.csv')

merged = pd.merge(df_wiki, df_dbpedia, on=['universityName', 'fieldName', 'researcherCount'], how='outer')
merged.to_csv('combine.csv', index=False)