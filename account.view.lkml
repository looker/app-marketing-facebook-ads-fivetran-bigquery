include: "/app_marketing_analytics_config/facebook_ads_config.view"

include: "fivetran_base.view"

explore: account_fb_adapter {
  view_name: account
  from: account_fb_adapter
  hidden: yes
}

view: account_fb_adapter {
  extends: [fivetran_base, facebook_ads_config]
  sql_table_name: {{ account.facebook_ads_schema._sql }}.account ;;

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
