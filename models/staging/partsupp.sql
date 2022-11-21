
with partsup as(
    select * from {{source('staging','partsupp')}}
)

select PS_PARTKEY as art_id,
PS_SUPPKEY as proveedor_id,
PS_AVAILQTY as cantidad_disponible,
PS_SUPPLYCOST as coste_suministro,
PS_COMMENT as comentario
from partsup