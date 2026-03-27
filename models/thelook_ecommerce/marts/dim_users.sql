{{
    config(
        alias='dim_users',
        materialized='table'
    )
}}
select
    user_id,
    first_name,
    last_name,
    email,
    age,
    created_at
from {{ ref('stg_users') }}
