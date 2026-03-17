{{
    config(
        alias='stg_orders',
        materialized='incremental',
        unique_key='order_id',
        incremental_strategy='merge'
    )
}}
select
    order_id,
    user_id,
    status,
    created_at, 
    shipped_at,
    delivered_at,
    returned_at
from {{ source('thelook_ecommerce', 'orders') }}
{% if is_incremental() %}
    where created_at > (select MAX(created_at) from {{ this }})
{% endif %}