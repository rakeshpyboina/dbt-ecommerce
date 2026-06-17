with source as (

    select * from {{ source('ecommerce', 'customers') }}

),

renamed as (

    select
        {{dbt_utils.generate_surrogate_key(['customer_id'])}} as customer_key,
        customer_id,
        TRIM(LOWER(first_name)) as first_name,
        TRIM(LOWER(last_name)) as last_name,
        TRIM(LOWER(email)) as email,
        TRIM(phone) as phone,
        TRIM(LOWER(city)) as city,
        TRIM(LOWER(state)) as state,
        TRIM(LOWER(country)) as country,
        CAST(created_at as TIMESTAMP_NTZ) as created_at,
        CAST(updated_at as TIMESTAMP_NTZ) as updated_at,
        CAST(CURRENT_TIMESTAMP as TIMESTAMP_NTZ) as _dbt_loaded_at

    from source

)

select * from renamed