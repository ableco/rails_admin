require 'rails_admin'
require 'rails'

module RailsAdmin
  class Engine < Rails::Engine
    isolate_namespace RailsAdmin

    ActionDispatch::Callbacks.before do
      RailsAdmin.setup
    end

    initializer "rails admin development mode" do |app|
      ActionDispatch::Callbacks.after do
        RailsAdmin.reset if !app.config.cache_classes && RailsAdmin.config.reload_between_requests
      end
    end
    
    initializer "add assets to precompile pipeline" do |app|
      # All JS
      app.config.assets.precompile += Dir.glob(File.expand_path("../../../app/assets/javascripts/rails_admin/rails_admin.js", __FILE__))
      # All CSS images
      app.config.assets.precompile += Dir.glob(File.expand_path("../../../app/assets/stylesheets/rails_admin/rails_admin.css", __FILE__))
      # All images
      app.config.assets.precompile += Dir.glob(File.expand_path("../../../app/assets/images/rails_admin/**/*", __FILE__))
    end
  end
end
