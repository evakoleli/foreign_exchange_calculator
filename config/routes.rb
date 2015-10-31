ForeignExchangeCalculator::Application.routes.draw do
  get 'result' => 'welcome#result'

  root :to => 'welcome#index'
end
