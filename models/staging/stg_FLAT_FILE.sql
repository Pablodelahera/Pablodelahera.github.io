with flat_file as(
    select * from {{source('staging','FLAT_FILE')}}
),

distintos as(
    select distinct AFFILIATE,
DATE_VALUE as date_value,
PRODUCTS_HIERARCHY_MAPPING_LEVEL as products_hierarchy,
PRODUCT_HIERARCHY_VALUE as P_H_VALUE,
CUSTOMER_HIERARCHY_VALUE as C_H_VALUE,
TARGET_TYPE as TARGET_TYPE,
TARGET_VALUE as target_value,
case when PRICE_PARITY_COMPETITOR like 'JW Red' then 'Johnnie Walker Red'
when PRICE_PARITY_COMPETITOR like 'JW Black' then 'Johnnie Walker Black'
when PRICE_PARITY_COMPETITOR like 'Glenfiddich 12YO' then 'Glenfiddich 12 Year Old'
when PRICE_PARITY_COMPETITOR like 'Hendricks Gin' then 'Hendrick\'s'--'
else PRICE_PARITY_COMPETITOR end PRICE_PARITY_COMPETITOR,
TARGET_PERCENTAGE
from flat_file
)
select *
from distintos