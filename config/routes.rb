RedmineApp::Application.routes.draw do
  match 'hackpads/:pid', :to => 'hackpads#show', :as => :hackpads_show, via: [:get]
end
