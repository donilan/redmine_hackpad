RedmineApp::Application.routes.draw do
  get 'hackpads/:pid' => 'hackpads#show', :as => :hackpads_show
end
