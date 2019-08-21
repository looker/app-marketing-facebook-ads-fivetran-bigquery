include: "adcreative.view"
include: "ads_insights_actions_base.view"
include: "ads_insights_base.view"

explore: ad_impressions_base_fb_adapter {
  extension: required
  hidden: yes
  from: ad_impressions
  view_name: fact
  label: "Impressions"
  view_label: "Impressions"

  join: account {
    from: fb_account
    type: left_outer
    sql_on: ${fact.account_id} = ${account.id} ;;
    relationship: many_to_one
  }

  join: campaign {
    from: fb_campaign
    type: left_outer
    sql_on: ${fact.campaign_id} = ${campaign.id} ;;
    relationship: many_to_one
  }

  join: adset {
    from: fb_adset
    type: left_outer
    sql_on: ${fact.adset_id} = ${adset.id} ;;
    relationship: many_to_one
  }

  join: ad {
    from: fb_ad
    type: left_outer
    sql_on: ${fact.ad_id} = ${ad.id} ;;
    relationship: many_to_one
  }

  join: adcreative {
    from: fb_adcreative
    type: left_outer
    sql_on: ${ad.creative_id} = ${adcreative.id} ;;
    relationship: one_to_one
  }

  join: actions {
    from: actions_fb_adapter
    view_label: "Impressions"
    type: left_outer
    sql_on: ${fact.ad_id} = ${actions.ad_id} AND
      ${fact._date} = ${actions._date} AND
      ${fact.breakdown} = ${actions.breakdown} AND
      ${actions.action_type}  = "offsite_conversion";;
    relationship: one_to_one
  }
}

view: date_base_fb_adapter {
  extension: required

  dimension: _date {
    hidden: yes
    type: date_raw
    sql: CAST(${TABLE}.date AS DATE) ;;
  }

  dimension: breakdown {
    hidden: yes
    sql: "1" ;;
  }
}

explore: ad_impressions_fb_adapter {
  extends: [ad_impressions_base_fb_adapter]
  hidden: yes
  from: ad_impressions_fb_adapter
  view_name: fact
}

view: ad_impressions_fb_adapter {
  extends: [ads_insights_base_fb_adapter, date_base_fb_adapter, facebook_ads_config]
  sql_table_name: {{ fact.facebook_ads_schema._sql }}.ads_insights ;;

  dimension: primary_key {
    hidden: yes
    primary_key: yes
    sql: concat(${_date}
      , "|", ${account_id}
      , "|", ${campaign_id}
      , "|", ${adset_id}
      , "|", ${ad_id}
      , "|", ${breakdown}
    ) ;;
  }
}

