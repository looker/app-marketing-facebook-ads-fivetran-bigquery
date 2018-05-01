view: fivetran_base {
  extension: required

  dimension: _fivetran_synced {
    hidden: yes
    type: date_time
  }
}
