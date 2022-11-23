{{ config(schema='FIN', unique_key = 'id') }}

select s.ID,
s.NOMBRE_PROV,
s.DIRECCION_PROV,
s.TELEFONO_PROV,
s.BALANCE_PROV,
nr.nombre_nacion,
nr.nombre_region
from {{ ref('stg_suplier') }} s left join {{ ref('tr_nation_region') }} nr on s.nation_id = nr.id