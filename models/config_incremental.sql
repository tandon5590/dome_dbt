{{ config(materialized='incremental')}}

with final as 
(

 select *,current_timestamp from {{ ref("first_model")}}

)
select * from final

{% if is_incremental() %}
  where C_CUSTKEY > (select max(C_CUSTKEY) from {{ this }})
{% endif %}

