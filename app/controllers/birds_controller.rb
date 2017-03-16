class BirdsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  rescue_from StandardError, with: :error_response

  def index
    visible_birds = Birds.where(visible: true).pluck(:id)
    response = visible_birds.map{ |b| { id: b.to_s } }

    render json: response.to_json, status: 200
  end

  def show
    bird = Birds.find_by({ id: params[:id] })
    if bird.present?
      render json: bird_response(bird).to_json, status: 200
    else
      render nothing: true, status: 404
    end
  end

  def create
    obj = JSON.parse(request.raw_post)

    bird_params = { name: obj['name'],
                    family: obj['family'],
                    continents: obj['continents'],
                    visible: obj['visible'] || false,
                    added: Time.now.utc.strftime("%Y/%m/%d") }
    bird = Birds.create!(bird_params)

    render json: bird_response(bird).to_json, status: 201
  end

  def destroy
    bird = Birds.find_by({ _id: params[:id] })
    if bird.present? 
      bird.delete
      render nothing: true, status: 200
    else
      render nothing: true, status: 404
    end
  end

  private
  def error_response(exception)
    render json: { error: exception.message }.to_json, status: 400  and return
  end

  def bird_response(bird)
     { id: bird[:id].to_s,
       name: bird[:name],
       family: bird[:family],
       continents: bird[:continents],
       added: bird[:added].strftime("%Y/%m/%d"),
       visible: bird[:visible] }
  end
end
