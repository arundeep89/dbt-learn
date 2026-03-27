{{
    config(
        alias='fact_events',
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
    event_id,
    user_id,
    session_id,
    event_type,
    uri,
    traffic_source,
    browser,
    created_at
from {{ ref('stg_events') }}
{% if is_incremental() %}
    where CAST(created_at as DATE) >= (select MAX(CAST(created_at as DATE)) from {{ this }})
{% endif %}
