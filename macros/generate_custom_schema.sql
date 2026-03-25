{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}
        {{ default_schema }}
    {%- else -%}
        {%- if target.name == 'ci' -%}
            {# In CI, concatenate base schema with custom schema for PR isolation #}
            {{ default_schema }}_{{ custom_schema_name | trim }}
        {%- else -%}
            {# In prod/dev, use only the custom schema name #}
            {{ custom_schema_name | trim }}
        {%- endif -%}
    {%- endif -%}
{%- endmacro %}
