{{ config(schema='AUX') }}

with prueba as(
    select art_id, 
min(coste_suministro) as min_coste
from {{ ref('partsupp') }} 
group by art_id
)

select ps.art_id,
proveedor_id,
min_coste
from prueba p inner join {{ ref('partsupp') }} ps on coste_suministro = min_coste and p.art_id = ps.art_id