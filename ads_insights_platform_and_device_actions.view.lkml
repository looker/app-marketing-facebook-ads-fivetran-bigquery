include: "ads_insights_actions_base.view"
include: "ads_insights_platform_and_device.view"

view: ads_insights_platform_and_device_actions {
  extends: [ads_insights_actions_base, platform_and_device_base]
  sql_table_name: facebook_ads_fivetran.ads_insights_platform_and_device_actions ;;
}
