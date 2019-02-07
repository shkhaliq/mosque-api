class MosquesController < ApplicationController
  before_action :set_mosque, only: [:show, :update, :destroy]

  # GET /mosques
  def index
    @mosques = Mosque.all
    json_response(@mosques)
  end

  # POST /mosques
  def create
    @mosque = Mosque.create!(mosque_params)
    json_response(@mosque, :created)
  end

  # GET /mosques/:id
  def show
    json_response(@mosque)
  end

  # PUT /mosques/:id
  def update
    @mosque.update(mosque_params)
    head :no_content
  end

  # DELETE /mosques/:id
  def destroy
    @mosque.destroy
    head :no_content
  end

  private

  def mosque_params
    # whitelist params
    params.permit(:name, :publicly_accessible, :website_url)
  end

  def set_mosque
    @mosque = Mosque.find(params[:id])
  end
end
