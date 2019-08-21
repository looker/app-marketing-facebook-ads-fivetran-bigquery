include: "campaign.view"
include: "fivetran_base.view"

explore: adset_fb_adapter {
  view_name: adset
  from: adset_fb_adapter
  hidden: yes

  join: campaign {
    from: campaign_fb_adapter
    type: left_outer
    sql_on: ${adset.campaign_id} = ${campaign.id} ;;
    relationship: many_to_one
  }

  join: account {
    from: account_fb_adapter
    type: left_outer
    sql_on: ${adset.account_id} = ${account.id} ;;
    relationship: many_to_one
  }
}

view: adset_fb_adapter {
  extends: [fivetran_base_fb_adapter, facebook_ads_config]
  derived_table: {
    sql:
  (
    SELECT ad_set_history.* FROM `{{ adset.facebook_ad_account_schema._sql }}.ad_set_history` as ad_set_history
    INNER JOIN (
      SELECT
      id, max(_fivetran_synced) as max_fivetran_synced
      FROM `{{ adset.facebook_ad_account_schema._sql }}.ad_set_history`
      GROUP BY id) max_ad_set_history
    ON max_ad_set_history.id = ad_set_history.id
    AND max_ad_set_history.max_fivetran_synced = ad_set_history._fivetran_synced
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

  dimension: bid_amount {
    hidden: yes
    type: number
    sql: ${TABLE}.bid_amount ;;
  }

  dimension: billing_event {
    hidden: yes
    type: string
    sql: ${TABLE}.billing_event ;;
  }

  dimension: budget_remaining {
    hidden: yes
    type: number
    sql: ${TABLE}.budget_remaining ;;
  }

  dimension: campaign_id {
    hidden: yes
    type: number
    sql: ${TABLE}.campaign_id ;;
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

  dimension: daily_budget {
    hidden: yes
    type: number
    sql: ${TABLE}.daily_budget ;;
  }

  dimension: destination_type {
    hidden: yes
    type: string
    sql: ${TABLE}.destination_type ;;
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

  dimension_group: end {
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
    sql: ${TABLE}.end_time ;;
  }

  dimension: is_autobid {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_autobid ;;
  }

  dimension: is_average_price_pacing {
    hidden: yes
    type: yesno
    sql: ${TABLE}.is_average_price_pacing ;;
  }

  dimension: lifetime_budget {
    hidden: yes
    type: number
    sql: ${TABLE}.lifetime_budget ;;
  }

  dimension: lifetime_imps {
    hidden: yes
    type: number
    sql: ${TABLE}.lifetime_imps ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: optimization_goal {
    hidden: yes
    type: string
    sql: ${TABLE}.optimization_goal ;;
  }

  dimension: promoted_object_application_id {
    hidden: yes
    type: string
    sql: ${TABLE}.promoted_object_application_id ;;
  }

  dimension: promoted_object_custom_event_type {
    hidden: yes
    type: string
    sql: ${TABLE}.promoted_object_custom_event_type ;;
  }

  dimension: promoted_object_event_id {
    hidden: yes
    type: number
    sql: ${TABLE}.promoted_object_event_id ;;
  }

  dimension: promoted_object_object_store_url {
    hidden: yes
    type: string
    sql: ${TABLE}.promoted_object_object_store_url ;;
  }

  dimension: promoted_object_offer_id {
    hidden: yes
    type: number
    sql: ${TABLE}.promoted_object_offer_id ;;
  }

  dimension: promoted_object_page_id {
    hidden: yes
    type: number
    sql: ${TABLE}.promoted_object_page_id ;;
  }

  dimension: promoted_object_pixel_id {
    hidden: yes
    type: number
    sql: ${TABLE}.promoted_object_pixel_id ;;
  }

  dimension: promoted_object_place_page_set_id {
    hidden: yes
    type: number
    sql: ${TABLE}.promoted_object_place_page_set_id ;;
  }

  dimension: promoted_object_product_catalog_id {
    hidden: yes
    type: number
    sql: ${TABLE}.promoted_object_product_catalog_id ;;
  }

  dimension: promoted_object_product_set_id {
    hidden: yes
    type: number
    sql: ${TABLE}.promoted_object_product_set_id ;;
  }

  dimension: recurring_budget_semantics {
    hidden: yes
    type: yesno
    sql: ${TABLE}.recurring_budget_semantics ;;
  }

  dimension: rf_prediction_id {
    hidden: yes
    type: string
    sql: ${TABLE}.rf_prediction_id ;;
  }

  dimension: rtb_flag {
    hidden: yes
    type: yesno
    sql: ${TABLE}.rtb_flag ;;
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

  dimension: targeting_age_max {
    hidden: yes
    type: number
    sql: ${TABLE}.targeting_age_max ;;
  }

  dimension: targeting_age_min {
    hidden: yes
    type: number
    sql: ${TABLE}.targeting_age_min ;;
  }

  dimension: targeting_app_install_state {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_app_install_state ;;
  }

  dimension: targeting_audience_network_positions {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_audience_network_positions ;;
  }

  dimension: targeting_college_years {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_college_years ;;
  }

  dimension: targeting_connections {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_connections ;;
  }

  dimension: targeting_device_platforms {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_device_platforms ;;
  }

  dimension: targeting_education_majors {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_education_majors ;;
  }

  dimension: targeting_education_schools {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_education_schools ;;
  }

  dimension: targeting_education_statuses {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_education_statuses ;;
  }

  dimension: targeting_effective_audience_network_positions {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_effective_audience_network_positions ;;
  }

  dimension: targeting_excluded_connections {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_excluded_connections ;;
  }

  dimension: targeting_excluded_publisher_categories {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_excluded_publisher_categories ;;
  }

  dimension: targeting_excluded_publisher_list_ids {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_excluded_publisher_list_ids ;;
  }

  dimension: targeting_excluded_user_device {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_excluded_user_device ;;
  }

  dimension: targeting_exclusions {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_exclusions ;;
  }

  dimension: targeting_facebook_positions {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_facebook_positions ;;
  }

  dimension: targeting_flexible_spec {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_flexible_spec ;;
  }

  dimension: targeting_friends_of_connections {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_friends_of_connections ;;
  }

  dimension: targeting_geo_locations_countries {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_geo_locations_countries ;;
  }

  dimension: targeting_geo_locations_location_types {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_geo_locations_location_types ;;
  }

  dimension: targeting_instagram_positions {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_instagram_positions ;;
  }

  dimension: targeting_locales {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_locales ;;
  }

  dimension: targeting_publisher_platforms {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_publisher_platforms ;;
  }

  dimension: targeting_user_adclusters {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_user_adclusters ;;
  }

  dimension: targeting_user_device {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_user_device ;;
  }

  dimension: targeting_user_os {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_user_os ;;
  }

  dimension: targeting_wireless_carrier {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_wireless_carrier ;;
  }

  dimension: targeting_work_employers {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_work_employers ;;
  }

  dimension: targeting_work_positions {
    hidden: yes
    type: string
    sql: ${TABLE}.targeting_work_positions ;;
  }

  dimension: use_new_app_click {
    hidden: yes
    type: yesno
    sql: ${TABLE}.use_new_app_click ;;
  }
}
