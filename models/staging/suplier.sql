{{ config(unique_key = 'id') }}

with supplier as(
    select * from {{source('staging','supplier')}}
)

select S_SUPPKEY as id,
S_NAME as nombre_prov,
S_ADDRESS as direccion_prov,
S_NATIONKEY as nation_id,
S_PHONE as telefono_prov,
S_ACCTBAL as balance_prov,
S_COMMENT as comentario
from supplier
