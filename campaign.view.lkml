include: "account.view"
include: "campaign_adapter.view"
include: "fivetran_base.view"

explore: campaign {

  join: account {
    type: left_outer
    sql_on: ${campaign.account_id} = ${account.id} ;;
    relationship: many_to_one
  }
}

view: campaign {
  extends: [fivetran_base, campaign_adapter]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: account_id {
    hidden: yes
    type: string
    sql: ${TABLE}.account_id ;;
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
      account.name,
      account.id,
      ads_insights.count,
      ads_insights_country.count,
      adset.count
    ]
  }
}
