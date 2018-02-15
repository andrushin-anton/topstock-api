require 'rails_helper'
require_relative '../../../../app/services/api/v1/real_price_service'

RSpec.describe Api::V1::RealPriceService, type: :service do

  # avg ROE
  it "returns 0 because no data provided" do
    expect(Api::V1::RealPriceService.avg_roe('[]')).to eq(0)
  end

  it "returns 0.1" do
    expect(Api::V1::RealPriceService.avg_roe('[{"date":"2016-10-31","value":0.109791},{"date":"2015-10-31","value":0.084653}]')).to eq(0.1)
  end

  it "returns 0.13 when more than 3 values available" do
    expect(Api::V1::RealPriceService.avg_roe('[{"date":"2016-10-31","value":0.109791},{"date":"2015-10-31","value":0.084653},{"date":"2015-10-31","value":0.184653},{"date":"2015-10-31","value":0.134653},{"date":"2015-10-31","value":0.284653}]')).to eq(0.13)
  end


  # projected book value per share
  it "returns 27.95" do
    avg_roe = 40.64 / 100
    expect(Api::V1::RealPriceService.projected_book_value_per_share(5.08, avg_roe, 5)).to eq(27.95)
  end


  # lowest PE
  it "returns 32.4442 because it is lowest in the last 3 years" do
    expect(Api::V1::RealPriceService.lowest_pe('[{"date":"2018-01-23","value":37.8222},{"date":"2017-12-29","value":34.4901},{"date":"2016-12-30","value":32.4442},{"date":"2016-12-30","value":12.4442}]')).to eq(32.4442)
  end

  it "returns 0 because no data provided" do
    expect(Api::V1::RealPriceService.lowest_pe('[]')).to eq(0)
  end


  # max buy price
  it "returns 44.95" do
    expect(Api::V1::RealPriceService.max_buy_price(131.78, 0.24, 5)).to eq(44.95)
  end

  it "returns 69.12" do
    expect(Api::V1::RealPriceService.max_buy_price(131.78)).to eq(69.12)
  end

  it "returns 0" do
    expect(Api::V1::RealPriceService.max_buy_price(0)).to eq(0)
  end

end