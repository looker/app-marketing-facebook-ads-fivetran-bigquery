include: "/app_marketing_analytics_config/facebook_ads_config.view"

include: "account.view"
include: "fivetran_base.view"

explore: campaign {

  join: account {
    type: left_outer
    sql_on: ${campaign.account_id} = ${account.id} ;;
    relationship: many_to_one
  }
}

view: campaign {
  extends: [fivetran_base, facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}.campaign ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }

  dimension: account_id {
    hidden: yes
    type: string
  }

  dimension: name {
    hidden: yes
    type: string
  }
}
