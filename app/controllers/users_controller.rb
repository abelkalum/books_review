class UsersController < ApplicationController 
   
  get '/users/signup' do
    erb :'/users/signup'
  end
 
  post '/users/signup' do
    if params[:email] == "" && params[:password] == ""
      redirect "/users/signup"
    else
      @user = User.create(email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    end
  end
 
  get '/users/login' do 
    if !logged_in?
      erb :'/users/login'
    else
      @user = User.find_by(session[:id])
      redirect "/users/#{@user.id}"
    end
  end

  post '/users/login' do 
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{@user.id}"
    else 
      redirect “/users/login”
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end
    
  get '/users/logout' do 
    if logged_in? 
      session.clear 
      redirect '/'
    end
  end
end