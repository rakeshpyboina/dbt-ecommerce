
{% macro generate_schema_name(custom_schema_name, default_schema)%}
    {% if custom_schema_name %}
        {{custom_schema_name | trim}} 
    {% else %}
        {{default_schema}}
    {% endif %}
{% endmacro %}