{{ config(unique_key = 'id') }}

with custom as(
    select * from {{source('staging','customer')}}
)

select C_CUSTKEY as id,
C_NAME as nombre,
C_ADDRESS as direccion,
C_NATIONKEY as nation_id,
C_PHONE as telefono,
C_ACCTBAL as balance,
C_MKTSEGMENT as departamento,
C_COMMENT as comentario
from custom