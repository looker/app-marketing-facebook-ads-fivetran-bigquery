include: "ad.view"
include: "ad_impressions_adapter.view"
include: "ads_insights_actions_base.view"
include: "ads_insights_age_and_gender.view"
include: "ads_insights_base.view"
include: "ads_insights_country.view"
include: "ads_insights_hour.view"
include: "ads_insights_platform_and_device.view"
include: "ads_insights_region.view"
include: "fb_ad_transformations_base.view"
include: "period_base.view"

explore: ad_impressions {
  hidden: yes
  from: ad_impressions
  view_name: fact
  label: "Ad Impressions"
  view_label: "Ad Impressions"

  join: campaign {
    type: left_outer
    sql_on: ${fact.campaign_id} = ${campaign.id} ;;
    relationship: many_to_one
  }

  join: adset {
    type: left_outer
    sql_on: ${fact.adset_id} = ${adset.id} ;;
    relationship: many_to_one
  }

  join: ad {
    type: left_outer
    sql_on: ${fact.ad_id} = ${ad.id} ;;
    relationship: many_to_one
  }

  join: actions {
    view_label: "Ad Impressions"
    type: left_outer
    sql_on: ${fact.ad_id} = ${actions.ad_id} AND
      ${fact.date_date} = ${actions.date_date} AND
      ${fact.breakdowns} = ${actions.breakdowns};;
    relationship: many_to_one
  }
}

view: breakdowns_base {
  extends: [age_and_gender_base, country_base, region_base, hour_base, platform_and_device_base]
  dimension: breakdowns {
    hidden: yes
    sql: {% if (fact.impression_device._in_query or fact.platform_position_raw._in_query or fact.publisher_platform_raw._in_query) %}
      CONCAT(CAST(${impression_device} AS STRING),"|", CAST(${platform_position_raw} AS STRING),"|", CAST(${publisher_platform_raw} AS STRING))
      {% elsif (fact.country._in_query) %}
        {% if (fact.region._in_query) %}
      CONCAT(CAST(${country} AS STRING),"|", CAST(${region} AS STRING))
        {% else %}
      CAST(${country} AS STRING)
        {% endif %}
      {% elsif (fact.age._in_query or fact.gender_raw._in_query) %}
      CONCAT(CAST(${age} AS STRING),"|", CAST(${gender_raw} AS STRING))
      {% elsif (fact.hourly_stats_aggregated_by_audience_time_zone._in_query) %}
      CAST(${hourly_stats_aggregated_by_audience_time_zone} AS STRING)
      {% else %}1
      {% endif %} ;;
  }
}

view: ad_impressions {
  extends: [ads_insights_base, breakdowns_base, period_base, fb_ad_transformations_base, ad_impressions_adapter]

  dimension: _date {
    hidden: yes
    type: date_raw
    sql: CAST(${TABLE}.date as DATE) ;;
  }

  dimension: primary_key {
    hidden: yes
    primary_key: yes
#     expression: concat(${date_date}, ${account_id}, ${campaign_id}, ${adset_id}, ${ad_id}, ${breakdowns}) ;;
    sql: CONCAT(CAST(${date_date} AS STRING)
      ,"|", CAST(${account_id} AS STRING)
      ,"|", CAST(${campaign_id} AS STRING)
      ,"|", CAST(${adset_id} AS STRING)
      ,"|", CAST(${ad_id} AS STRING)
      ,"|", CAST(${breakdowns} AS STRING)
      ) ;;
  }
}

view: actions {
  extends: [ads_insights_actions_base, breakdowns_base, ad_impressions_actions_adapter]
  dimension: age {
    hidden: yes
  }
  dimension: country {
    hidden: yes
  }
  dimension: gender {
    hidden: yes
  }
  dimension: hour {
    hidden: yes
  }
  dimension: device_type {
    hidden: yes
  }
  dimension: platform_position {
    hidden: yes
  }
  dimension: publisher_platform {
    hidden: yes
  }

}
