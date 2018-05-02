include: "/app_marketing_analytics_config/facebook_ads_config.view"

include: "fivetran_base.view"

view: account {
  extends: [fivetran_base, facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}.account ;;

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }

  dimension: name {
    hidden: yes
    type: string
  }
}
