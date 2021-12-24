Rails.application.routes.draw do
  namespace :public do
    get 'endusers/index'
    get 'endusers/show'
    get 'endusers/edit'
  end
  namespace :public do
    get 'markers/index'
  end
  namespace :public do
    get 'orders/new'
    get 'orders/confirm'
    get 'orders/complete'
    get 'orders/index'
  end
  namespace :enduser do
    get 'rooms/index'
    get 'rooms/show'
  end
  namespace :enduser do
    get 'items/index'
    get 'items/show'
  end
  namespace :enduser do
    get 'cart_items/index'
  end
  namespace :enduser do
    get 'posts/index'
    get 'posts/show'
    get 'posts/new'
    get 'posts/edit'
  end
  namespace :enduser do
    get 'coupons/index'
    get 'coupons/show'
  end
  namespace :enduser do
    get 'stores/index'
    get 'stores/show'
  end
  namespace :enduser do
    get 'deliveries/index'
    get 'deliveries/edit'
  end
  namespace :store do
    get 'post/index'
    get 'post/show'
  end
  namespace :store do
    get 'order_items/show'
  end
  namespace :store do
    get 'orders/show'
  end
  namespace :store do
    get 'items/new'
    get 'items/index'
    get 'items/edit'
    get 'items/show'
  end
  namespace :store do
    get 'genres/new'
    get 'genres/edit'
  end
  namespace :store do
    get 'coupons/new'
    get 'coupons/index'
    get 'coupons/edit'
  end
  namespace :store do
    get 'markers/index'
  end
  namespace :store do
    get 'stores/index'
    get 'stores/show'
    get 'stores/edit'
    get 'stores/unsubscribe'
  end
  namespace :admin do
    get 'stores/index'
    get 'stores/show'
    get 'stores/edit'
  end
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
