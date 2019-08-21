view: fivetran_base_fb_adapter {
  extension: required
  extends: [facebook_ads_config]

  dimension: _fivetran_synced {
    hidden: yes
    type: date_time
  }

  dimension: facebook_ad_account_schema {
    hidden: yes
    sql:{{ facebook_ads_schema._sql }};;
  }
}
