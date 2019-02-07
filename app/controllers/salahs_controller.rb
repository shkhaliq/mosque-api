class SalahsController < ApplicationController
  before_action :set_mosque
  before_action :set_mosque_salah, only: [:show, :update, :destroy]

  # GET /mosques/:mosque_id/salahs
  def index
    json_response(@mosque.salahs)
  end

  # GET /mosques/:mosque_id/salahs/:id
  def show
    json_response(@salah)
  end

  # POST /mosques/:mosque_id/salahs
  def create
    @mosque.salahs.create!(salah_params)
    json_response(@mosque, :created)
  end

  # PUT /mosques/:mosque_id/salahs/:id
  def update
    @salah.update(salah_params)
    head :no_content
  end

  # DELETE /mosques/:mosque_id/salahs/:id
  def destroy
    @salah.destroy
    head :no_content
  end

  private

  def salah_params
    params.permit(:name, :iqamah)
  end

  def set_mosque
    @mosque = Mosque.find(params[:mosque_id])
  end

  def set_mosque_salah
    @salah = @mosque.salahs.find_by!(id: params[:id]) if @mosque
  end
end
