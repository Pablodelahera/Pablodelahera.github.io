{{ config(schema='FIN') }}

select ps.ART_ID,
ps.PROVEEDOR_ID,
ps.CANTIDAD_DISPONIBLE,
ps.COSTE_SUMINISTRO,
ds.nombre_nacion,
ds.nombre_region
from {{ ref('stg_partsupp') }} ps left join {{ ref('dim_suplier') }} ds on ps.PROVEEDOR_ID = ds.id
