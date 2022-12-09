{{ config(schema='AUX') }}

with primer_join as (
    select d_user.SALES_REP_CD,
    d_user.SALES_REP_DS, 
    sa.STORE_AUDIT_CD,
    sa.COUNTRY_CD,
    sa.ACCOUNT_CD,
    sa.STORE_AUDIT_ITEM_CD,
    sa.PRODUCT_CD,
    sa.STORE_AUDIT_REGULAR_PRICE_NM,
    sa.STORE_AUDIT_DT,
    sa.PLAN_FL,
    product.CATEGORY_CD,
    product.CATEGORY,
    product.LOCAL_CATEGORY_DS,
    product.COMPETITOR_DS,
    product.COMPANY_DS,
    product.BRAND_QUALITY_DS,
    product.LOCAL_BRAND_QUALITY_DS,
    product.LOCAL_BRAND_QUALITY_SIZE_DS,
    product.LOCAL_BRAND_DS,
    product.PRODUCT_TYPE_DS,
    product.SKU_DS,
    ff.PRODUCTS_HIERARCHY,
    ff.C_H_VALUE,
    ff.TARGET_VALUE,
    ff.PRICE_PARITY_COMPETITOR,
    ff.TARGET_PERCENTAGE
from {{ref('stg_F_STORE_AUDIT')}} sa
left join {{ref('stg_D_ACCOUNT')}} acc
  on sa.ACCOUNT_CD=acc.ACCOUNT_CD
left join {{ref('stg_D_PRODUCT')}} product
  on product.PRODUCT_CD=sa.PRODUCT_CD
left join {{ref('stg_D_USER')}} d_user
	on acc.OWNER_CD = d_user.SALES_REP_CD  
inner join {{ ref('stg_FLAT_FILE') }} ff
  on (upper(trim(ff.affiliate)) = sa.COUNTRY_CD
   and upper(trim(ff.c_h_value)) = upper(trim(acc.ACCOUNT_OUTLET_CLASS_DS)) 
   and (upper(trim(product.LOCAL_CATEGORY_DS)) = upper(trim(ff.PRICE_PARITY_COMPETITOR))
    or upper(trim(product.LOCAL_BRAND_DS)) = upper(trim(ff.PRICE_PARITY_COMPETITOR))
    or upper(trim(product.LOCAL_BRAND_QUALITY_DS)) = upper(trim(ff.PRICE_PARITY_COMPETITOR))
    or upper(trim(product.LOCAL_BRAND_QUALITY_SIZE_DS)) = upper(trim(ff.PRICE_PARITY_COMPETITOR))
    or upper(trim(product.SKU_DS)) = upper(trim(ff.PRICE_PARITY_COMPETITOR))
    or upper(trim(product.BRAND_QUALITY_DS)) = upper(trim(ff.PRICE_PARITY_COMPETITOR))))
)

    select * from primer_join