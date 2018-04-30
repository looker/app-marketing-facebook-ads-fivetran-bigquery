include: "ads_insights_base.view"

view: ads_insights {
  extends: [ads_insights_base]
  sql_table_name: facebook_ads_fivetran.ads_insights ;;

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
