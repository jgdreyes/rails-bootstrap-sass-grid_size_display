# GridSizeDisplay

If you are using Rails and the bootstrap-sass gem, display a visual indicator to let
you know what bootstrap grid size you are using.  This gem uses the default
bootstrap variables names to determine grid sizes.  The gem works even if you've overwritten
the default values of the variables.


From the Bootstrap3 documentation:
```
@media (max-width: @screen-xs-max) { ... }
@media (min-width: @screen-sm-min) and (max-width: @screen-sm-max) { ... }
@media (min-width: @screen-md-min) and (max-width: @screen-md-max) { ... }
@media (min-width: @screen-lg-min) { ... }
```

- `col-xs-*` = Red
- `col-sm-*` = Orange
- `col-md-*` = Yellow
- `col-lg-*` = Green





## Installation

Add this line to your applications Rails + bootstrap-sass enabled application Gemfile:

```ruby
gem 'gem_size_display'
```

And then execute:

```
$ bundle
```

Include the Sass partial to your application.scss file. Be sure to include it after bootstrap.
```sass
// app/assets/stylesheets/application.scss
...
@import "bootstrap-sprockets";
@import "bootstrap";
@import "grid_size_display/media_sizes";
```

## Configuration

The gem is enabled by default if you are in development environment.
You can add an initializer to control when to enable the gem:
```ruby
# config/initializers/grid_size_display.rb

GridSizeDisplay.configure do |config|
  # config.enabled = false
  # config.enabled = Rails.env.development?
end
```


## Special query strings

By default the visual indicator will be displayed on every request.  If you include
the query string `grid_size_display=disable` at the end of your request you will disable
the display for your session.  To re-enable just add the query string `grid_size_display=enable`.
