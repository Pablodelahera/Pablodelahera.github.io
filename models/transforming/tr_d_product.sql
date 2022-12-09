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
left join {{ ref('stg_FLAT_FILE') }} ff
  on (upper(trim(ff.affiliate)) = sa.COUNTRY_CD
   and upper(trim(ff.c_h_value)) = upper(trim(acc.ACCOUNT_OUTLET_CLASS_DS)) 
   and (upper(trim(product.LOCAL_CATEGORY_DS)) = upper(trim(ff.p_h_value))
    or upper(trim(product.LOCAL_BRAND_DS)) = upper(trim(ff.p_h_value))
    or upper(trim(product.LOCAL_BRAND_QUALITY_DS)) = upper(trim(ff.p_h_value))
    or upper(trim(product.LOCAL_BRAND_QUALITY_SIZE_DS)) = upper(trim(ff.p_h_value))
    or upper(trim(product.BRAND_QUALITY_DS)) = upper(trim(ff.p_h_value))
    or upper(trim(product.SKU_DS)) = upper(trim(ff.p_h_value))))
),

competitor as (
    select pj.*,
comp.STORE_AUDIT_REGULAR_PRICE_NM as precio_competidor
from primer_join pj
left join {{ref('tr_competitors')}} comp
  on (upper(trim(pj.c_h_value)) = upper(trim(comp.c_h_value))
  and comp.STORE_AUDIT_CD = pj.STORE_AUDIT_CD --Puede que falten mas campos de unión.
  and comp.ACCOUNT_CD = pj.ACCOUNT_CD
  and comp.STORE_AUDIT_DT = pj.STORE_AUDIT_DT
  and comp.SALES_REP_CD = pj.SALES_REP_CD
  and (upper(trim(comp.BRAND_QUALITY_DS)) = upper(trim(pj.PRICE_PARITY_COMPETITOR))
  or upper(trim(comp.LOCAL_CATEGORY_DS)) = upper(trim(pj.PRICE_PARITY_COMPETITOR))
  or upper(trim(comp.LOCAL_BRAND_DS)) = upper(trim(pj.PRICE_PARITY_COMPETITOR))
  or upper(trim(comp.LOCAL_BRAND_QUALITY_DS)) = upper(trim(pj.PRICE_PARITY_COMPETITOR))
  or upper(trim(comp.LOCAL_BRAND_QUALITY_SIZE_DS)) = upper(trim(pj.PRICE_PARITY_COMPETITOR))
  or upper(trim(comp.SKU_DS)) = upper(trim(pj.PRICE_PARITY_COMPETITOR))))
where precio_competidor is not null
),

final as (
    select competitor.*,
round((competitor.STORE_AUDIT_REGULAR_PRICE_NM)*100/competitor.precio_competidor,2) as PRICE_PARITY
from competitor
)

  select distinct final.*,--Realizo select distinct para evitar duplicados, debido al comentario anterior.
case
  when final.target_value >= final.STORE_AUDIT_REGULAR_PRICE_NM or final.TARGET_PERCENTAGE >= final.PRICE_PARITY
    then 1
  else 0
end COMPLIANCE_PRICE_FL,
case
 when final.target_value >= final.STORE_AUDIT_REGULAR_PRICE_NM and final.TARGET_PERCENTAGE >= final.PRICE_PARITY then 'Ambas'
 when final.target_value >= final.STORE_AUDIT_REGULAR_PRICE_NM then 'Precio' 
 when final.TARGET_PERCENTAGE >= final.PRICE_PARITY then 'Porcentaje'
 else 'No compliance'
 end Porque_compliance
from final
order by SALES_REP_DS

