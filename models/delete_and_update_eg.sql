{{
    config(
        materialized="incremental",
        unique_key="C_CUSTKEY",
        incremental_strategy="insert_overwrite"
    )
}}

with final as 
(
    select 
    C_CUSTKEY
,C_NAME
,C_ADDRESS
,C_NATIONKEY
,C_PHONE
,C_ACCTBAL
,C_MKTSEGMENT
,C_COMMENT
,case when (c_custkey>10) then 1 else 0 end as delete_fl
 from {{ ref("first_model") }}
)
select *
from final

{% if is_incremental() %}
  where C_CUSTKEY > (select max(C_CUSTKEY) from {{ this }})
{% endif %}