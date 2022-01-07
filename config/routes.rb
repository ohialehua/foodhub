Rails.application.routes.draw do

  devise_for :endusers,skip: [:passwords,], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :stores,skip: [:passwords,], controllers: {
  registrations: "store/registrations",
  sessions: 'store/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  root to: 'homes#top'
  resources :stores,only:[:index,:show,:edit]
end

namespace :store do
  root to: 'homes#top'
  resources :stores,only:[:index,:show,:edit]
  resources :genres,except:[:show,:destroy]
  resources :items,except:[:destroy]
  resources :markers,only:[:index]
  resources :orders,only:[:index,:show,:update]
  resources :order_details,only:[:update]
  get 'unsubscribe' => 'stores#unsubscribe'
  patch 'withdraw' => 'stores#withdraw'
end

scope module: :public do
  root to: 'homes#top'
  get 'about' => 'homes#about'
  resources :endusers,except:[:destroy] do
   post 'edit' => 'endusers#edit'
   get 'add' =>  'endusers#add'
   post 'add' =>  'endusers#add'
 end
  resources :stores,only:[:index,:show] do
    delete 'markers' => 'markers#destroy', as: 'unmark'
    post 'markers' => 'markers#create', as: 'mark'
  end
  resources :items,only:[:index,:show]
  resources :cart_items,except:[:show,:new,:edit]
  delete 'cart_items' => 'cart_items#destroy_all'
  post 'orders/confirm' => 'orders#confirm'
  get 'orders/complete' => 'orders#complete'
  resources :orders,except:[:edit]
  resources :deliveries,except:[:show]
  resources :posts,except:[:edit,:index]
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end