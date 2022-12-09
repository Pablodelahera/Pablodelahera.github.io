
with product as(
    select * from {{source('staging','D_PRODUCT_CRM')}}
)

select category_cd as category_cd,
category_ds as category,
LOCAL_CATEGORY_DS,
active_product_ds as active_product_ds,
brand_cd as brand_cd,
brand_ds as brand_ds,
is_competitor_fl as competitor_fl,
company_ds as company_ds,
is_competitor_ds as competitor_ds,
brand_quality_cd as brand_quality_cd,
BRAND_QUALITY_DS,
LOCAL_BRAND_DS,
LOCAL_BRAND_QUALITY_SIZE_DS,
LOCAL_BRAND_QUALITY_DS,
BRAND_QUALITY_SIZE_DS,
SKU_CD as sku,
SKU_DS,
PRODUCT_TYPE_DS,
PRODUCT_CD,
ID_D_PRODUCT_CRM,
PRODUCT_DS,
LOCAL_PRODUCT_DS,
RECORD_TYPE_CD,
COUNTRY_CD
from product
