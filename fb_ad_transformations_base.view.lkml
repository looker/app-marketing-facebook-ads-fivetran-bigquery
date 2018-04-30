include: "fb_ad_metrics_base.view"

view: fb_ad_transformations_base {
  extension: required
  extends: [fb_ad_metrics_base]

  dimension: conversions {
    sql: ${actions.offsite_conversion_value} ;;
  }

  dimension: conversionvalue {
    sql:  ${total_action_value};;
  }

  dimension: cost {
    sql:  ${spend} ;;
  }
}
