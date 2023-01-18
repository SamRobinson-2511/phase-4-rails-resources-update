class BirdsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :bird_not_found

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  def update
    bird = find_bird
    bird.update!(bird_params)
    render json: bird
  end

  def increment_likes 
    bird = find_bird
    if bird
      bird.update!(likes: bird.likes + 1)
      render json: Bird
    else
      bird_not_found
    end
  end

  private

  def find_bird
    Bird.find(params[:id])
  end

  def bird_params
    params.permit(:name, :species, :likes)
  end

  def bird_not_found
    render json: { errors: ['Bird not found'] }, status: :not_found
  end

end
