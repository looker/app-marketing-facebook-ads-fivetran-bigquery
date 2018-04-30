include: "adset_adapter.view"
include: "campaign.view"
include: "fivetran_base.view"

explore: adset {
  hidden: yes

  join: campaign {
    type: left_outer
    sql_on: ${adset.campaign_id} = ${campaign.id} ;;
    relationship: many_to_one
  }
}

view: adset {
  extends: [fivetran_base, adset_adapter]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: campaign_id {
    hidden: yes
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      name,
      campaign.name,
      campaign.id,
      ad.count,
      ads_insights.count,
      ads_insights_country.count
    ]
  }
}
