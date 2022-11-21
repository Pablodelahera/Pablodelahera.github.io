{{ config(schema='AUX') }}

select n.id, n.nombre_nacion, n.region_id, r.nombre_region from {{ ref('stg_nation') }} n
 left join {{ ref('stg_region') }} r on n.region_id = r.id