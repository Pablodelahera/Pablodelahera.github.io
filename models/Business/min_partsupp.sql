{{ config(schema='FIN') }}

select * from {{ ref('partsupp_min') }} order by min_coste