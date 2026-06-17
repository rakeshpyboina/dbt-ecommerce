with source as (

    select * from {{ source('ecommerce', 'products') }}

),

renamed as (

    select
        {{dbt_utils.generate_surrogate_key(['product_id'])}} as product_key,
        product_id,
        TRIM(LOWER(product_name)) as product_name,
        TRIM(LOWER(description)) as description,
        TRIM(LOWER(category)) as category,
        TRIM(LOWER(brand)) as brand,
        CAST(unit_price as NUMBER(10, 2)) as unit_price,
        CAST(stock_quantity as NUMBER(10)) as stock_quantity,
        CAST(shelf_life_days as NUMBER(10)) as shelf_life_days,
        CAST(created_at as TIMESTAMP_NTZ) as created_at,
        CAST(updated_at as TIMESTAMP_NTZ) as updated_at,
        CAST(CURRENT_TIMESTAMP as TIMESTAMP_NTZ) as _dbt_loaded_at

    from source

)

select * from renamed