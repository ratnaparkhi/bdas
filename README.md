# Big Data Analytics Systems (BDAS) - Insight Data Engineering Fellowship Project 
# Comparison of Big Data Analytics Systems - Redshift and Hive
[Author: Prashant Ratnaparkhi] 

## Overview
Comparison of Hive and Redshift is done by measuring the performance of certain queries against both systems. Schema, queries and data population mechanism specifed in Transacation Processing Council Bigbench (TPC-BB) benchmark. The queries include real-life analytics scenarios such as - identifying the customers who view online and then purchase in store or identifying the products sold together frequently. The dataset was scaled from 50GB to 500GB. 


## System Setup

| Hive                                               | Redshift                                                     |
| -------------------------------------------------- | -------------------------------------------------------------|
| 2 Clusters each with 1 namenode, 5 datanodes       | Single Cluslter with 1 Leader and 5 Compute nodes            |
| Each node: r3.Large                                | Each node: dc1.Large                                         |
| Cluster1 with 50GB & Cluster2 with 500 GB dataset  | Two databases: First with 50 GB & second with 500 GB dataset |
| Load Data @50  GB: 35 Minutes                      | Load Data @50  GB: 42 Minutes                                |
| Load Data @500 GB: 3 Hours, 33 Minutes             | Load Data @500 GB: 8 Hours, 25 Minutes                       |


Load Data means populating metastore for Hive & copying data from S3 in case of RedShift.  

With three tables (store_sales, item, web_clickstream using distkey & sortkey, the ‘Load Data’ time increased to approx. 50 Min & 11 Hours respectively for Redshift.


## Queries
The following queries were executed against both systems with out of the box setup.

| Q#   | Description                                                                                                 |
| -----| ------------------------------------------------------------------------------------------------------------|
| 1    |Customer Purchase Behavior Analysis: Find all customers who viewed items of a given category on the web in a |
|      |given month and year that was followed by an in-store purchase of an item from the same category in the next |
|      |three consecutive months.                                                                                    |
| 2    |Market Basket Analysis: What are the items sold together frequently (more that 50 times), in certain store,  |
|      |within specified categories?                                                                                 |
| 3    |Customer Demographics and Sales Analysis: What is the Aggregate total amount of sold items over different    |
|      |types of combinations of customers based on selected groups of marital status, education status, sales price,|
|      |and different combinations of state and sales profit.                                                        |
| 4    |Product Returns Analysis: Find all items that were sold in stores in a given month and year and were         |
|      |returned in the next six months and re-purchased by the returning customer afterwards through the web sales  |
|      |channel in the next three years                                                                              |
| 5    |Over Priced Items Sales' Analysis: List top 10 states in descending order with at least 10 customers who     |
|      |during a given month bought products with the price tag at least 20% higher than the average price of the    |
|      |products in the same category.                                                                               |

## Performance Results (out of box setup)
The exeuction time in seconds for each of the above five queries is listed below for out of box setup. 

### Dataset 50 GB

| Q#   | Hive (Seconds) | Redshift (Seconds) |
| -----| ---------------|--------------------|
| 1    | 691            | 4.69               |
| 2    | 301            | 3.00               |
| 3    | 659            | 9.01               |
| 4    | 612            | 3.66               |
| 5    | 346            | 4.15               |

### Dataset 500 GB

| Q#   | Hive (Seconds) | Redshift (Seconds) |
| -----| ---------------|--------------------|
| 1    | 4701           |  4.71              |
| 2    | 2215           | 19.18              |
| 3    | 4285           | 14.52              |
| 4    | 4563           |  8.12              |
| 5    | 1639           | 22.52              |


For both datasets Redshift performed much better, compared to Hive, and it is due the query execution engines. Redshift is optimized for analytics workload. Redshift query engine generates C++ code, consisting of steps, segments and streams, to be executed by each compute node. In case of Hive, each query, potentially, results in multiple map-reduce jobs. Each map-reduce job spawns jvm and this results in significantly reduced execution performance. 

## Performance Improvements
The exeuction time in seconds for each of the above five queries is listed below for out of box setup. 











## Conclusions


