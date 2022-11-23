{{ config(schema='FIN') }}

select c.ID, 
c.NOMBRE,
c.DIRECCION,
c.TELEFONO,
c.BALANCE,
c.DEPARTAMENTO,
nr.nombre_nacion,
nr.nombre_region
from {{ ref('stg_customer') }} c left join {{ ref('tr_nation_region') }} nr on c.nation_id = nr.id
