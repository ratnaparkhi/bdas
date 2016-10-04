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
| 1    | 301            | 3.00               |
| 2    | 346            | 4.15               |
| 3    | 691            | 4.69               |
| 4    | 659            | 9.01               |
| 5    | 612            | 3.66               |

### Dataset 500 GB

| Q#   | Hive (Seconds) | Redshift (Seconds) |
| -----| ---------------|--------------------|
| 1    | 2215           | 19.18              |
| 2    | 1639           | 22.52              |
| 3    | 4701           |  4.71              |
| 4    | 4285           | 14.52              |
| 5    | 4563           |  8.12              |


For both datasets Redshift performed much better, compared to Hive, and it is due the query execution engines. Redshift is optimized for analytics workload. Redshift query engine generates C++ code, consisting of steps, segments and streams, to be executed by each compute node. In case of Hive, each query, potentially, results in multiple map-reduce jobs. Each map-reduce job spawns jvm and this results in significantly reduced execution performance. 

## Performance Improvements

### Hive
In case of Hive, spark-sql was used to improve performance. spark-sql works with Hive metastore, is compatible with HIVE-QL and it uses spark libraries, RDDs and in memory way of execution of spark. 

### Redshift 
Two queries (Customer purchase behavior analysis and Market basket analysis) were analyzed further using 'Explain sql-statement'. It gives the query plan of execution. DS_BCAST_BOTH step was noted due to join on web_clickstreams & item in case of query1. This results in data movement (to compute nodes) during query exeuction, and is an expensive step. In order to avoid this run-time data movement, Redshift recomments usage of 'distkey' (KEY style of distribution). Hence item_sk field is defined as 'distkey' on all the three tables item, store_sales and web_clickstreams. Once, distkey is defined, Redshit, during data load operation, co-locates the rows with matching values of distkey (item_sk) in this case. So item, store_sales rows with matching item_sk and item, web_clickstreams rows with matching item_sk are located together on compute nodes during data load. At run time when a query joins store_sales, item on item_sk, now, no data movement happens. 

It should be noted that only one disteky can be defined per table, and it results in increased load time. When item_sk was defined as distkey on three tables - item, web_sales and web_clickstreams, (i) for 50 GB dataset load time increased 42 minutes to 50 minutes and 
(ii) for 500 GB dataset load time increased from 8 hours 25 minutes to 11 hours.

### Performance improvement after using spark-sql and diskey are shown below

### Dataset 50 GB

| Q#   | Hive (Seconds) | Redshift (Seconds) | spark-sql w/Hive metastore  (seconds)| Redshift w/distkey (seconds)|
| -----| ---------------|--------------------|--------------------------------------| ----------------------------|
| 1    | 301            | 3.00               | 203 (down 33%)                       | 3.00 (no change)            |
| 2    | 346            | 4.15               |  79 (down 77%)                       | 2.25 (down 46% )            | 

### Dataset 500 GB

| Q#   | Hive (Seconds) | Redshift (Seconds) | spark-sql w/Hive metastore  (seconds)| Redshift w/distkey (seconds)|
| -----| ---------------|--------------------|--------------------------------------| ----------------------------|
| 1    | 2215           | 19.18              | 1901 (down 14%)                      | 14.86 (down 22%)            |
| 2    | 1639           | 22.52              |  729 (down 56%)                      | 13.95 (down 38%)           | 


## Conclusions

Redshift performed much better with 'out of the box' setup as well as with bit of performance tuning. Redshift is easy to setup and to kickstart the datawarehouse. However, certain limitations and design issues need to be mentioned. 
(i) Data size and number nodes - Redshift supports upto 2 PB of data storage with max number of 128 compute nodes in the cluster. 
(ii) Distribution style (KEY using distkeys, EVEN (default) or ALL) needs to decided before loading the data for optimal join performance. Only one distkey per table is allowed. Hence, queries have to be anticipated. Otherwise, ALL style of distribution is recommended (if needed). ALL style of distribution results in data duplication on all compute nodes for the particular table at load time. 

With this in mind following use cases are identified. 

| If requirements are:                                  | Then use:  | Examples include:                               |
| ------------------------------------------------------|------------|-------------------------------------------------|
| Ease of use, low mainteance, high performance         | Redshift   | Companies with SaaS offerings, most startups    | 
| scalability in TB range                               |            |                                                 |
| Replacement of traditional DW platform to move to     | Redshift   | Large enterprises Finra, NTT docomo             | 
| cloud, good price performance, data in TB range       |            |                                                 |
| Massive amount data (many PBs), no vendor lock-in     | Hive       | Facebook, Sears and companies with existing     | 
| in-house data due to regulatory reasons               |            | big data infrastructure and staff               |










