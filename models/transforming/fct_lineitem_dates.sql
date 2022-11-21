{{ config(schema='AUX') }}

with proceso as (
select order_id,
max(numero_presupuesto) as number_of_arts,
min(fecha_envio) as first_fecha_envio,
max(fecha_entrega) as fecha_mas_reciente
from {{ ref('stg_lineitem') }}
where estado != 'F'
group by order_id
)

select l.customer_id, p.*, fecha_mas_reciente - first_fecha_envio as dias_envio
from proceso p left join {{ref('stg_orders')}} l on p.order_id = l.id