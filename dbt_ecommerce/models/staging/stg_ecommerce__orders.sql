with source as (

    select * from {{ source('ecommerce', 'orders') }}

),

renamed as (

    select
        {{dbt_utils.generate_surrogate_key(['order_id'])}} as order_key,
        order_id,
        customer_id,
        CAST(order_date as TIMESTAMP_NTZ) as order_date,
        TRIM(LOWER(order_status)) as order_status,
        CAST(total_amount as NUMBER(10, 2)) as total_ammount,
        shipping_address,
        CAST(created_at as TIMESTAMP_NTZ) as created_at,
        CAST(updated_at as TIMESTAMP_NTZ) as updated_at,
        CAST(CURRENT_TIMESTAMP as TIMESTAMP_NTZ) as _dbt_loaded_at

    from source

)

select * from renamed
