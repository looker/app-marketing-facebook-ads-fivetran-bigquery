include: "account_adapter.view"
include: "fivetran_base.view"

view: account {
  extends: [fivetran_base, account_adapter]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }

  dimension: name {
    hidden: yes
    type: string
  }

  measure: count {
    hidden: yes
    type: count
  }
}
