include: "ads_insights_actions_base.view"
include: "ads_insights_country.view"

view: ads_insights_country_actions {
  extends: [ads_insights_actions_base, country_base]
  sql_table_name: facebook_ads_fivetran.ads_insights_country_actions ;;
}
