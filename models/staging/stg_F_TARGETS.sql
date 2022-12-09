with targets as(
    select * from {{source('staging','F_TARGETS')}}
)

select distinct AFFILIATE,
DATE_VALUE as date_value,
PRODUCTS_HIERARCHY_MAPPING_LEVEL as products_hierarchy,
PRODUCT_HIERARCHY_VALUE as P_H_VALUE,
CUSTOMER_HIERARCHY_VALUE as C_H_VALUE,
TARGET_TYPE as TARGET_TYPE,
TARGET_VALUE as target_value
from targets
