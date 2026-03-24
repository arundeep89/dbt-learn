{% macro drop_ci_schema() %}
  {%- if target.name == 'ci' -%}
    {% set drop_query %}
      drop schema if exists `{{ target.project }}.{{ target.schema }}` cascade
    {% endset %}
    {% do run_query(drop_query) %}
    {{ log("Dropped CI schema: " ~ target.project ~ "." ~ target.schema, info=True) }}
  {%- else -%}
    {{ log("drop_ci_schema skipped — target is not 'ci' (current target: " ~ target.name ~ ")", info=True) }}
  {%- endif -%}
{% endmacro %}
