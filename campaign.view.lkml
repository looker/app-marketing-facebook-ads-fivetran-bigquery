include: "/app_marketing_analytics_config/facebook_ads_config.view"

include: "account.view"
include: "fivetran_base.view"

explore: campaign_fb_adapter {
  view_name: campaign
  from: campaign_fb_adapter
  hidden: yes

  join: account {
    from: account_fb_adapter
    type: left_outer
    sql_on: ${campaign.account_id} = ${account.id} ;;
    relationship: many_to_one
  }
}

view: campaign_fb_adapter {
  extends: [fivetran_base_fb_adapter, facebook_ads_config]
  sql_table_name: {{ campaign.facebook_ads_schema._sql }}.campaign ;;

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
    label: "Campaign Name"
    hidden: yes
    type: string
  }
}
