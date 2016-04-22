module GridSizeDisplay
  class Engine < ::Rails::Engine

    isolate_namespace GridSizeDisplay

    initializer "rails-bootstrap-sass_grid_size_display.add_middleware" do |app|
      app.middleware.use GridSizeDisplay::Rack
    end
  end

  class Rack
    DEFAULT_INSERTION_POINT = '</body>'.freeze
    HTML_CONTENT_TYPE = 'text/html'.freeze

    def initialize(app, options = {})
      @app, @options = app, options
      @options[:insertion_point] ||= DEFAULT_INSERTION_POINT
    end

    def call(env)
      status, headers, response = @app.call(env)

      req = process_display_param(env)

      if headers['Content-Type'].to_s.include?(HTML_CONTENT_TYPE) && display_grid?(req)
        new_response = []
        response.each do |body|
          # find the last matching insertion point in the body and insert the content
          partition = body.rpartition(@options[:insertion_point])
          partition[0] += %q{<div id="grid-size-display-container"></div>}
          new_response << partition.join
        end

        # Update the content-length
        headers['Content-Length'] = new_response.inject(0) do |len, body|
          len += body.bytesize
        end.to_s

        [status, headers, new_response]
      else
        [status, headers, response]
      end
    end

    def display_grid?(req)
      ::GridSizeDisplay.config.enabled? && req.session['grid_size_display']
    end


    def process_display_param(env)
      req = ::Rack::Request.new(env)

      case req.params['grid_size_display']
      when 'enable' then req.session['grid_size_display'] = true
      when 'disable' then req.session['grid_size_display'] = false
      end

      req.session['grid_size_display'] = true if req.session['grid_size_display'].nil?
      req
    end

  end
end
