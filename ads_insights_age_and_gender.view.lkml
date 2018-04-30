include: "ads_insights_base.view"

view: age_and_gender_base {
  extension: required

  dimension: age {
    type: string
    sql: ${TABLE}.age ;;
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

view: ads_insights_age_and_gender {
  extends: [ads_insights_base, age_and_gender_base]
  sql_table_name: facebook_ads_fivetran.ads_insights_age_and_gender ;;
}
