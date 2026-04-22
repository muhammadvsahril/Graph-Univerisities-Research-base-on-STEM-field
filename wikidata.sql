# Top 10 universities by STEM research fields (most researchers per field)
SELECT 
  ?universityName
  ?fieldName
  (COUNT(DISTINCT ?researcher) AS ?researcherCount)
WHERE {
  ?researcher wdt:P31 wd:Q5 .           # human
  ?researcher wdt:P108 ?university .    # employer
  ?researcher wdt:P101 ?field .         # field of work
  
  ?field rdfs:label ?fieldName .
  FILTER(LANG(?fieldName) = "en")
  
  # STEM field categories
  VALUES ?stemCategory {
    wd:Q336      # science
    wd:Q11062    # technology
    wd:Q7881     # engineering
    wd:Q373      # mathematics
    wd:Q81096    # computer science
    wd:Q8074     # physics
    wd:Q431      # biology
    wd:Q166118   # chemistry
  }
  
  ?field wdt:P31|wdt:P279 ?stemCategory .
  
  ?university wdt:P31 wd:Q3918 .        # university
  ?university rdfs:label ?universityName .
  FILTER(LANG(?universityName) = "en")
}
GROUP BY ?universityName ?fieldName
ORDER BY ?universityName DESC(?researcherCount)
LIMIT 50