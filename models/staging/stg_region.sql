{{ config(unique_key = 'id') }}

with region as(
    select * from {{source('staging','region')}}
)

select R_REGIONKEY as id,
R_NAME as nombre_region,
R_COMMENT as comentario
from region