-- create benchmark schema
DROP TABLE IF EXISTS customer;
CREATE TABLE customer
  ( c_customer_sk             bigint              --not null
  , c_customer_id             varchar              --not null
  , c_current_cdemo_sk        bigint
  , c_current_hdemo_sk        bigint
  , c_current_addr_sk         bigint
  , c_first_shipto_date_sk    bigint
  , c_first_sales_date_sk     bigint
  , c_salutation              varchar
  , c_first_name              varchar
  , c_last_name               varchar
  , c_preferred_cust_flag     varchar
  , c_birth_day               int
  , c_birth_month             int
  , c_birth_year              int
  , c_birth_country           varchar
  , c_login                   varchar
  , c_email_address           varchar
  , c_last_review_date        varchar
  );

DROP TABLE IF EXISTS customer_address;
CREATE TABLE customer_address
  ( ca_address_sk             bigint              --not null
  , ca_address_id             varchar              --not null
  , ca_street_number          varchar
  , ca_street_name            varchar
  , ca_street_type            varchar
  , ca_suite_number           varchar
  , ca_city                   varchar
  , ca_county                 varchar
  , ca_state                  varchar
  , ca_zip                    varchar
  , ca_country                varchar
  , ca_gmt_offset             decimal(5,2)
  , ca_location_type          varchar
  );

DROP TABLE IF EXISTS customer_demographics;
CREATE  TABLE customer_demographics
  ( cd_demo_sk                bigint                ----not null
  , cd_gender                 varchar
  , cd_marital_status         varchar
  , cd_education_status       varchar
  , cd_purchase_estimate      int
  , cd_credit_rating          varchar
  , cd_dep_count              int
  , cd_dep_employed_count     int
  , cd_dep_college_count      int
  );

DROP TABLE IF EXISTS date_dim;
CREATE  TABLE date_dim
  ( d_date_sk                 bigint              --not null
  , d_date_id                 varchar              --not null
  , d_date                    varchar
  , d_month_seq               int
  , d_week_seq                int
  , d_quarter_seq             int
  , d_year                    int
  , d_dow                     int
  , d_moy                     int
  , d_dom                     int
  , d_qoy                     int
  , d_fy_year                 int
  , d_fy_quarter_seq          int
  , d_fy_week_seq             int
  , d_day_name                varchar
  , d_quarter_name            varchar
  , d_holiday                 varchar
  , d_weekend                 varchar
  , d_following_holiday       varchar
  , d_first_dom               int
  , d_last_dom                int
  , d_same_day_ly             int
  , d_same_day_lq             int
  , d_current_day             varchar
  , d_current_week            varchar
  , d_current_month           varchar
  , d_current_quarter         varchar
  , d_current_year            varchar
  )
;

DROP TABLE IF EXISTS household_demographics;
CREATE  TABLE household_demographics
  ( hd_demo_sk                bigint                --not null
  , hd_income_band_sk         bigint
  , hd_buy_potential          varchar
  , hd_dep_count              int
  , hd_vehicle_count          int
  )
;

DROP TABLE IF EXISTS income_band;
CREATE  TABLE income_band
  ( ib_income_band_sk         bigint              --not null
  , ib_lower_bound            int
  , ib_upper_bound            int
  )
;

