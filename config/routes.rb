Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :games, only: %i[create] do
        member do
          put :draw
        end
      end

      resources :cards, only: [] do
        collection do
          post :compare
        end
      end
    end
  end
end
