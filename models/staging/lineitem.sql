
with lineitem as(
    select * from {{source('staging','lineitem')}}
)

select L_ORDERKEY as order_id,
L_PARTKEY as art_id,
L_SUPPKEY as proveedor_id,
L_LINENUMBER as numero_presupuesto,
L_QUANTITY as cantidad_art,
L_EXTENDEDPRICE as precio_art_cantid,
L_DISCOUNT as descuento,
L_TAX as impuesto,
L_RETURNFLAG as devolucion,
L_LINESTATUS as estado,
L_SHIPDATE as fecha_envio,
L_COMMITDATE as fecha_registro,
L_RECEIPTDATE as fecha_entrega,
L_SHIPINSTRUCT as instruccion_envio,
L_SHIPMODE as modo_envio,
L_COMMENT as comentario
from lineitem


