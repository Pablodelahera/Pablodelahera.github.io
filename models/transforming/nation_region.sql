{{ config(schema='AUX') }}

select n.id, n.nombre_nacion, n.region_id, r.nombre_region from {{ ref('nation') }} n
 left join {{ ref('region') }} r on n.region_id = r.id