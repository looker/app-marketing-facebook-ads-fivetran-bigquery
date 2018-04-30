include: "ads_insights_actions_base.view"
include: "ads_insights_region.view"

view: ads_insights_region_actions {
  extends: [ads_insights_actions_base, region_base]
  sql_table_name: facebook_ads_fivetran.ads_insights_region_actions ;;
}
