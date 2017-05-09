lucid-intercom
==============

Installation
------------

Add the following line to your ‘Gemfile’:

    gem 'lucid-intercom', github: 'luciddesign/gem-lucid-intercom'


Configuration
-------------

### Environment

Set ‘APP_ID’ to the Intercom app ID.

Set ‘APP_PREFIX’ to the snakecased app name, e.g. ‘smart_order_tags’.


Usage
-----

### Render the browser snippet

    require 'lucid/intercom/render_snippet'

    Lucid::Intercom::RenderSnippet.new.(shop_attributes, app_attributes)

This returns an HTML string which you can use in your view layout.

See the source code documentation for format of the arguments.
