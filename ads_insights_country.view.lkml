include: "ads_insights_base.view"

view: country_base {
  extension: required

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }
}

view: ads_insights_country {
  extends: [ads_insights_base, country_base]
  sql_table_name: facebook_ads_fivetran.ads_insights_country ;;

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
