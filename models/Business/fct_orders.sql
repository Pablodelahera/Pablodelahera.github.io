{{ config(schema='FIN') }}

with orders_correctos as(
    select 
dl.customer_id,
fl.*,
dl.FIRST_FECHA_ENVIO,
dl.FECHA_MAS_RECIENTE,
dl.DIAS_ENVIO
from {{ref('fct_lineitem')}} fl left join {{ref('dim_lineitem')}} dl on fl.order_id = dl.order_id
)

select * from orders_correctos order by sum_final desc