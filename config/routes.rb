Rails.application.routes.draw do

  root 'welcome#index'

  get 'result' => 'welcome#result'

end
