{{ config(schema='FIN') }}

with clientes_fin as (
    select dc.id,
    dc.nombre,
    dc.first_fecha,
    dc.most_recent_fecha,
    dc.NUMBER_OF_ORDERS,
    dc.GASTO_PEDIDOS,
    dc.SALDO_CUENTA,
    dc.NOMBRE_NACION,
pp.PEDIDOS_PAIS,
pp.GASTO_MEDIO_PAIS
from {{ ref('dim_customer') }} dc left join {{ ref('pedidos_pais') }} pp on dc.NOMBRE_NACION = pp.NOMBRE_NACION
)

select * from clientes_fin order by gasto_pedidos desc