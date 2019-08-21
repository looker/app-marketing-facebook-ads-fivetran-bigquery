view: ad_transformations_base_fb_adapter {
  extension: required

  dimension: conversions {
    type: number
    sql: ${actions.offsite_conversion_value} ;;
  }

  dimension: cost {
    type: number
    sql:  ${spend} ;;
  }
}
