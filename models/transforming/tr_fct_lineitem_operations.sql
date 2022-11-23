{{ config(schema='AUX', unique_key = 'order_id') }}

    select
       order_id,
       sum(cantidad_art) as sum_qty,
       sum(precio_art_cantid) as sum_base_price,
       sum(precio_art_cantid * (1-descuento)) as sum_disc_price,
       sum(precio_art_cantid * (1-descuento) * (1+impuesto)) as sum_final,
       avg(cantidad_art) as avg_qty,
       sum(precio_art_cantid/cantidad_art)/count(*) as avg_price,
       avg(descuento) as avg_disc,
       avg(impuesto) as avg_imp,
       count(*) as count_art
 from
       {{ ref('stg_lineitem') }}
 where
       estado != 'F'
 group by
       order_id
 order by
       order_id