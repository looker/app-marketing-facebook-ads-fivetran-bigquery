include: "/app_marketing_analytics_config/facebook_ads_config.view"

view: ad_impressions_adapter {
  extension: required
  extends: [facebook_ads_config]
  sql_table_name:
  {% if (fact.impression_device._in_query or fact.device_type._in_query or fact.platform_position._in_query or fact.publisher_platform._in_query) %}
    {{ fact.facebook_ads_schema._sql }}.ads_insights_platform_and_device
  {% elsif (fact.country._in_query) %}
    {% if (fact.region._in_query) %}
    {{ fact.facebook_ads_schema._sql }}.ads_insights_region
    {% else %}
    {{ fact.facebook_ads_schema._sql }}.ads_insights_country
    {% endif %}
  {% elsif (fact.age._in_query or fact.gender._in_query) %}
    {{ fact.facebook_ads_schema._sql }}.ads_insights_age_and_gender
  {% elsif (fact.hour._in_query) %}
    {{ fact.facebook_ads_schema._sql }}.ads_insights_hour
  {% else %}
    {{ fact.facebook_ads_schema._sql }}.ads_insights
  {% endif %} ;;
}

view: ad_impressions_actions_adapter {
  extension: required
  extends: [facebook_ads_config]
  sql_table_name:
  {% if (fact.impression_device._in_query or fact.device_type._in_query or fact.platform_position._in_query or fact.publisher_platform._in_query) %}
    {{ fact.facebook_ads_schema._sql }}.ads_insights_platform_and_device_actions
  {% elsif (fact.country._in_query) %}
    {% if (fact.region._in_query) %}
    {{ fact.facebook_ads_schema._sql }}.ads_insights_region_actions
    {% else %}
    {{ fact.facebook_ads_schema._sql }}.ads_insights_country_actions
    {% endif %}
  {% elsif (fact.age._in_query or fact.gender._in_query) %}
    {{ fact.facebook_ads_schema._sql }}.ads_insights_age_and_gender_actions
  {% elsif (fact.hour._in_query) %}
    {{ fact.facebook_ads_schema._sql }}.ads_insights_hour_actions
  {% else %}
    {{ fact.facebook_ads_schema._sql }}.ads_insights_actions
  {% endif %} ;;
}
