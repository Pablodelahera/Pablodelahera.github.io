{{ config(schema='AUX') }}

select nombre_nacion,
avg(NUMBER_OF_ORDERS) as Pedidos_pais,
avg(GASTO_PEDIDOS) as gasto_medio_pais
from {{ref('dim_customer')}}
group by nombre_nacion
order by gasto_medio_pais desc