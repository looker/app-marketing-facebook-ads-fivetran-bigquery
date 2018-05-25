view: fivetran_base_fb_adapter {
  extension: required

  dimension: _fivetran_synced {
    hidden: yes
    type: date_time
  }
}
