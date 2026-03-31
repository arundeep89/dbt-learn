{{
    config(
        alias='stg_products'
    )
}}

select
    id as product_id,
    name as product_name,
    category as product_category,
    retail_price as product_price,
    cost as product_cost
from {{ source('thelook_ecommerce', 'products') }}