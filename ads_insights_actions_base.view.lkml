include: "fivetran_base.view"

view: ads_insights_actions_base_fb_adapter {
  extension: required
  extends: [fivetran_base_fb_adapter]

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: concat(CAST(${_date} as STRING)
      , "|", ${ad_id}
      , "|", ${action_type}
      , "|", ${breakdown}
    ) ;;
  }

  dimension: _1_d_view {
    hidden: yes
    type: number
  }

  dimension: _28_d_click {
    hidden: yes
    type: number
  }

  dimension: action_type {
    type: string
  }

  dimension: ad_id {
    hidden: yes
    type: string
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
  }

  dimension: index {
    hidden: yes
    type: number
  }

  dimension: value {
    hidden: yes
    type: number
  }

  dimension: offsite_conversion_value {
    hidden: yes
    type: number
    sql: if(${action_type} = "offsite_conversion", ${value}, null) ;;
  }
}
