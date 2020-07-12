class ReviewsController < ApplicationController
 
  get '/reviews/new' do 
    erb :'/reviews/new'
  end 
    
  post '/reviews' do 
    @review = Review.create(title: params[:title], author: params[:author], review: params[:review])
    redirect "/reviews/#{@review.id}"
  end

  get '/reviews/:id' do 
    @review = Review.find_by_id(params[:id])
    erb :'reviews/show'
  end 
 
  get '/reviews' do 
    @reviews = Review.all 
    erb :'/reviews/index'
  end

  get '/reviews/:id/edit' do 
    @review = Review.find_by_id(params[:id])
    erb :'/reviews/edit'
  end
 
  patch '/reviews/:id' do 
    @review = Review.find_by_id(params[:id])
    @review.text = params[:new_review]
    @review.save
    redirect to "/reviews/#{@review.id}"
  end

  delete '/reviews/:id' do 
    @review = Review.find_by_id(params[:id])
    @review.delete
    redirect '/users/show'
  end
end