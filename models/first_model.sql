{{ config(materialized='table') }}


with final as 
(
select * from SNOWFLAKE_SAMPLE_DATA.TPCH_SF1.customer limit 10
)
select * from final 