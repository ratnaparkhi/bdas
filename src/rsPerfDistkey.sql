- Redshift performance improvement 
-- Check the 'explain' plan and improve performance. 
-- Added distribution style KEY using distkey - item_sk 
-- on three tables - item, store_sales, web_clickstreams 

-- Items sold together (frequently i.e. more that 50 times), in certain store, 
-- with specified categories & limit to 100.
explain select pairs.itm1, pairs.itm2, COUNT(*)
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

-- DS-BCAST_INNER is happening twice.
-- ->  XN Hash Join DS_BCAST_INNER  (cost=5010662696.95..234476789190.80 rows=7435605723 width=16)


select * from pg_table_def where tablename = 'store_sales';
select * from pg_table_def where tablename = 'item';


DROP TABLE IF EXISTS item;
CREATE  TABLE item
  ( i_item_sk                 bigint         sortkey distkey     --not null
  , i_item_id                 varchar              --not null
  , i_rec_start_date          varchar
  , i_rec_end_date            varchar
  , i_item_desc               varchar
  , i_current_price           decimal(7,2)
  , i_wholesale_cost          decimal(7,2)
  , i_brand_id                int
  , i_brand                   varchar
  , i_class_id                int
  , i_class                   varchar
  , i_category_id             int
  , i_category                varchar
  , i_manufact_id             int
  , i_manufact                varchar
  , i_size                    varchar
  , i_formulation             varchar
  , i_color                   varchar
  , i_units                   varchar
  , i_container               varchar
  , i_manager_id              int
  , i_product_name            varchar
  )
;

DROP TABLE IF EXISTS store_sales;
CREATE  TABLE store_sales
  ( ss_sold_date_sk           bigint
  , ss_sold_time_sk           bigint
  , ss_item_sk                bigint    distkey            --not null
  , ss_customer_sk            bigint
  , ss_cdemo_sk               bigint
  , ss_hdemo_sk               bigint
  , ss_addr_sk                bigint
  , ss_store_sk               bigint
  , ss_promo_sk               bigint
  , ss_ticket_number          bigint    sortkey            --not null
  , ss_quantity               int
  , ss_wholesale_cost         decimal(7,2)
  , ss_list_price             decimal(7,2)
  , ss_sales_price            decimal(7,2)
  , ss_ext_discount_amt       decimal(7,2)
  , ss_ext_sales_price        decimal(7,2)
  , ss_ext_wholesale_cost     decimal(7,2)
  , ss_ext_list_price         decimal(7,2)
  , ss_ext_tax                decimal(7,2)
  , ss_coupon_amt             decimal(7,2)
  , ss_net_paid               decimal(7,2)
  , ss_net_paid_inc_tax       decimal(7,2)
  , ss_net_profit             decimal(7,2)
  )
;

select count(*) from store_sales;
select count(*) from item;
select count(*) from web_clickstreams;

-- Find customer who view online and buy in stores

Explain SELECT DISTINCT wcs_user_sk -- Find all customers
FROM
( -- web_clicks viewed items in date range with items from specified categories
  SELECT
    wcs_user_sk,
    wcs_click_date_sk
  FROM web_clickstreams, item
  WHERE wcs_click_date_sk BETWEEN 37134 AND (37134 + 30) -- in a given month and year
  AND i_category IN ('Books', 'Electronics') -- filter given category
  AND wcs_item_sk = i_item_sk -- Joins web_clickstreams & item
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


-- Explain shows   XN Hash Join DS_BCAST_INNER  (cost=787.18..2575355339.29 rows=90997 width=16)
--                                 ->  XN Hash  (cost=747.12..747.12 rows=16025 width=8)
--                                       Hash Cond: ("outer".wcs_item_sk = "inner".i_item_sk)


select * from pg_table_def where tablename = 'web_clickstreams';
select * from pg_table_def where tablename = 'item';


DROP TABLE IF EXISTS web_clickstreams;
CREATE  TABLE web_clickstreams
(   wcs_click_date_sk       bigint sortkey
  , wcs_click_time_sk       bigint 
  , wcs_sales_sk            bigint
  , wcs_item_sk             bigint distkey
  , wcs_web_page_sk         bigint
  , wcs_user_sk             bigint
  )
;


-- 8
copy web_clickstreams from 's3://ppr-bdas-data/d50/web_clickstreams/web_clickstreams_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_clickstreams from 's3://ppr-bdas-data/d50/web_clickstreams/web_clickstreams_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_clickstreams from 's3://ppr-bdas-data/d50/web_clickstreams/web_clickstreams_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_clickstreams from 's3://ppr-bdas-data/d50/web_clickstreams/web_clickstreams_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_clickstreams from 's3://ppr-bdas-data/d50/web_clickstreams/web_clickstreams_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_clickstreams from 's3://ppr-bdas-data/d50/web_clickstreams/web_clickstreams_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_clickstreams from 's3://ppr-bdas-data/d50/web_clickstreams/web_clickstreams_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_clickstreams from 's3://ppr-bdas-data/d50/web_clickstreams/web_clickstreams_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';


-- 8 load item
copy item from 's3://ppr-bdas-data/d50/item/item_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item from 's3://ppr-bdas-data/d50/item/item_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item from 's3://ppr-bdas-data/d50/item/item_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item from 's3://ppr-bdas-data/d50/item/item_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item from 's3://ppr-bdas-data/d50/item/item_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item from 's3://ppr-bdas-data/d50/item/item_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item from 's3://ppr-bdas-data/d50/item/item_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item from 's3://ppr-bdas-data/d50/item/item_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';


-- 8 load store_sales

copy store_sales from 's3://ppr-bdas-data/d50/store_sales/store_sales_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_sales from 's3://ppr-bdas-data/d50/store_sales/store_sales_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_sales from 's3://ppr-bdas-data/d50/store_sales/store_sales_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_sales from 's3://ppr-bdas-data/d50/store_sales/store_sales_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_sales from 's3://ppr-bdas-data/d50/store_sales/store_sales_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_sales from 's3://ppr-bdas-data/d50/store_sales/store_sales_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_sales from 's3://ppr-bdas-data/d50/store_sales/store_sales_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_sales from 's3://ppr-bdas-data/d50/store_sales/store_sales_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';



-----------test runs 


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

-- first run
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

-- 2nd run 
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

