with account as(
    select * from {{source('staging','D_ACCOUNT')}}
)
select * from account