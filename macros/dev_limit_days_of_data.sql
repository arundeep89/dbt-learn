{%- macro dev_limit_days_of_data(column_name, days = 3) -%}
{%- if target.name == 'default' -%}
where {{ column_name }} >= date_sub(DATE(current_timestamp), INTERVAL {{days}} DAY)
{%- endif -%}
{%- endmacro -%}