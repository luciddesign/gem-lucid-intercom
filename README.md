lucid_intercom
==============

Installation
------------

Add the following lines to your ‘Gemfile’:

    git_source :lucid { |r| "https://github.com/lucidnz/gem-lucid_#{r}.git" }

    gem 'lucid_intercom', lucid: 'intercom'


Usage
-----

### Configure the default API credentials

    LucidIntercom.credentials = LucidIntercom::Credentials.new(
      '...', # access_token
      '...', # secret
      '...', # app_id
      '...'  # app_prefix
    )

Here, ‘app_prefix’ is the snakecased app name, e.g. ‘smart_order_tags’

Alternatively, a credentials object may optionally be passed as a
keyword argument to any of the classes listed below.


### Render the browser snippet

    LucidIntercom::RenderSnippet.new(shop_attributes, app_attributes).()

This returns an HTML string which you can use in your view layout.

See the source code for documentation of arguments.


### Send an event

When a user installs/uninstalls the app, or changes their plan:

    LucidIntercom::Events::Installed.new(shop_attributes).(plan_name)
    LucidIntercom::Events::Uninstalled.new(shop_attributes).()
    LucidIntercom::Events::ChangedPlan.new(shop_attributes).(plan_name)

Note that the `shop_attributes` hash for uninstalled events cannot
be read from the API (as the access token is invalid at this stage).
You should use the data hash provided with Shopify’s ‘app/uninstalled’
webhook instead.


### Plan names

For installed apps, yet to subscribe to a plan, use ‘pending’.

For apps with a single paid plan, use ‘subscribed’.

For free apps, use ‘free’.

For partner-friendly app installs, use ‘partner’.


### Send a custom event

    LucidIntercom::SendEvent.new(shop_attributes).(event_name, event_metadata)

See the source code for documentation of arguments.


### Update a user

    LucidIntercom::UpdateUser.new(shop_attributes, app_attributes).()

When this is called, and the user did not previously exist, the
user will be created.
