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
  resources :stores,only:[:show,:update]
end

namespace :store do
  root to: 'homes#top'
  resources :stores,only:[:edit,:update]
  get 'unsubscribe' => 'stores#unsubscribe'
  patch 'withdraw' => 'stores#withdraw'
  resources :genres,except:[:show,:destroy]
  resources :items,except:[:index,:destroy]
  resources :posts,except:[:edit,:index] do
    resources :post_comments,only: [:create,:destroy]
  end
  resources :markers,only:[:index,:show]
  resources :store_orders,only:[:index,:show,:update]
  resources :order_details,only:[:update]
end

scope module: :public do
  root to: 'homes#top'
  get 'about' => 'homes#about'
  resources :endusers,except:[:destroy] do
   post 'edit' => 'endusers#edit'
   get 'add' =>  'endusers#add'
   post 'add' =>  'endusers#add'
   resource :relationships,only: [:create,:destroy]
 end
  resources :stores,only:[:index,:show] do
    delete 'markers' => 'markers#destroy', as: 'unmark'
    post 'markers' => 'markers#create', as: 'mark'
  end
  resources :items,only:[:index,:show]
  delete 'cart_items' => 'cart_items#destroy_all'
  resources :cart_items,except:[:index,:show,:new,:edit]
  post 'orders/confirm' => 'orders#confirm'
  get 'orders/complete' => 'orders#complete'
  resources :orders,except:[:edit,:update,:destroy]
  resources :deliveries,except:[:show]
  resources :posts,except:[:edit,:index] do
    resources :post_comments,only: [:create,:destroy]
    resource :favorites,only: [:create,:destroy]
  end
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end