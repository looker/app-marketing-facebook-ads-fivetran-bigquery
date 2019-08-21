include: "ad.view"
include: "fivetran_base.view"

explore: adcreative_fb_adapter {
  view_name: adcreative
  from: adcreative_fb_adapter
  hidden: yes

  join: ad {
    from: ad_fb_adapter
    type: left_outer
    sql_on: ${ad.creative_id} = ${adcreative.id} ;;
    relationship: one_to_one
  }

  join: adset {
    from: adset_fb_adapter
    type: left_outer
    sql_on: ${ad.adset_id} = ${adset.id} ;;
    relationship: many_to_one
  }

  join: campaign {
    from: campaign_fb_adapter
    type: left_outer
    sql_on: ${ad.campaign_id} = ${campaign.id} ;;
    relationship: many_to_one
  }

  join: account {
    from: account_fb_adapter
    type: left_outer
    sql_on: ${ad.account_id} = ${account.id} ;;
    relationship: many_to_one
  }
}

view: adcreative_fb_adapter {
  extends: [fivetran_base_fb_adapter, facebook_ads_config]
  derived_table: {
    sql:
      (
        SELECT creative_history.* FROM `{{ ad.facebook_ad_account_schema._sql }}.ad_history` as creative_history
        INNER JOIN (
          SELECT
          id, max(_fivetran_synced) as max_fivetran_synced
          FROM `{{ ad.facebook_ad_account_schema._sql }}.creative_history`
          GROUP BY id) max_creative_history
        ON max_ad_history.id = creative_history.id
        AND max_ad_history.max_fivetran_synced = creative_history._fivetran_synced
      ) ;;
  }

  dimension: id {
    hidden: yes
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: account_id {
    hidden: yes
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: actor_id {
    hidden: yes
    type: number
    sql: ${TABLE}.actor_id ;;
  }

  dimension: applink_treatment {
    hidden: yes
    type: string
    sql: ${TABLE}.applink_treatment ;;
  }

  dimension: body {
    type: string
    sql: ${TABLE}.body ;;
  }

  dimension: branded_content_sponsor_page_id {
    hidden: yes
    type: number
    sql: ${TABLE}.branded_content_sponsor_page_id ;;
  }

  dimension: call_to_action_type {
    hidden: yes
    type: string
    sql: ${TABLE}.call_to_action_type ;;
  }

  dimension: effective_instagram_story_id {
    hidden: yes
    type: number
    sql: ${TABLE}.effective_instagram_story_id ;;
  }

  dimension: effective_object_story_id {
    hidden: yes
    type: string
    sql: ${TABLE}.effective_object_story_id ;;
  }

  dimension: image_file {
    hidden: yes
    type: string
    sql: ${TABLE}.image_file ;;
  }

  dimension: image_hash {
    hidden: yes
    type: string
    sql: ${TABLE}.image_hash ;;
  }

  dimension: image_url {
    hidden: yes
    type: string
    sql: ${TABLE}.image_url ;;
    html: "<img src='{{value}}' />" ;;
  }

  dimension: instagram_actor_id {
    hidden: yes
    type: number
    sql: ${TABLE}.instagram_actor_id ;;
  }

  dimension: instagram_permalink_url {
    hidden: yes
    type: string
    sql: ${TABLE}.instagram_permalink_url ;;
  }

  dimension: instagram_story_id {
    hidden: yes
    type: number
    sql: ${TABLE}.instagram_story_id ;;
  }

  dimension: link_caption {
    hidden: yes
    type: string
    sql: ${TABLE}.link_caption ;;
  }

  dimension: link_message {
    hidden: yes
    type: string
    sql: ${TABLE}.link_message ;;
  }

  dimension: link_og_id {
    hidden: yes
    type: number
    sql: ${TABLE}.link_og_id ;;
  }

  dimension: link_url {
    hidden: yes
    type: string
    sql: ${TABLE}.link_url ;;
  }

  dimension: name {
    hidden: yes
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: object_id {
    hidden: yes
    type: number
    sql: ${TABLE}.object_id ;;
  }

  dimension: object_story_id {
    hidden: yes
    type: string
    sql: ${TABLE}.object_story_id ;;
  }

  dimension: object_type {
    hidden: yes
    type: string
    sql: ${TABLE}.object_type ;;
  }

  dimension: object_url {
    hidden: yes
    type: string
    sql: ${TABLE}.object_url ;;
  }

  dimension: product_set_id {
    hidden: yes
    type: number
    sql: ${TABLE}.product_set_id ;;
  }

  dimension: status {
    hidden: yes
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: template_caption {
    hidden: yes
    type: string
    sql: ${TABLE}.template_caption ;;
  }

  dimension: template_message {
    hidden: yes
    type: string
    sql: ${TABLE}.template_message ;;
  }

  dimension: template_url {
    hidden: yes
    type: string
    sql: ${TABLE}.template_url ;;
  }

  dimension: thumbnail_url {
    type: string
    sql: ${TABLE}.thumbnail_url ;;
    html: "<img src='{{value}}' />" ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension: use_page_actor_override {
    hidden: yes
    type: yesno
    sql: ${TABLE}.use_page_actor_override ;;
  }

  dimension: video_id {
    hidden: yes
    type: number
    sql: ${TABLE}.video_id ;;
  }
}
