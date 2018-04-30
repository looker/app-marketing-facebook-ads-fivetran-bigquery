include: "account_adapter.view"
include: "fivetran_base.view"

view: account {
  extends: [fivetran_base, account_adapter]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }

  measure: count {
    hidden: yes
    type: count
    drill_fields: [id, name, ads_insights.count, ads_insights_country.count, campaign.count]
  }
}
