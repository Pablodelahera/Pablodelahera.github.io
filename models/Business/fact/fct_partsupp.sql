{{ config(schema='FIN') }}

select fpp.art_id,
fpp.proveedor_id,
ds.nombre_nacion as pais_proveedor,
ds.nombre_region as region_proveedor,
fpp.min_coste
from {{ ref('fct_pre_partsupp') }} fpp left join {{ ref('dim_suplier') }} ds 
on fpp.proveedor_id = ds.id
order by min_coste