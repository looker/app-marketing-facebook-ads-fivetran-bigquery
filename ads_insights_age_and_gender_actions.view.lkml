include: "ads_insights_actions_base.view"
include: "ads_insights_age_and_gender.view"

view: ads_insights_age_and_gender_actions {
  extends: [ads_insights_actions_base, age_and_gender_base]
  sql_table_name: facebook_ads_fivetran.ads_insights_age_and_gender_actions ;;
}
