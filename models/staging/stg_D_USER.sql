with users as(
    select * from {{source('staging','D_USER')}}
)

select * from users