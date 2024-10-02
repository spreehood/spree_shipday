Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :api do
    namespace :v2 do
      post 'shipday/webhooks', to: 'shipday#webhooks'
    end
  end
end
