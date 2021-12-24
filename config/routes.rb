Rails.application.routes.draw do
  devise_for :stores,skip: [:passwords,], controllers: {
  registrations: "store/registrations",
  sessions: 'store/sessions'
}
  devise_for :endusers,skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
