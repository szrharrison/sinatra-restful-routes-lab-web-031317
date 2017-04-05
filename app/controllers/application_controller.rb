class ApplicationController < Sinatra::Base
  def recipes
    Recipe.all
  end

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    erb :index
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create( name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time] )
    redirect to "/recipes/#{ @recipe.id }"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find( params[:id] )
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find( params[:id] )
    erb :edit
  end

  patch '/recipes/:id' do
    @recipe = Recipe.find( params[:id] )
    @recipe.update( name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time] )
    redirect to "/recipes/#{ @recipe.id }"
  end

  delete '/recipes/:id/delete' do
    @recipe = Recipe.find( params[:id] )
    @recipe.destroy
    redirect to "/recipes"
  end
end
