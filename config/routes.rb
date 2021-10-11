Rails.application.routes.draw do
  constraints(subdomain: Constraints::Subdomain.new.to_regexp) do
    resources :posts
  end
end
