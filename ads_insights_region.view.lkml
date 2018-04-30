include: "ads_insights_base.view"

view: region_base {
  extension: required

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: region {
    type: string
    sql: ${TABLE}.region ;;
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: IF(${country} = "US", ${TABLE}.region, NULL) ;;
  }
}

view: ads_insights_region {
  extends: [ads_insights_base, region_base]
  sql_table_name: facebook_ads_fivetran.ads_insights_region ;;

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      adset_name,
      ad_name,
      campaign_name,
      account_name,
      ad.name,
      ad.id,
      account.name,
      account.id,
      adset.name,
      adset.id,
      campaign.name,
      campaign.id
    ]
  }
}
