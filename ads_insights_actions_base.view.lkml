include: "fivetran_base.view"

view: ads_insights_actions_base {
  extension: required
  extends: [fivetran_base]

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
    expression: if(${action_type} = "offsite_conversion", ${value}, null) ;;
  }
}
