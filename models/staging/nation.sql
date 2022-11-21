{{ config(unique_key = 'id') }}

with nation as(
    select * from {{source('staging','nation')}}
)

select N_NATIONKEY as id,
N_NAME as nombre_nacion,
N_REGIONKEY as region_id,
N_COMMENT as comentario
from nation