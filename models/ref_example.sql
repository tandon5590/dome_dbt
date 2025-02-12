{{ config(materialized='table')}}


with final as

(
 select * from {{ ref("first_model")}}
 union all 

 select * from {{ ref("first_model")}}
)
select * from final 