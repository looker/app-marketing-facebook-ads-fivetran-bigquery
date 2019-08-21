include: "account.view"
include: "fivetran_base.view"

explore: campaign_fb_adapter {
  view_name: campaign
  from: campaign_fb_adapter
  hidden: yes

  join: account {
    from: account_fb_adapter
    type: left_outer
    sql_on: ${campaign.account_id} = ${account.id} ;;
    relationship: many_to_one
  }
}

view: campaign_fb_adapter {
  extends: [fivetran_base_fb_adapter, facebook_ads_config]
  derived_table: {
    sql:
  (
    SELECT campaign_history.* FROM `{{ campaign.facebook_ad_account_schema._sql }}.campaign_history` as campaign_history
    INNER JOIN (
      SELECT
      id, max(_fivetran_synced) as max_fivetran_synced
      FROM `{{ campaign.facebook_ad_account_schema._sql }}.campaign_history`
      GROUP BY id) max_campaign_history
    ON max_campaign_history.id = campaign_history.id
    AND max_campaign_history.max_fivetran_synced = campaign_history._fivetran_synced
  ) ;;
  }

  dimension: id {
    hidden: yes
    sql: CAST(${TABLE}.id AS STRING) ;;
  }

  dimension: account_id {
    hidden: yes
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: boosted_object_id {
    hidden: yes
    type: number
    sql: ${TABLE}.boosted_object_id ;;
  }

  dimension: budget_rebalance_flag {
    hidden: yes
    type: yesno
    sql: ${TABLE}.budget_rebalance_flag ;;
  }

  dimension: buying_type {
    hidden: yes
    type: string
    sql: ${TABLE}.buying_type ;;
  }

  dimension: can_create_brand_lift_study {
    hidden: yes
    type: yesno
    sql: ${TABLE}.can_create_brand_lift_study ;;
  }

  dimension: can_use_spend_cap {
    hidden: yes
    type: yesno
    sql: ${TABLE}.can_use_spend_cap ;;
  }

  dimension: configured_status {
    hidden: yes
    type: string
    sql: ${TABLE}.configured_status ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_time ;;
  }

  dimension: effective_status {
    hidden: yes
    type: string
    sql: ${TABLE}.effective_status ;;
  }

  dimension: status_active {
    hidden: yes
    type: yesno
    sql: ${effective_status} = "ACTIVE" ;;
  }

  dimension: kpi_custom_conversion_id {
    hidden: yes
    type: number
    sql: ${TABLE}.kpi_custom_conversion_id ;;
  }

  dimension: kpi_type {
    hidden: yes
    type: string
    sql: ${TABLE}.kpi_type ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: objective {
    hidden: yes
    type: string
    sql: ${TABLE}.objective ;;
  }

  dimension: source_campaign_id {
    hidden: yes
    type: number
    sql: ${TABLE}.source_campaign_id ;;
  }

  dimension: spend_cap {
    hidden: yes
    type: number
    sql: ${TABLE}.spend_cap ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.start_time ;;
  }

  dimension: status {
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension_group: stop {
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
    sql: ${TABLE}.stop_time ;;
  }
}
