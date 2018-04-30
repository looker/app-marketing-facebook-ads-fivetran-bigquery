include: "account.view"
include: "campaign_adapter.view"
include: "fivetran_base.view"

explore: campaign {

  join: account {
    type: left_outer
    sql_on: ${campaign.account_id} = ${account.id} ;;
    relationship: many_to_one
  }
}

view: campaign {
  extends: [fivetran_base, campaign_adapter]

  dimension: id {
    hidden: yes
    primary_key: yes
    type: string
  }

  dimension: account_id {
    hidden: yes
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
