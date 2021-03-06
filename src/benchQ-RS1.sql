-- Q1 (q09) 
-- TASK:
-- Aggregate total amount of sold items over different given types of combinations of 
-- customers based on selected groups of marital status, education status, sales price  and   
-- different combinations of state and sales profit.
-- this is set to avoid Execution failed with exit status: 3 

SELECT SUM(ss1.ss_quantity)
FROM store_sales ss1, date_dim dd, customer_address ca1 , store s, customer_demographics cd
-- select date range
WHERE ss1.ss_sold_date_sk = dd.d_date_sk
AND dd.d_year=2001
AND ss1.ss_addr_sk = ca1.ca_address_sk
AND s.s_store_sk = ss1.ss_store_sk
AND cd.cd_demo_sk = ss1.ss_cdemo_sk
AND
(
  (
    cd.cd_marital_status = 'M'
    AND cd.cd_education_status = '4 yr Degree'
    AND 100 <= ss1.ss_sales_price
    AND ss1.ss_sales_price <= 150
  )
  OR
  (
    cd.cd_marital_status = 'M'
    AND cd.cd_education_status = '4 yr Degree'
    AND 50 <= ss1.ss_sales_price
    AND ss1.ss_sales_price <= 200
  )
  OR
  (
    cd.cd_marital_status = 'M'
    AND cd.cd_education_status = '4 yr Degree'
    AND 150 <= ss1.ss_sales_price
    AND ss1.ss_sales_price <= 200
  )
)
AND
(
  (
    ca1.ca_country = 'United States'
    AND ca1.ca_state IN ('KY', 'GA', 'NM')
    AND 0 <= ss1.ss_net_profit
    AND ss1.ss_net_profit <= 2000
  )
  OR
  (
    ca1.ca_country = 'United States'
    AND ca1.ca_state IN ('MT', 'OR', 'IN')
    AND 150 <= ss1.ss_net_profit
    AND ss1.ss_net_profit <= 3000
  )
  OR
  (
    ca1.ca_country = 'United States'
    AND ca1.ca_state IN ('WI', 'MO', 'WV')
    AND 50 <= ss1.ss_net_profit
    AND ss1.ss_net_profit <= 25000
  )
);

-- Q2 (q12) 
-- TASK:
-- Find all customers who viewed items of a given category on the web
-- in a given month and year that was followed by an in-store purchase of an item from the same category in the three
-- consecutive months.

SELECT DISTINCT wcs_user_sk -- Find all customers
FROM
( -- web_clicks viewed items in date range with items from specified categories
  SELECT
    wcs_user_sk,
    wcs_click_date_sk
  FROM web_clickstreams, item
  WHERE wcs_click_date_sk BETWEEN 37134 AND (37134 + 30) -- in a given month and year
  AND i_category IN ('Books', 'Electronics') -- filter given category
  AND wcs_item_sk = i_item_sk
  AND wcs_user_sk IS NOT NULL
  AND wcs_sales_sk IS NULL --only views, not purchases
) webInRange,
(  -- store sales in date range with items from specified categories
  SELECT
    ss_customer_sk,
    ss_sold_date_sk
  FROM store_sales, item
  WHERE ss_sold_date_sk BETWEEN 37134 AND (37134 + 90) -- in the three consecutive months.
  AND i_category IN ('Books', 'Electronics') -- filter given category
  AND ss_item_sk = i_item_sk
  AND ss_customer_sk IS NOT NULL
) storeInRange
-- join web and store
WHERE wcs_user_sk = ss_customer_sk
AND wcs_click_date_sk < ss_sold_date_sk -- buy AFTER viewed on website
ORDER BY wcs_user_sk;

--CLUSTER BY instead of ORDER BY does not work to achieve global ordering. e.g. 2 reducers: first reducer will write keys 0,2,4,6.. into file 000000_0 and reducer 2 will write keys 1,3,5,7,.. into file 000000_1.concatenating these files does not produces a deterministic result if number of reducer changes.
--Solution: parallel "order by" as non parallel version only uses a single reducer and we cant use "limit"

-- Q3 (q21) 
-- Get tll items that were sold in stores in a given month
-- and year and which were returned in the next 6 months and re-purchased by
-- the returning customer afterwards through the web sales channel in the 
-- following three years. For those items, compute the total quantity sold 
-- through the store, the quantity returned and the quantity purchased through
-- the web. Group this information by item and store.

SELECT
  part_i.i_item_id AS i_item_id,
  part_i.i_item_desc AS i_item_desc,
  part_s.s_store_id AS s_store_id,
  part_s.s_store_name AS s_store_name,
  SUM(part_ss.ss_quantity) AS store_sales_quantity,
  SUM(part_sr.sr_return_quantity) AS store_returns_quantity,
  SUM(part_ws.ws_quantity) AS web_sales_quantity
