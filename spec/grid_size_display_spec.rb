require 'spec_helper'
require 'rack'
require 'rack/lint'
require 'rack/mock'
require 'rack/test'

describe GridSizeDisplay do
  include Rack::Test::Methods

  let(:display_container) { %q{<div id="grid-size-display-container"></div></body>} }
  let(:example_html) { "<html><head></head><body><h1>Example Page</h1></body></html>" }
  let(:inner_app) do
    proc { |env|
      [
        200,
        {
          'Content-Type' => 'text/html; charset=utf-8',
          'Content-Length' => example_html.bytesize.to_s
        },
        [example_html]
      ]
    }
  end
  let(:request)  { Rack::MockRequest.new(Rack::Lint.new(stack)) }
  let(:stack) { GridSizeDisplay::Rack.new(inner_app) }

  it 'has a version number' do
    expect(GridSizeDisplay::VERSION).not_to be nil
  end

  context 'not including parameter' do
    let(:url) { '/' }

    context 'when no session variable' do
      let(:display_session_var) { nil }

      it { expect(get_with_session.body).to include(display_container) }
    end

    context 'with true session variable' do
      let(:display_session_var) { true }

      it { expect(get_with_session.body).to include(display_container) }
    end

    context 'with false session variable' do
      let(:display_session_var) { false }

      it { expect(get_with_session.body).not_to include(display_container) }
    end
  end


  context 'setting as disabled' do
    let(:url) { '/?grid_size_display=disable' }

    context 'when no session variable' do
      let(:display_session_var) { nil }

      it { expect(get_with_session.body).not_to include(display_container) }
    end

    context 'with true session variable' do
      let(:display_session_var) { true }

      it { expect(get_with_session.body).not_to include(display_container) }
    end

    context 'with false session variable' do
      let(:display_session_var) { false }

      it { expect(get_with_session.body).not_to include(display_container) }
    end
  end

  context 'setting as enabled' do
    let(:url) { '/?grid_size_display=enable' }

    context 'when no session variable' do
      let(:display_session_var) { nil }

      it { expect(get_with_session.body).to include(display_container) }
    end

    context 'with true session variable' do
      let(:display_session_var) { true }

      it { expect(get_with_session.body).to include(display_container) }
    end

    context 'with false session variable' do
      let(:display_session_var) { false }

      it { expect(get_with_session.body).to include(display_container) }
    end
  end


  def get_with_session
    request.get url, { 'rack.session' => { 'grid_size_display' => display_session_var } }
  end
end
