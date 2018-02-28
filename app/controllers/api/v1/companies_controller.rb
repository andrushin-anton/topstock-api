require_relative '../../../../lib/utilities'

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

  # POST /api/v1/companies/stats/:ticker
  def pull_stats
    company = Api::V1::Company.find_by_ticker(params[:ticker])
    unless company.nil?
      puts "Pulling data for company #{company.ticker}"
      # Update current status to RUNNING
      company.status = Api::V1::Company::STATUS_RUNNING
      company.save
      # Find statistics row or initialize new for a given company
      statistics = Api::V1::Stats.find_by_ticker(company.ticker)
      # Pull the stats
      puts "Preparing to pull stats for: #{company.ticker},  #{company.name}"
      puts '................................................................'
      response = Utilities.pull_in_stats(company, statistics, 0)

      if response === 1
        render json: { message: 'Stats have been successfully pulled!' }
      else
        render json: { message: 'Try later...' }
      end
    end
  end

end
