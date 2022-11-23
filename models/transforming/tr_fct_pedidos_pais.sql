{{ config(schema='AUX', unique_key = 'nombre_nacion') }}

select nombre_nacion,
avg(NUMBER_OF_ORDERS) as Pedidos_pais,
avg(GASTO_PEDIDOS) as gasto_medio_pais
from {{ref('tr_fct_pre_customer')}}
group by nombre_nacion
order by gasto_medio_pais desc