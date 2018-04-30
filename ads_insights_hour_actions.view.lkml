include: "ads_insights_actions_base.view"
include: "ads_insights_hour.view"

view: ads_insights_hour_actions {
  extends: [ads_insights_actions_base, hour_base]
  sql_table_name: facebook_ads_fivetran.ads_insights_hour_actions ;;
}
