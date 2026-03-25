{% macro drop_ci_schema() %}
  {%- if target.name == 'ci' -%}
    {# Get all schemas matching the PR pattern #}
    {% set get_schemas_query %}
      select schema_name
      from `{{ target.project }}.INFORMATION_SCHEMA.SCHEMATA`
      where schema_name like '{{ target.schema }}%'
    {% endset %}
    
    {% set results = run_query(get_schemas_query) %}
    
    {%- if execute and results -%}
      {% for row in results %}
        {% set schema_to_drop = row[0] %}
        {% set drop_query %}
          drop schema if exists `{{ target.project }}.{{ schema_to_drop }}` cascade
        {% endset %}
        {% do run_query(drop_query) %}
        {{ log("Dropped CI schema: " ~ target.project ~ "." ~ schema_to_drop, info=True) }}
      {% endfor %}
      
      {% if results.rows | length == 0 %}
        {{ log("No CI schemas found matching pattern: " ~ target.schema, info=True) }}
      {% endif %}
    {%- endif -%}
  {%- else -%}
    {{ log("drop_ci_schema skipped — target is not 'ci' (current target: " ~ target.name ~ ")", info=True) }}
  {%- endif -%}
{% endmacro %}
