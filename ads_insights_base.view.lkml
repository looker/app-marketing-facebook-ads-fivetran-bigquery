include: "fivetran_base.view"

view: ads_insights_base {
  extension: required
  extends: [fivetran_base]

  dimension: account_id {
    hidden: yes
    type: string
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: ad_id {
    hidden: yes
    type: string
    sql: ${TABLE}.ad_id ;;
  }

  dimension: ad_name {
    type: string
    sql: ${TABLE}.ad_name ;;
  }

  dimension: adset_id {
    hidden: yes
    type: string
    sql: ${TABLE}.adset_id ;;
  }

  dimension: adset_name {
    type: string
    sql: ${TABLE}.adset_name ;;
  }

  dimension: campaign_id {
    hidden: yes
    type: string
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: clicks {
    hidden: yes
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date ;;
  }

  dimension: frequency {
    hidden: yes
    type: number
    sql: ${TABLE}.frequency ;;
  }

  dimension: impressions {
    hidden: yes
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: objective {
    type: string
    sql: ${TABLE}.objective ;;
  }

  dimension: reach {
    hidden: yes
    type: number
    sql: ${TABLE}.reach ;;
  }

  dimension: spend {
    hidden: yes
    type: number
    sql: ${TABLE}.spend ;;
  }

  dimension: total_action_value {
    hidden: yes
    type: number
    sql: ${TABLE}.total_action_value ;;
  }

  dimension: total_actions {
    hidden: yes
    type: number
    sql: ${TABLE}.total_actions ;;
  }
}
