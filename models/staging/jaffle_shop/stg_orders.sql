select
    id as order_id,
    user_id as customer_id,
    order_date,
    status

from {{ source('jaffle_shop', 'orders') }}

{{ dev_limit_days_of_data('order_date', 100) }}