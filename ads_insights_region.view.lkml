include: "ads_insights_base.view"

view: region_base {
  extension: required

  dimension: country {
    type: string
    map_layer_name: countries
  }

  dimension: region {
    type: string
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    expression: if(${country} = "US", ${region}, null) ;;
  }
}

view: ads_insights_region {
  extends: [ads_insights_base, region_base]
  sql_table_name: facebook_ads_fivetran.ads_insights_region ;;
}
