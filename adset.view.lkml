include: "/app_marketing_analytics_config/facebook_ads_config.view"

include: "campaign.view"
include: "fivetran_base.view"

explore: adset {
  hidden: yes

  join: campaign {
    type: left_outer
    sql_on: ${adset.campaign_id} = ${campaign.id} ;;
    relationship: many_to_one
  }
}

view: adset {
  extends: [fivetran_base, facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}.adset ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }

  dimension: campaign_id {
    hidden: yes
    type: string
  }

  dimension: name {
    hidden: yes
    type: string
  }
}
