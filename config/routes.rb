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

scope module: :public do
    root to: 'homes#top'
    get 'about' => 'homes#about'
    resources :endusers,except:[:destroy]
    resources :items,only:[:index,:show]
    resources :cart_items,except:[:show,:new,:edit]
    delete 'cart_items' => 'cart_items#destroy_all'
    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
    resources :orders,except:[:edit]
    resources :deliveries,except:[:show]
  end

scope module: :store do
  root to: 'homes#top'
  resources :stores,only:[:index,:show,:edit] do
    get 'unsubscribe' => 'stores#unsubscribe'
    patch 'withdraw' => 'stores#withdraw'
  end
  resources :genres,except:[:show,:destroy]
  resources :items,except:[:destroy]
  resources :markers,except:[:new,:create,:destroy]
  resources :orders,only:[:index,:show,:update]
  resources :order_details,only:[:update]
end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end