FROM (
	SELECT
	  sr_item_sk,
	  sr_customer_sk,
	  sr_ticket_number,
	  sr_return_quantity
	FROM
	  store_returns sr,
	  date_dim d2
	WHERE d2.d_year = 2003 
	AND d2.d_moy BETWEEN 6 AND 7 --which were returned in the next six months
 	AND sr.sr_returned_date_sk = d2.d_date_sk
) part_sr
INNER JOIN (
  SELECT
    ws_item_sk,
    ws_bill_customer_sk,
    ws_quantity
  FROM
    web_sales ws,
    date_dim d3
  WHERE d3.d_year BETWEEN 2003 AND 2005 -- in the following three years (re-purchased by the returning customer afterwards through the web sales channel)
  AND ws.ws_sold_date_sk = d3.d_date_sk
) part_ws ON (
  part_sr.sr_item_sk = part_ws.ws_item_sk
  AND part_sr.sr_customer_sk = part_ws.ws_bill_customer_sk
)
INNER JOIN (
  SELECT
    ss_item_sk,
    ss_store_sk,
    ss_customer_sk,
    ss_ticket_number,
    ss_quantity
  FROM
    store_sales ss,
    date_dim d1
  WHERE d1.d_year = 2003
  AND d1.d_moy = 1 
  AND ss.ss_sold_date_sk = d1.d_date_sk
) part_ss ON (
  part_ss.ss_ticket_number = part_sr.sr_ticket_number
  AND part_ss.ss_item_sk = part_sr.sr_item_sk
  AND part_ss.ss_customer_sk = part_sr.sr_customer_sk
)
INNER JOIN store part_s ON (
  part_s.s_store_sk = part_ss.ss_store_sk
)
INNER JOIN item part_i ON (
  part_i.i_item_sk = part_ss.ss_item_sk
)
GROUP BY
  part_i.i_item_id,
  part_i.i_item_desc,
  part_s.s_store_id,
  part_s.s_store_name
ORDER BY
  part_i.i_item_id,
  part_i.i_item_desc,
  part_s.s_store_id,
  part_s.s_store_name
LIMIT 100;

-- Q4 (q07) 
-- TASK:
-- List top 10 states in descending order with at least 10 customers who during
-- a given month bought products with the price tag at least 20% higher than the
-- average price of products in the same category.

-- 
-- Create helper table: items with 20% higher then avg prices of product from same category
DROP TABLE IF EXISTS q07HigherPriceItems;
-- "price tag at least 20% higher than the average price of products in the same category."

CREATE TABLE q07HigherPriceItems AS
SELECT k.i_item_sk
FROM item k,
(
  SELECT
    i_category,
    AVG(j.i_current_price) * 1.20 AS avg_price
  FROM item j
  GROUP BY j.i_category
) avgCategoryPrice
WHERE avgCategoryPrice.i_category = k.i_category
AND k.i_current_price > avgCategoryPrice.avg_price
;

-- describe q07HigherPriceItems;
-- select * from q07HigherPriceItems limit 100;

SELECT
  ca_state,
  COUNT(*)
FROM
  customer_address a,
  customer c,
  store_sales s,
  q07HigherPriceItems
WHERE a.ca_address_sk = c.c_current_addr_sk
AND c.c_customer_sk = s.ss_customer_sk
AND ca_state IS NOT NULL
AND ss_item_sk = q07HigherPriceItems.i_item_sk --cannot use "ss_item_sk IN ()". Hive only supports a single "IN" subquery per SQL statement.
AND s.ss_sold_date_sk IN
( --during a given month
  SELECT d_date_sk
  FROM date_dim
  WHERE d_year = 2004
  AND d_moy = 7
)
GROUP BY ca_state
HAVING COUNT(*) >= 10 --at least 10 customers
ORDER BY COUNT(*) DESC, ca_state --top 10 states in descending order
LIMIT 10
;

-- Q5 (q01) Items sold together (frequently i.e. more that 50 times), in certain store, 
-- with specified categories & limit to 100.
select pairs.itm1, pairs.itm2, COUNT(*)
from 
  (select soldTogether.itm1, soldTogether.itm2
  from 
     (select ss1.ss_item_sk as itm1, ss2.ss_item_sk as itm2
     from store_sales ss1, store_sales ss2
     where (ss1.ss_ticket_number = ss2.ss_ticket_number and ss1.ss_item_sk < ss2.ss_item_sk 
            AND ss1.ss_store_sk IN (10, 20, 33, 40, 50))) as soldTogether, item i 
   where soldTogether.itm1 = i.i_item_sk AND i.i_category_id IN (1, 2, 3)) as pairs
group by pairs.itm1, pairs.itm2
having COUNT(*) > 50
order by COUNT(*) desc, pairs.itm1, pairs.itm2
limit 100;

