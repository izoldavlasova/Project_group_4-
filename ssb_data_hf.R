options(encoding="UTF-8")
library(httr)



# henter rjstat bibliotek for behandling av JSON-stat
library(rjstat)
url <- "https://data.ssb.no/api/v0/no/table/06922/"



# spørring fra konsoll - kan være på en linje
data <- '
{
  "query": [
    {
      "code": "HelseReg",
      "selection": {
        "filter": "vs:HelseRegion4",
        "values": [
          "983971636",
          "993467049",
          "983971700",
          "983971768",
          "883971752",
          "894166762",
          "983975267",
          "983975259",
          "983975200",
          "H12_P",
          "983974724",
          "983974694",
          "983974732",
          "983974678",
          "H03_P",
          "983974791",
          "997005562",
          "883974832",
          "983974929",
          "983974880",
          "983974910",
          "983974899"
        ]
      }
    },
    {
      "code": "ContentsCode",
      "selection": {
        "filter": "item",
        "values": [
          "Liggedag",
          "Polikliniske",
          "Dag"
        ]
      }
    },
    {
      "code": "Tid",
      "selection": {
        "filter": "item",
        "values": [
          "2010",
          "2011",
          "2012",
          "2013",
          "2014",
          "2015",
          "2016",
          "2017",
          "2018",
          "2019",
          "2020",
          "2021"
        ]
      }
    }
  ],
  "response": {
    "format": "json-stat2"
  }
}
'
d.tmp <- POST(url , body = data, encode = "json", verbose())



# Henter ut innholdet fra d.tmp som tekst deretter bearbeides av fromJSONstat
ssb_data_hf <- fromJSONstat(content(d.tmp, "text"))



# Viser datasettet
ssb_data_hf 

#Clean the column names 
ssb_data_hf <- ssb_data_hf %>% 
  clean_names()

# From long to wide format 
ssb_data_hf <- spread(ssb_data_hf, key = region, value = value)

