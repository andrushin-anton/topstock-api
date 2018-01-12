class Api::V1::CompaniesController < ApplicationController

  # GET /api/v1/companies
  def index
    @api_v1_companies = Api::V1::Company.order('rank DESC')

    paginate json: @api_v1_companies
  end

  # GET /api/v1/companies/:ticker
  def ticker
    render json: Api::V1::Company.find_by_ticker(params[:ticker])
  end

end
