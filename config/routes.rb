Rails.application.routes.draw do

  scope module: :public do
    root to:'homes#top'
    get 'about'=>'homes#about',as:'about'
    
    get 'customers/my_page'=>'/customers#show'
    get 'customers/information/edit'=>'/customers#edit'
    patch 'customers/information'=>'customers#update'
    get 'customers/confirm'=>'customers#confirm'
    patch '/customers/withdrawal'=>'customers#withdrawal'
    
    resources:items,only:[:index,:show]
    resources:cart_items,only:[:index,:create,:update,:destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    resources:orders,only:[:new,:create,:index,:show] do
      collection do
        post 'confirm'
        get  'done'
      end
    end
    resources:addresses,only:[:create,:index,:edit,:update,:destroy]
  end


  devise_for :customers,skip:[:passwords],controllers:{
    registrations:"public/registrations",
    sessions:'public/sessions'
  }

  devise_for :admin,skip:[:registrations,:passwords],controllers:{
    sessions:"admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
