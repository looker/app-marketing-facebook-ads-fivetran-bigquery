include: "ads_insights_base.view"

view: hour_base {
  extension: required

  dimension: hourly_stats_aggregated_by_audience_time_zone {
    hidden: yes
    type: string
  }

  dimension: hour {
    type: string
    expression: substring(${hourly_stats_aggregated_by_audience_time_zone}, 0, 2) ;;
  }
}

view: ads_insights_hour {
  extends: [ads_insights_base, hour_base]
  sql_table_name: facebook_ads_fivetran.ads_insights_hour ;;
}
