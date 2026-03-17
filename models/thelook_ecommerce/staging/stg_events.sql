{{
    config(
        alias='stg_events',
        materialized='incremental',
        incremental_strategy='insert_overwrite',
        partition_by={
            "field": "created_at",
            "data_type": "timestamp",
            "granularity": "day"
        }
    )
}}
select
    id as event_id,
    user_id,
    event_type,
    session_id,
    uri,
    traffic_source,
    browser,
    created_at
from {{ source('thelook_ecommerce', 'events') }}
-- accounts for late arriving records
{% if is_incremental() %}
    where CAST(created_at as DATE) >= (select MAX(CAST(created_at as DATE)) from {{ this }})
{% endif %}