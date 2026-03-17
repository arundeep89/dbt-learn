{{
    config(
        alias='stg_order_items',
        materialized='incremental',
        unique_key='id',
        incremental_strategy='merge'
    )
}}
select
    id as order_item_id,
    order_id,
    user_id,
    product_id,
    inventory_item_id,
    status, 
    sale_price,
    created_at,
    shipped_at,
    delivered_at,
    returned_at
from {{ source('thelook_ecommerce', 'order_items') }}
{% if is_incremental() %}
    where created_at > (select MAX(created_at) from {{ this }})
{% endif %}