include: "/app_marketing_analytics_config/facebook_ads_config.view"

view: adset_adapter {
  extends: [facebook_ads_config]
  sql_table_name: {{ facebook_ads_schema._sql }}.adset ;;
}
