{{ config(schema='AUX') }}

select SALES_REP_DS,
LOCAL_BRAND_QUALITY_DS,
sum(COMPLIANCE_PRICE_FL)*100/count(COMPLIANCE_PRICE_FL) as Pricing_compliance
from {{ ref('tr_d_product') }}
group by 1,2
order by SALES_REP_DS