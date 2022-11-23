{{ config(schema='FIN', unique_key = 'id') }}

select ID,
NOMBRE_ART,
GRUPO_MANUFACTURA,
MARCA,
TIPO_ART,
TAMANHO,
CONTENEDOR_ART,
PRECIO_VENTA
from {{ ref('stg_part') }}