view: age_and_gender_base_fb_adapter {

  dimension: breakdown {
    hidden: yes
    sql: concat(${age}
      ,"|", ${gender_raw}
    ) ;;
  }
  dimension: age {
    type: string
  }

  dimension: gender_raw {
    hidden: yes
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: gender {
    type: string
    case: {
      when: {
        sql: ${gender_raw} = 'male' ;;
        label: "Male"
      }
      when: {
        sql: ${gender_raw} = 'female' ;;
        label: "Female"
      }
      when: {
        sql: ${gender_raw} = 'unknown';;
        label: "Unknown"
      }
      else: "Other"
    }
  }
}

explore: ad_impressions_age_and_gender_fb_adapter {
  extends: [ad_impressions_base_fb_adapter]
  hidden: yes
  from: ad_impressions_age_and_gender_fb_adapter
  view_name: fact

  join: actions {
    from: actions_age_and_gender_fb_adapter
    view_label: "Impressions"
    type: left_outer
    sql_on: ${fact.ad_id} = ${actions.ad_id} AND
      ${fact._date} = ${actions._date} AND
      ${fact.breakdown} = ${actions.breakdown} AND
      ${actions.action_type}  = "offsite_conversion";;
    relationship: one_to_one
  }
}

view: ad_impressions_age_and_gender_fb_adapter {
  extends: [ad_impressions_fb_adapter, age_and_gender_base_fb_adapter]
  sql_table_name:  {{ fact.facebook_ads_schema._sql }}.ads_insights_age_and_gender ;;
}

view: hour_base_fb_adapter {
  extension: required

  dimension: breakdown {
    hidden: yes
    sql: ${hourly_stats_aggregated_by_audience_time_zone} ;;
  }

  dimension: hourly_stats_aggregated_by_audience_time_zone {
    hidden: yes
    type: string
  }

  dimension: hour {
    type: string
    sql: substring(${hourly_stats_aggregated_by_audience_time_zone}, 0, 2) ;;
  }
}

explore: ad_impressions_hour_fb_adapter {
  extends: [ad_impressions_base_fb_adapter]
  hidden: yes
  from: ad_impressions_hour_fb_adapter
  view_name: fact

  join: actions {
    from: actions_hour_fb_adapter
    view_label: "Impressions"
    type: left_outer
    sql_on: ${fact.ad_id} = ${actions.ad_id} AND
      ${fact._date} = ${actions._date} AND
      ${fact.breakdown} = ${actions.breakdown} AND
      ${actions.action_type}  = "offsite_conversion";;
    relationship: one_to_one
  }
}

view: ad_impressions_hour_fb_adapter {
  extends: [ad_impressions_fb_adapter, hour_base_fb_adapter]
  sql_table_name:  {{ fact.facebook_ads_schema._sql }}.ads_insights_hour ;;
}

view: platform_and_device_base_fb_adapter {
  extension: required

  dimension: breakdown {
    hidden: yes
    sql: concat(${impression_device}
      ,"|", ${platform_position_raw}
      ,"|", ${publisher_platform_raw}
    ) ;;
  }

  dimension: impression_device {
    hidden: yes
    type: string
  }

  dimension: device_type {
    type: string
    case: {
      when: {
        sql: ${impression_device} = 'desktop' ;;
        label: "Desktop"
      }
      when: {
        sql: ${impression_device} = 'iphone' OR ${impression_device} = 'android_smartphone' ;;
        label: "Mobile"
      }
      when: {
        sql: ${impression_device} = 'ipad'  OR ${impression_device} = 'android_tablet' ;;
        label: "Tablet"
      }
      else: "Other"
    }
  }

  dimension: platform_position_raw {
    hidden: yes
    type: string
    sql: ${TABLE}.platform_position ;;
  }

  dimension: platform_position {
    type: string
    case: {
      when: {
        sql: ${platform_position_raw} = 'feed' AND ${publisher_platform_raw} = 'instagram' ;;
        label: "Feed"
      }
      when: {
        sql: ${platform_position_raw} = 'feed' ;;
        label: "News Feed"
      }
      when: {
        sql: ${platform_position_raw} = 'an_classic' ;;
        label: "Classic"
      }
      when: {
        sql: ${platform_position_raw} = 'all_placements' ;;
        label: "All"
      }
      when: {
        sql: ${platform_position_raw} = 'instant_article' ;;
        label: "Instant Article"
      }
      when: {
        sql: ${platform_position_raw} = 'right_hand_column' ;;
        label: "Right Column"
      }
      when: {
        sql: ${platform_position_raw} = 'rewarded_video' ;;
        label: "Rewarded Video"
      }
      when: {
        sql: ${platform_position_raw} = 'suggested_video' ;;
        label: "Suggested Video"
      }
      when: {
        sql: ${platform_position_raw} = 'instream_video' ;;
        label: "InStream Video"
      }
      when: {
        sql: ${platform_position_raw} = 'messenger_inbox' ;;
        label: "Messenger Home"
      }
      else: "Other"
    }
  }

  dimension: publisher_platform_raw {
    hidden: yes
    type: string
    sql: ${TABLE}.publisher_platform ;;
  }

  dimension: publisher_platform {
    type: string
    case: {
      when: {
        sql: ${publisher_platform_raw} = 'facebook' ;;
        label: "Facebook"
      }
      when: {
        sql: ${publisher_platform_raw} = 'instagram' ;;
        label: "Instagram"
      }
      when: {
        sql: ${publisher_platform_raw} = 'audience_network';;
        label: "Audience Network"
      }
      when: {
        sql: ${publisher_platform_raw} = 'messenger';;
        label: "Messenger"
      }
      else: "Other"
    }
  }
}

explore: ad_impressions_platform_and_device_fb_adapter {
  extends: [ad_impressions_base_fb_adapter]
  hidden: yes
  from: ad_impressions_platform_and_device_fb_adapter
  view_name: fact

  join: actions {
    from: actions_platform_and_device_fb_adapter
    view_label: "Impressions"
    type: left_outer
    sql_on: ${fact.ad_id} = ${actions.ad_id} AND
      ${fact._date} = ${actions._date} AND
      ${fact.breakdown} = ${actions.breakdown} AND
      ${actions.action_type}  = "offsite_conversion";;
    relationship: one_to_one
  }
}

view: ad_impressions_platform_and_device_fb_adapter {
  extends: [ad_impressions_fb_adapter, platform_and_device_base_fb_adapter]
  sql_table_name:  {{ fact.facebook_ads_schema._sql }}.ads_insights_platform_and_device ;;
}

view: region_base_fb_adapter {
  extension: required

  dimension: breakdown {
    hidden: yes
    sql: concat(${country}
      ,"|", ${region}
    ) ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
  }

  dimension: region {
    type: string
  }

  dimension: state {
    type: string
    map_layer_name: us_states
    sql: if(${country} = "US", ${region}, null) ;;
  }
}

explore: ad_impressions_geo_fb_adapter {
  extends: [ad_impressions_base_fb_adapter]
  hidden: yes
  from: ad_impressions_geo_fb_adapter
  view_name: fact

  join: actions {
    from: actions_region_fb_adapter
    view_label: "Impressions"
    type: left_outer
    sql_on: ${fact.ad_id} = ${actions.ad_id} AND
      ${fact._date} = ${actions._date} AND
      ${fact.breakdown} = ${actions.breakdown} AND
      ${actions.action_type}  = "offsite_conversion";;
    relationship: one_to_one
  }
}

view: ad_impressions_geo_fb_adapter {
  extends: [ad_impressions_fb_adapter, region_base_fb_adapter]
  sql_table_name:  {{ fact.facebook_ads_schema._sql }}.ads_insights_region ;;
}

view: actions_fb_adapter {
  extends: [ads_insights_actions_base_fb_adapter, date_base_fb_adapter, facebook_ads_config]
  sql_table_name:  {{ actions.facebook_ads_schema._sql }}.ads_insights_actions ;;
}

view: actions_age_and_gender_fb_adapter {
  extends: [actions_fb_adapter, age_and_gender_base_fb_adapter]
  sql_table_name:  {{ actions.facebook_ads_schema._sql }}.ads_insights_age_and_gender_actions ;;

  dimension: age {
    hidden: yes
  }
  dimension: gender {
    hidden: yes
  }
}

view: actions_hour_fb_adapter {
  extends: [actions_fb_adapter, hour_base_fb_adapter]
  sql_table_name:  {{ actions.facebook_ads_schema._sql }}.ads_insights_hour_actions ;;

  dimension: hour {
    hidden: yes
  }
}

view: actions_platform_and_device_fb_adapter {
  extends: [actions_fb_adapter, platform_and_device_base_fb_adapter]
  sql_table_name:  {{ actions.facebook_ads_schema._sql }}.ads_insights_platform_and_device_actions ;;

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

view: actions_region_fb_adapter {
  extends: [actions_fb_adapter, region_base_fb_adapter]
  sql_table_name:  {{ actions.facebook_ads_schema._sql }}.ads_insights_region_actions ;;

  dimension: country {
    hidden: yes
  }
  dimension: region {
    hidden: yes
  }
  dimension: state {
    hidden: yes
  }
}
