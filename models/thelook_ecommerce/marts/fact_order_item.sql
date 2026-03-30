{{
    config(
        alias='fact_order_item',
        materialized='table'
    )
}}
select
    o.order_id,
    o.user_id,
    oi.order_item_id,
    p.product_name,
    p.product_category,
    p.product_cost,
    oi.sale_price,
    oi.created_at as created_at,
    oi.shipped_at as shipped_at,
    oi.delivered_at as delivered_at,
    oi.returned_at as returned_at,
    oi.status as order_item_status
from {{ ref('stg_orders') }} o
inner join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id
inner join {{ ref('stg_products') }} p
    on oi.product_id = p.product_id
