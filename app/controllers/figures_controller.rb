class FiguresController < ApplicationController

  get '/figures' do
    @all_figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    erb :'figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :'figures/show'
  end

  post '/figures' do
    @figure = Figure.new(name: params[:figure][:name])
    if !params[:figure][:title_ids].nil? && !params[:figure][:title_ids].empty?
      params[:figure][:title_ids].join.scan(/\d+/).each do |id|
        @title = Title.find_by_id(id)
        @figure.titles << @title
      end
    end
    if !params[:title][:name].nil? && !params[:title][:name].empty?
      @figure.titles.build(name: params[:title][:name])
    end
    if !params[:figure][:landmark_ids].nil? && !params[:figure][:landmark_ids].empty?
      params[:figure][:landmark_ids].join.scan(/\d+/).each do |id|
        @landmark = Landmark.find_by_id(id)
        @figure.landmarks << @landmark
      end
    end
    if !params[:landmark][:name].nil? && !params[:landmark][:name].empty?
      @figure.landmarks.build(name: params[:landmark][:name])
    end
    @figure.save
    redirect '/figures'
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.name = params[:figure][:name]
    if !params[:figure][:title_ids].nil? && !params[:figure][:title_ids].empty?
      params[:figure][:title_ids].join.scan(/\d+/).each do |id|
        @title = Title.find_by_id(id)
        @figure.titles << @title
      end
    end
    if !params[:title][:name].nil? && !params[:title][:name].empty?
      @figure.titles.build(name: params[:title][:name])
    end
    if !params[:figure][:landmark_ids].nil? && !params[:figure][:landmark_ids].empty?
      params[:figure][:landmark_ids].join.scan(/\d+/).each do |id|
        @landmark = Landmark.find_by_id(id)
        @figure.landmarks << @landmark
      end
    end
    if !params[:landmark][:name].nil? && !params[:landmark][:name].empty?
      @figure.landmarks.build(name: params[:landmark][:name])
    end
    @figure.save
    redirect "/figures/#{@figure.id}"
  end
end
