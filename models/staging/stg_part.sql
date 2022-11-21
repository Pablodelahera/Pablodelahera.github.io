{{ config(unique_key = 'id') }}

with part as(
    select * from {{source('staging','part')}}
)

select P_PARTKEY as id,
P_NAME as nombre_art,
P_MFGR as grupo_manufactura,
P_BRAND as marca,
P_TYPE as tipo_art,
P_SIZE as tamanho,
P_CONTAINER as contenedor_art,
P_RETAILPRICE as precio_venta,
P_COMMENT as comentario
from part