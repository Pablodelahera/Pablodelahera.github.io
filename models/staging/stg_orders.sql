{{ config(unique_key = 'id') }}

with orders as(
    select * from {{ source('staging', 'orders') }}
    {% if is_incremental() %}
    where O_ORDERKEY not in (select id from {{ this }})
    {% endif %}
)

select O_ORDERKEY as id,
O_CUSTKEY as customer_id,
O_ORDERSTATUS as estado,
O_TOTALPRICE as precio_total,
O_ORDERDATE as fecha,
O_ORDERPRIORITY as prioridad,
O_CLERK as empleado,
O_SHIPPRIORITY as envio_prioritario,
O_COMMENT as comentario
from orders
