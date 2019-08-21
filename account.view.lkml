include: "fivetran_base.view"

explore: account_fb_adapter {
  view_name: account
  from: account_fb_adapter
  hidden: yes
}

view: account_fb_adapter {
  extends: [fivetran_base_fb_adapter, facebook_ads_config]
  derived_table: {
    sql:
    (
      SELECT account_history.* FROM `{{ account.facebook_ad_account_schema._sql }}.account_history` as account_history
      INNER JOIN (
        SELECT
        id, max(_fivetran_synced) as max_fivetran_synced
        FROM `{{ account.facebook_ad_account_schema._sql }}.account_history`
        GROUP BY id) max_account_history
      ON max_account_history.id = account_history.id
      AND max_account_history.max_fivetran_synced = account_history._fivetran_synced
    ) ;;
  }

  dimension: id {
    hidden: yes
    sql: CAST(${TABLE}.id AS STRING) ;;
  }

  dimension: account_status {
    hidden: yes
    type: string
  }

  dimension: status_active {
    hidden: yes
    type: yesno
    sql: ${account_status} = "ACTIVE" ;;
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

  dimension: currency {
    hidden: yes
    type: string
    sql: ${TABLE}.currency ;;
  }

  dimension: min_campaign_group_spend_cap {
    hidden: yes
    type: number
    sql: ${TABLE}.min_campaign_group_spend_cap ;;
  }

  dimension: min_daily_budget {
    hidden: yes
    type: number
    sql: ${TABLE}.min_daily_budget ;;
  }

  dimension: name {
    hidden: yes
    type: string
  }

  dimension: timezone_id {
    hidden: yes
    type: number
    sql: ${TABLE}.timezone_id ;;
  }

  dimension: timezone_name {
    hidden: yes
    type: string
    sql: ${TABLE}.timezone_name ;;
  }

  dimension: timezone_offset_hours_utc {
    hidden: yes
    type: number
    sql: ${TABLE}.timezone_offset_hours_utc ;;
  }
}
