with source as (

    select * from {{ source('ecommerce', 'order_items') }}

),

renamed as (

    select
        {{dbt_utils.generate_surrogate_key(['order_item_id'])}} as order_item_key,
        order_item_id,
        order_id,
        product_id,
        CAST(quantity as NUMBER(10)) as quantity,
        CAST(unit_price AS NUMBER(10, 2)) AS unit_price,
        CAST(total_price AS NUMBER(10, 2)) AS total_price,
        CAST(created_at AS TIMESTAMP_NTZ) AS created_at,
        CAST(updated_at AS TIMESTAMP_NTZ) AS updated_at,
        CAST(CURRENT_TIMESTAMP as TIMESTAMP_NTZ) as _dbt_loaded_at

    from source

)

select * from renamed
