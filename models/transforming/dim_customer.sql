{{ config(schema='AUX') }}

with customer_order as(
    select
        o.customer_id,
        min(o.fecha) as first_fecha,
        max(o.fecha) as most_recent_fecha,
        coalesce(count(o.id),0) as number_of_orders,
        sum(o.precio_total) as gasto_pedidos
    from {{ref('orders')}} o 
    where o.estado != 'F'
    group by 1
)
,
final as (
    select c.id,
        c.nombre,
        c.nation_id,
       co.first_fecha,
       co.most_recent_fecha,
       co.number_of_orders,
       co.gasto_pedidos,
    case when c.balance > 0 then 'Positivo' else 'Negativo' end Saldo_cuenta
    from customer_order co left join {{ref('customer')}} c on co.customer_id = c.id
    order by id
)

select f.*, nr.nombre_nacion from final f left join {{ref('nation_region')}} nr on f.nation_id = nr.id
