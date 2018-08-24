view: ad_transformations_base_fb_adapter {
  extension: required

  dimension: conversions {
    type: number
    sql: ${actions.offsite_conversion_value} ;;
  }

  dimension: conversionvalue {
    type: number
    sql:  ${total_action_value};;
  }

  dimension: cost {
    type: number
    sql:  ${spend} ;;
  }
}
