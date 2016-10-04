# Big Data Analytics Systems (BDAS) - Insight Data Engineering Fellowship Project 
# Comparison of Big Data Analytics Systems - Redshift and Hive
[DE Fellow: Prashant Ratnaparkhi] 

## Overview
Comparison of Hive and Redshift is done by measuring the performance of certain queries against both systems. Schema, queries and data population mechanism specifed in Transacation Processing Council Bigbench (TPC-BB) benchmark. The queries include real-life analytics scenarios such as - identifying the customers who view online and then purchase in store or identifying the products sold together frequently. The dataset was scaled from 50GB to 500GB. 


## System Setup

| Hive                                               | Redshift                                                     |
| -------------------------------------------------- | -------------------------------------------------------------|
| 2 Clusters each with 1 namenode, 5 datanodes       | Single Cluslter with 1 Leader and 5 Compute nodes            |
| Each node: r3.Large                                | Each node: dc1.Large                                         |
| Cluster1 with 50GB & Cluster2 with 500 GB dataset  | Two databases: First with 50 GB & second with 500 GB dataset |


Load Data means populating metastore for Hive & copying data from S3 in case of RedShift. ** With three tables (store_sales, item, web_clickstream using distkey & sortkey, the ‘Load Data’ time increased to approx. 50 Min & 11 Hours respectively for Redshift.


## Queries

## Performance results


## Conclusions


