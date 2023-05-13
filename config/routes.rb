Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1, defaults: { format: 'json' } do
      resources :people, only: %i[create index] do
        collection do
          put :validate_email
        end
      end
    end
  end
end
