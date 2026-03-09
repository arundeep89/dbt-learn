{{
    config(
        materialized='view',
        alias='stg_users'
    )
}}
select
    id as user_id,
    first_name,
    last_name,
    email,
    age,
    created_at
from {{ source('thelook_ecommerce', 'users') }}