DROP TABLE IF EXISTS item;
CREATE  TABLE item
  ( i_item_sk                 bigint              --not null
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

DROP TABLE IF EXISTS promotion;
CREATE  TABLE promotion
  ( p_promo_sk                bigint              --not null
  , p_promo_id                varchar              --not null
  , p_start_date_sk           bigint
  , p_end_date_sk             bigint
  , p_item_sk                 bigint
  , p_cost                    decimal(15,2)
  , p_response_target         int
  , p_promo_name              varchar
  , p_channel_dmail           varchar
  , p_channel_email           varchar
  , p_channel_catalog         varchar
  , p_channel_tv              varchar
  , p_channel_radio           varchar
  , p_channel_press           varchar
  , p_channel_event           varchar
  , p_channel_demo            varchar
  , p_channel_details         varchar
  , p_purpose                 varchar
  , p_discount_active         varchar
  )
;

DROP TABLE IF EXISTS reason;
CREATE  TABLE reason
  ( r_reason_sk               bigint              --not null
  , r_reason_id               varchar              --not null
  , r_reason_desc             varchar(1000)
  )
;

DROP TABLE IF EXISTS ship_mode;
CREATE  TABLE ship_mode
  ( sm_ship_mode_sk           bigint              --not null
  , sm_ship_mode_id           varchar              --not null
  , sm_type                   varchar
  , sm_code                   varchar
  , sm_carrier                varchar
  , sm_contract               varchar
  )
;

DROP TABLE IF EXISTS store;
CREATE  TABLE store
  ( s_store_sk                bigint              --not null
  , s_store_id                varchar              --not null
  , s_rec_start_date          varchar
  , s_rec_end_date            varchar
  , s_closed_date_sk          bigint
  , s_store_name              varchar
  , s_number_employees        int
  , s_floor_space             int
  , s_hours                   varchar
  , s_manager                 varchar
  , s_market_id               int
  , s_geography_class         varchar
  , s_market_desc             varchar
  , s_market_manager          varchar
  , s_division_id             int
  , s_division_name           varchar
  , s_company_id              int
  , s_company_name            varchar
  , s_street_number           varchar
  , s_street_name             varchar
  , s_street_type             varchar
  , s_suite_number            varchar
  , s_city                    varchar
  , s_county                  varchar
  , s_state                   varchar
  , s_zip                     varchar
  , s_country                 varchar
  , s_gmt_offset              decimal(5,2)
  , s_tax_precentage          decimal(5,2)
  )
;

DROP TABLE IF EXISTS time_dim;
CREATE  TABLE time_dim
  ( t_time_sk                 bigint              --not null
  , t_time_id                 varchar              --not null
  , t_time                    int
  , t_hour                    int
  , t_minute                  int
  , t_second                  int
  , t_am_pm                   varchar
  , t_shift                   varchar
  , t_sub_shift               varchar
  , t_meal_time               varchar
  )
;

DROP TABLE IF EXISTS warehouse;
CREATE  TABLE warehouse
  ( w_warehouse_sk            bigint              --not null
  , w_warehouse_id            varchar              --not null
  , w_warehouse_name          varchar
  , w_warehouse_sq_ft         int
  , w_street_number           varchar
  , w_street_name             varchar
  , w_street_type             varchar
  , w_suite_number            varchar
  , w_city                    varchar
  , w_county                  varchar
  , w_state                   varchar
  , w_zip                     varchar
  , w_country                 varchar
  , w_gmt_offset              decimal(5,2)
  )
;

DROP TABLE IF EXISTS web_site;
CREATE  TABLE web_site
  ( web_site_sk               bigint              --not null
  , web_site_id               varchar              --not null
  , web_rec_start_date        varchar
  , web_rec_end_date          varchar
  , web_name                  varchar
  , web_open_date_sk          bigint
  , web_close_date_sk         bigint
  , web_class                 varchar
  , web_manager               varchar
  , web_mkt_id                int
  , web_mkt_class             varchar
  , web_mkt_desc              varchar
  , web_market_manager        varchar
  , web_company_id            int
  , web_company_name          varchar
  , web_street_number         varchar
  , web_street_name           varchar
  , web_street_type           varchar
  , web_suite_number          varchar
  , web_city                  varchar
  , web_county                varchar
  , web_state                 varchar
  , web_zip                   varchar
  , web_country               varchar
  , web_gmt_offset            decimal(5,2)
  , web_tax_percentage        decimal(5,2)
  )
;

DROP TABLE IF EXISTS web_page;
CREATE  TABLE web_page
  ( wp_web_page_sk            bigint              --not null
  , wp_web_page_id            varchar              --not null
  , wp_rec_start_date         varchar
  , wp_rec_end_date           varchar
  , wp_creation_date_sk       bigint
  , wp_access_date_sk         bigint
  , wp_autogen_flag           varchar
  , wp_customer_sk            bigint
  , wp_url                    varchar
  , wp_type                   varchar
  , wp_char_count             int
  , wp_link_count             int
  , wp_image_count            int
  , wp_max_ad_count           int
  )
;

DROP TABLE IF EXISTS inventory;
CREATE  TABLE inventory
  ( inv_date_sk               bigint                --not null
  , inv_item_sk               bigint                --not null
  , inv_warehouse_sk          bigint                --not null
  , inv_quantity_on_hand      int
  )
;

DROP TABLE IF EXISTS store_sales;
CREATE  TABLE store_sales
  ( ss_sold_date_sk           bigint
  , ss_sold_time_sk           bigint
  , ss_item_sk                bigint                --not null
  , ss_customer_sk            bigint
  , ss_cdemo_sk               bigint
  , ss_hdemo_sk               bigint
  , ss_addr_sk                bigint
  , ss_store_sk               bigint
  , ss_promo_sk               bigint
  , ss_ticket_number          bigint                --not null
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

DROP TABLE IF EXISTS store_returns;
CREATE  TABLE store_returns
  ( sr_returned_date_sk       bigint
  , sr_return_time_sk         bigint
  , sr_item_sk                bigint                --not null
  , sr_customer_sk            bigint
  , sr_cdemo_sk               bigint
  , sr_hdemo_sk               bigint
  , sr_addr_sk                bigint
  , sr_store_sk               bigint
  , sr_reason_sk              bigint
  , sr_ticket_number          bigint                --not null
  , sr_return_quantity        int
  , sr_return_amt             decimal(7,2)
  , sr_return_tax             decimal(7,2)
  , sr_return_amt_inc_tax     decimal(7,2)
  , sr_fee                    decimal(7,2)
  , sr_return_ship_cost       decimal(7,2)
  , sr_refunded_cash          decimal(7,2)
  , sr_reversed_charge        decimal(7,2)
  , sr_store_credit           decimal(7,2)
  , sr_net_loss               decimal(7,2)
  )
;

DROP TABLE IF EXISTS web_sales;
CREATE  TABLE web_sales
  ( ws_sold_date_sk           bigint
  , ws_sold_time_sk           bigint
  , ws_ship_date_sk           bigint
  , ws_item_sk                bigint                --not null
  , ws_bill_customer_sk       bigint
  , ws_bill_cdemo_sk          bigint
  , ws_bill_hdemo_sk          bigint
  , ws_bill_addr_sk           bigint
  , ws_ship_customer_sk       bigint
  , ws_ship_cdemo_sk          bigint
  , ws_ship_hdemo_sk          bigint
  , ws_ship_addr_sk           bigint
  , ws_web_page_sk            bigint
  , ws_web_site_sk            bigint
  , ws_ship_mode_sk           bigint
  , ws_warehouse_sk           bigint
  , ws_promo_sk               bigint
  , ws_order_number           bigint                --not null
  , ws_quantity               int
  , ws_wholesale_cost         decimal(7,2)
  , ws_list_price             decimal(7,2)
  , ws_sales_price            decimal(7,2)
  , ws_ext_discount_amt       decimal(7,2)
  , ws_ext_sales_price        decimal(7,2)
  , ws_ext_wholesale_cost     decimal(7,2)
  , ws_ext_list_price         decimal(7,2)
  , ws_ext_tax                decimal(7,2)
  , ws_coupon_amt             decimal(7,2)
  , ws_ext_ship_cost          decimal(7,2)
  , ws_net_paid               decimal(7,2)
  , ws_net_paid_inc_tax       decimal(7,2)
  , ws_net_paid_inc_ship      decimal(7,2)
  , ws_net_paid_inc_ship_tax  decimal(7,2)
  , ws_net_profit             decimal(7,2)
  )
;

DROP TABLE IF EXISTS web_returns;
CREATE  TABLE web_returns
  ( wr_returned_date_sk       bigint
  , wr_returned_time_sk       bigint
  , wr_item_sk                bigint                --not null
  , wr_refunded_customer_sk   bigint
  , wr_refunded_cdemo_sk      bigint
  , wr_refunded_hdemo_sk      bigint
  , wr_refunded_addr_sk       bigint
  , wr_returning_customer_sk  bigint
  , wr_returning_cdemo_sk     bigint
  , wr_returning_hdemo_sk     bigint
  , wr_returning_addr_sk      bigint
  , wr_web_page_sk            bigint
  , wr_reason_sk              bigint
  , wr_order_number           bigint                --not null
  , wr_return_quantity        int
  , wr_return_amt             decimal(7,2)
  , wr_return_tax             decimal(7,2)
  , wr_return_amt_inc_tax     decimal(7,2)
  , wr_fee                    decimal(7,2)
  , wr_return_ship_cost       decimal(7,2)
  , wr_refunded_cash          decimal(7,2)
  , wr_reversed_charge        decimal(7,2)
  , wr_account_credit         decimal(7,2)
  , wr_net_loss               decimal(7,2)
  )
;

DROP TABLE IF EXISTS item_marketprices;
CREATE  TABLE item_marketprices
  ( imp_sk                  bigint                --not null
  , imp_item_sk             bigint                --not null
  , imp_competitor          varchar
  , imp_competitor_price    decimal(7,2)
  , imp_start_date          bigint
  , imp_end_date            bigint
  )
 ;

DROP TABLE IF EXISTS web_clickstreams;
CREATE  TABLE web_clickstreams
(   wcs_click_date_sk       bigint
  , wcs_click_time_sk       bigint
  , wcs_sales_sk            bigint
  , wcs_item_sk             bigint
  , wcs_web_page_sk         bigint
  , wcs_user_sk             bigint
  )
;

DROP TABLE IF EXISTS product_reviews;
CREATE  TABLE product_reviews
(   pr_review_sk            bigint              --not null
  , pr_review_date          varchar
  , pr_review_time          varchar
  , pr_review_rating        int                 --not null
  , pr_item_sk              bigint              --not null
  , pr_user_sk              bigint
  , pr_order_sk             bigint
  , pr_review_content       varchar     --not null
  )
;

--- Load data from S3

-- 8
copy customer from 's3://ppr-bdas-data/d50/customer/customer_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer from 's3://ppr-bdas-data/d50/customer/customer_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer from 's3://ppr-bdas-data/d50/customer/customer_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer from 's3://ppr-bdas-data/d50/customer/customer_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer from 's3://ppr-bdas-data/d50/customer/customer_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer from 's3://ppr-bdas-data/d50/customer/customer_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer from 's3://ppr-bdas-data/d50/customer/customer_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer from 's3://ppr-bdas-data/d50/customer/customer_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 8
copy customer_address from 's3://ppr-bdas-data/d50/customer_address/customer_address_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer_address from 's3://ppr-bdas-data/d50/customer_address/customer_address_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer_address from 's3://ppr-bdas-data/d50/customer_address/customer_address_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer_address from 's3://ppr-bdas-data/d50/customer_address/customer_address_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer_address from 's3://ppr-bdas-data/d50/customer_address/customer_address_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer_address from 's3://ppr-bdas-data/d50/customer_address/customer_address_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer_address from 's3://ppr-bdas-data/d50/customer_address/customer_address_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy customer_address from 's3://ppr-bdas-data/d50/customer_address/customer_address_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 1
copy customer_demographics from 's3://ppr-bdas-data/d50/customer_demographics/customer_demographics_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 1
copy date_dim from 's3://ppr-bdas-data/d50/date_dim/date_dim_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 1
copy household_demographics from 's3://ppr-bdas-data/d50/household_demographics/household_demographics_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 8
copy income_band from 's3://ppr-bdas-data/d50/income_band/income_band_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy income_band from 's3://ppr-bdas-data/d50/income_band/income_band_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy income_band from 's3://ppr-bdas-data/d50/income_band/income_band_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy income_band from 's3://ppr-bdas-data/d50/income_band/income_band_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy income_band from 's3://ppr-bdas-data/d50/income_band/income_band_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy income_band from 's3://ppr-bdas-data/d50/income_band/income_band_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy income_band from 's3://ppr-bdas-data/d50/income_band/income_band_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy income_band from 's3://ppr-bdas-data/d50/income_band/income_band_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 8
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

-- 8
copy promotion from 's3://ppr-bdas-data/d50/promotion/promotion_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy promotion from 's3://ppr-bdas-data/d50/promotion/promotion_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy promotion from 's3://ppr-bdas-data/d50/promotion/promotion_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy promotion from 's3://ppr-bdas-data/d50/promotion/promotion_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy promotion from 's3://ppr-bdas-data/d50/promotion/promotion_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy promotion from 's3://ppr-bdas-data/d50/promotion/promotion_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy promotion from 's3://ppr-bdas-data/d50/promotion/promotion_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy promotion from 's3://ppr-bdas-data/d50/promotion/promotion_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 8
copy reason from 's3://ppr-bdas-data/d50/reason/reason_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy reason from 's3://ppr-bdas-data/d50/reason/reason_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy reason from 's3://ppr-bdas-data/d50/reason/reason_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy reason from 's3://ppr-bdas-data/d50/reason/reason_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy reason from 's3://ppr-bdas-data/d50/reason/reason_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy reason from 's3://ppr-bdas-data/d50/reason/reason_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy reason from 's3://ppr-bdas-data/d50/reason/reason_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy reason from 's3://ppr-bdas-data/d50/reason/reason_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 8
copy ship_mode from 's3://ppr-bdas-data/d50/ship_mode/ship_mode_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy ship_mode from 's3://ppr-bdas-data/d50/ship_mode/ship_mode_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy ship_mode from 's3://ppr-bdas-data/d50/ship_mode/ship_mode_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy ship_mode from 's3://ppr-bdas-data/d50/ship_mode/ship_mode_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy ship_mode from 's3://ppr-bdas-data/d50/ship_mode/ship_mode_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy ship_mode from 's3://ppr-bdas-data/d50/ship_mode/ship_mode_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy ship_mode from 's3://ppr-bdas-data/d50/ship_mode/ship_mode_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy ship_mode from 's3://ppr-bdas-data/d50/ship_mode/ship_mode_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 8
copy store from 's3://ppr-bdas-data/d50/store/store_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store from 's3://ppr-bdas-data/d50/store/store_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store from 's3://ppr-bdas-data/d50/store/store_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store from 's3://ppr-bdas-data/d50/store/store_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store from 's3://ppr-bdas-data/d50/store/store_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store from 's3://ppr-bdas-data/d50/store/store_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store from 's3://ppr-bdas-data/d50/store/store_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store from 's3://ppr-bdas-data/d50/store/store_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 1
copy time_dim from 's3://ppr-bdas-data/d50/time_dim/time_dim_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 8
copy warehouse from 's3://ppr-bdas-data/d50/warehouse/warehouse_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy warehouse from 's3://ppr-bdas-data/d50/warehouse/warehouse_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy warehouse from 's3://ppr-bdas-data/d50/warehouse/warehouse_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy warehouse from 's3://ppr-bdas-data/d50/warehouse/warehouse_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy warehouse from 's3://ppr-bdas-data/d50/warehouse/warehouse_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy warehouse from 's3://ppr-bdas-data/d50/warehouse/warehouse_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy warehouse from 's3://ppr-bdas-data/d50/warehouse/warehouse_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy warehouse from 's3://ppr-bdas-data/d50/warehouse/warehouse_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 8
copy web_site from 's3://ppr-bdas-data/d50/web_site/web_site_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_site from 's3://ppr-bdas-data/d50/web_site/web_site_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_site from 's3://ppr-bdas-data/d50/web_site/web_site_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_site from 's3://ppr-bdas-data/d50/web_site/web_site_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_site from 's3://ppr-bdas-data/d50/web_site/web_site_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_site from 's3://ppr-bdas-data/d50/web_site/web_site_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_site from 's3://ppr-bdas-data/d50/web_site/web_site_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_site from 's3://ppr-bdas-data/d50/web_site/web_site_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 8
copy web_page from 's3://ppr-bdas-data/d50/web_page/web_page_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_page from 's3://ppr-bdas-data/d50/web_page/web_page_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_page from 's3://ppr-bdas-data/d50/web_page/web_page_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_page from 's3://ppr-bdas-data/d50/web_page/web_page_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_page from 's3://ppr-bdas-data/d50/web_page/web_page_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_page from 's3://ppr-bdas-data/d50/web_page/web_page_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_page from 's3://ppr-bdas-data/d50/web_page/web_page_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_page from 's3://ppr-bdas-data/d50/web_page/web_page_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 8
copy inventory from 's3://ppr-bdas-data/d50/inventory/inventory_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy inventory from 's3://ppr-bdas-data/d50/inventory/inventory_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy inventory from 's3://ppr-bdas-data/d50/inventory/inventory_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy inventory from 's3://ppr-bdas-data/d50/inventory/inventory_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy inventory from 's3://ppr-bdas-data/d50/inventory/inventory_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy inventory from 's3://ppr-bdas-data/d50/inventory/inventory_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy inventory from 's3://ppr-bdas-data/d50/inventory/inventory_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy inventory from 's3://ppr-bdas-data/d50/inventory/inventory_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

--
-- 8
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

-- 8 
copy store_returns from 's3://ppr-bdas-data/d50/store_returns/store_returns_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_returns from 's3://ppr-bdas-data/d50/store_returns/store_returns_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_returns from 's3://ppr-bdas-data/d50/store_returns/store_returns_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_returns from 's3://ppr-bdas-data/d50/store_returns/store_returns_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_returns from 's3://ppr-bdas-data/d50/store_returns/store_returns_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_returns from 's3://ppr-bdas-data/d50/store_returns/store_returns_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_returns from 's3://ppr-bdas-data/d50/store_returns/store_returns_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy store_returns from 's3://ppr-bdas-data/d50/store_returns/store_returns_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 8
copy web_sales from 's3://ppr-bdas-data/d50/web_sales/web_sales_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_sales from 's3://ppr-bdas-data/d50/web_sales/web_sales_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_sales from 's3://ppr-bdas-data/d50/web_sales/web_sales_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_sales from 's3://ppr-bdas-data/d50/web_sales/web_sales_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_sales from 's3://ppr-bdas-data/d50/web_sales/web_sales_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_sales from 's3://ppr-bdas-data/d50/web_sales/web_sales_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_sales from 's3://ppr-bdas-data/d50/web_sales/web_sales_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_sales from 's3://ppr-bdas-data/d50/web_sales/web_sales_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 8 
copy web_returns from 's3://ppr-bdas-data/d50/web_returns/web_returns_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_returns from 's3://ppr-bdas-data/d50/web_returns/web_returns_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_returns from 's3://ppr-bdas-data/d50/web_returns/web_returns_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_returns from 's3://ppr-bdas-data/d50/web_returns/web_returns_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_returns from 's3://ppr-bdas-data/d50/web_returns/web_returns_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_returns from 's3://ppr-bdas-data/d50/web_returns/web_returns_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_returns from 's3://ppr-bdas-data/d50/web_returns/web_returns_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy web_returns from 's3://ppr-bdas-data/d50/web_returns/web_returns_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

-- 8 
copy item_marketprices from 's3://ppr-bdas-data/d50/item_marketprices/item_marketprices_1.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item_marketprices from 's3://ppr-bdas-data/d50/item_marketprices/item_marketprices_2.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item_marketprices from 's3://ppr-bdas-data/d50/item_marketprices/item_marketprices_3.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item_marketprices from 's3://ppr-bdas-data/d50/item_marketprices/item_marketprices_4.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item_marketprices from 's3://ppr-bdas-data/d50/item_marketprices/item_marketprices_5.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item_marketprices from 's3://ppr-bdas-data/d50/item_marketprices/item_marketprices_6.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item_marketprices from 's3://ppr-bdas-data/d50/item_marketprices/item_marketprices_7.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

copy item_marketprices from 's3://ppr-bdas-data/d50/item_marketprices/item_marketprices_8.dat' 
credentials 'aws_access_key_id=yourAccessKeyID;aws_secret_access_key=yourSecretAccessKey';

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


-- Check the load operation 

select count(*) from customer;
select count(*) from customer_address;
select count(*) from customer_demographics;
select count(*) from date_dim;
select count(*) from household_demographics;
select count(*) from income_band;
select count(*) from inventory;
select count(*) from item;
select count(*) from item_marketprices;
select count(*) from promotion;
select count(*) from reason;
select count(*) from ship_mode;
select count(*) from store;
select count(*) from store_returns;
select count(*) from store_sales;
select count(*) from time_dim;
select count(*) from warehouse;
select count(*) from web_clickstreams;
select count(*) from web_page;
select count(*) from web_returns;
select count(*) from web_sales;
select count(*) from web_site;
