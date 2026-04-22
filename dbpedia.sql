PREFIX dbo: <http://dbpedia.org/ontology/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
PREFIX dct: <http://purl.org/dc/terms/>

SELECT 
  ?universityName
  ?fieldName
  (COUNT(DISTINCT ?researcher) AS ?researcherCount)
WHERE {
  ?researcher rdf:type dbo:Scientist .
  ?researcher dbo:almaMater ?university .   # ganti employer dengan almaMater
  ?researcher dct:subject ?fieldSubject .
  
  ?fieldSubject rdfs:label ?fieldName .
  FILTER(LANG(?fieldName) = "en")
  
  FILTER(CONTAINS(LCASE(?fieldName), "science") || 
         CONTAINS(LCASE(?fieldName), "engineering"))
  
  ?university rdf:type dbo:University .
  ?university rdfs:label ?universityName .
  FILTER(LANG(?universityName) = "en")
  FILTER(STRSTARTS(STR(?universityName), "A"))
}
GROUP BY ?universityName ?fieldName
LIMIT 50