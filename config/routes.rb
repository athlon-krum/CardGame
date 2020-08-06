Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      post 'games', to: 'games#create'
      get 'cards/:game_id', to: 'cards#show'
      get 'cards/compare-two-cards/:game_id', to: 'cards#compare_cards'
    end
  end
end
