
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
        "filter": "vs:HelseRegion3",
        "values": [
          "H12",
          "H03",
          "H04",
          "H05"
        ]
      }
    },
    {
      "code": "ContentsCode",
      "selection": {
        "filter": "item",
        "values": [
          "Dognplass"
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



# Henter ut innholdet fra d.tmp som tekst deretter bearbeides av fromJSONstatdø <- fromJSONstat(content(d.tmp, "text"))
dognplasser <- fromJSONstat(content(d.tmp, "text"))


# Viser datasettet
dognplasser

