Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "resumes/search"
    end
  end
end
