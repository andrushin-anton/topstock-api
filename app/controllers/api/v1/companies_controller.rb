class Api::V1::CompaniesController < ApplicationController

  # GET /api/v1/companies
  def index
    expires_in 3.minutes, public: true

    @api_v1_companies = Api::V1::Company.order('rank DESC')
    paginate json: @api_v1_companies
  end

  # GET /api/v1/companies/:ticker
  def ticker
    expires_in 3.minutes, public: true
    render json: Api::V1::Company.find_by_ticker(params[:ticker])
  end

end
