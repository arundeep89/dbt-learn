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
    CAST(oi.created_at AS DATE) as created_at,
    CAST(oi.shipped_at AS DATE) as shipped_at,
    CAST(oi.delivered_at AS DATE) as delivered_at,
    CAST(oi.returned_at AS DATE) as returned_at,
    oi.status as order_item_status
from {{ ref('stg_orders') }} o
inner join {{ ref('stg_order_items') }} oi
    on o.order_id = oi.order_id
inner join {{ ref('stg_products') }} p
    on oi.product_id = p.product_id
