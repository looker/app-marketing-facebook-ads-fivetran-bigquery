connection: "looker_app"
label: "Facebook Ads"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

datagroup: facebook_etl_datagroup {
  sql_trigger: SELECT MAX(_fivetran_synced) FROM facebook_ads_fivetran.ads_insights ;;
  max_cache_age: "24 hours"
}

persist_with: facebook_etl_datagroup
