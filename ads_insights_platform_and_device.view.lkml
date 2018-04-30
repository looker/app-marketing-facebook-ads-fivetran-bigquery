include: "ads_insights_base.view"

view: platform_and_device_base {
  extension: required

  dimension: impression_device {
    hidden: yes
    type: string
    sql: ${TABLE}.impression_device ;;
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
        label: "In-Stream Video"
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

view: ads_insights_platform_and_device {
  extends: [ads_insights_base, platform_and_device_base]
  sql_table_name: facebook_ads_fivetran.ads_insights_platform_and_device ;;
}
