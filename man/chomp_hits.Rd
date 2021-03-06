% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/chomp_hits.R
\name{chomp_hits}
\alias{chomp_hits}
\title{Hits to data.tables}
\usage{
chomp_hits(hits_json = NULL, keep_nested_data_cols = TRUE)
}
\arguments{
\item{hits_json}{A character vector. If its length is greater than 1, its elements will be pasted 
together. This can contain a JSON returned from a \code{search} query in 
Elasticsearch, or a filepath or URL pointing at one.}

\item{keep_nested_data_cols}{a boolean (default TRUE); whether to keep columns that are nested
arrays in the original JSON. A warning will be given if these 
columns are deleted.}
}
\description{
A function for converting Elasticsearch docs into R data.tables. It
             uses \code{\link[jsonlite]{fromJSON}} with \code{flatten = TRUE} to convert a
             JSON into an R data.frame, and formats it into a data.table.
}
\examples{
# A sample raw result from a hits query:
result <- '[{"_source":{"timestamp":"2017-01-01","cust_name":"Austin","details":{
"cust_class":"big_spender","location":"chicago","pastPurchases":[{"film":"The Notebook",
"pmt_amount":6.25},{"film":"The Town","pmt_amount":8.00},{"film":"Zootopia","pmt_amount":7.50,
"matinee":true}]}}},{"_source":{"timestamp":"2017-02-02","cust_name":"James","details":{
"cust_class":"peasant","location":"chicago","pastPurchases":[{"film":"Minions",
"pmt_amount":6.25,"matinee":true},{"film":"Rogue One","pmt_amount":10.25},{"film":"Bridesmaids",
"pmt_amount":8.75},{"film":"Bridesmaids","pmt_amount":6.25,"matinee":true}]}}},{"_source":{
"timestamp":"2017-03-03","cust_name":"Nick","details":{"cust_class":"critic","location":"cannes",
"pastPurchases":[{"film":"Aala Kaf Ifrit","pmt_amount":0,"matinee":true},{
"film":"Dopo la guerra (Apres la Guerre)","pmt_amount":0,"matinee":true},{
"film":"Avengers: Infinity War","pmt_amount":12.75}]}}}]'

# Chomp into a data.table
sampleChompedDT <- chomp_hits(hits_json = result, keep_nested_data_cols = TRUE)
print(sampleChompedDT)

# (Note: use es_search() to get here in one step)

# Unpack by details.pastPurchases
unpackedDT <- unpack_nested_data(chomped_df = sampleChompedDT
                                 , col_to_unpack = "details.pastPurchases")
print(unpackedDT)
}
