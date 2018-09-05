# Facebook Ads

LookML files for a schema mapping on BigQuery for Facebook Ads compatible with [Fivetran's Ads Insights ETL](https://fivetran.com/docs/applications/facebook-ads-insights). This is designed to work with a ETL agnostic [Facebook Ads block](https://github.com/looker/app-marketing-facebook-ads).

## To use this block, you will need to:

### Include it in your [manifest.lkml](https://docs.looker.com/reference/manifest-reference):

Note: This requires the Project Import feature currently in /admin/labs to be enabled on your Looker instance.

#### Via local projects:

Fork this repo and create a new project named `app-marketing-facebook-ads-adapter`

manifest.lkml
```LookML
local_dependency: {
  project: "app-marketing-facebook-ads-adapter"
}


local_dependency: {
  project: "app-marketing-facebook-ads"
}```

Or remote dependency which don't require a local version.

manifest.lkml
```LookML

remote_dependency: app-marketing-facebook-ads-adapter {
  url: "git://github.com/looker/app-marketing-facebook-ads-fivetran-bigquery"
  ref: "16795ca4726f79f808d274a4765781c72c974d4b"
}

remote_dependency: app-marketing-facebook-ads {
  url: "git://github.com/looker/app-marketing-facebook-ads"
  ref: "5a7d003d98be5b5adc93d7fd90bdd4105461186a"
}```

Note that the `ref:` should point to the latest commit in each respective repo [facebook-ads-fivetran-bigquery](https://github.com/looker/app-marketing-facebook-ads-fivetran-bigquery/commits/master) and [facebook-ads](https://github.com/looker/app-marketing-facebook-ads/commits/master).

2. Create a `facebook_ads_config` view that is assumed by this project. This configuration requires a  file

For example:

facebook_ads_config.view.lkml
```LookML
view: facebook_ads_config {
  extension: required

  dimension: facebook_ads_schema {
    hidden: yes
    sql:facebook_ads;;
  }
}
```

3. Include the view files in your model.

For example:

marketing_analytics.model.lkml
```LookML
include: "/app-marketing-facebook-ads-adapter/*.view"
include: "/app-marketing-facebook-ads/*.view"
include: "/app-marketing-facebook-ads/*.dashboard"
```


For a reference of all of the fields names and definitions reference Facebook’s API documentation for [breakdowns](https://developers.facebook.com/docs/marketing-api/insights/breakdowns) and [parameters](https://developers.facebook.com/docs/marketing-api/insights/parameters).
