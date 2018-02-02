require 'rails_helper'
require_relative '../../../../app/services/api/v1/common_service'

RSpec.describe Api::V1::CommonService, type: :service do
  # check_if_data_exists
  it "returns false because no data provided" do
    expect(Api::V1::CommonService.check_if_data_exists(nil)).to eq(false)
  end

  it "returns false because empty string provided" do
    expect(Api::V1::CommonService.check_if_data_exists('')).to eq(false)
  end

  it "returns false because empty array provided" do
    expect(Api::V1::CommonService.check_if_data_exists('[]')).to eq(false)
  end

  it "returns hash with data because json string has some data" do
    expect(Api::V1::CommonService.check_if_data_exists('[{"date":"2016-10-31","value":0.109791},{"date":"2015-10-31","value":0.084653}]')).to eq(JSON.parse('[{"date":"2016-10-31","value":0.109791},{"date":"2015-10-31","value":0.084653}]'))
  end


  # has_grown
  it "returns 1 because value has grown once" do
    input_data = Api::V1::CommonService.check_if_data_exists('[{"date":"2016-10-31","value":22},{"date":"2015-10-31","value":20}]')
    expect(Api::V1::CommonService.has_grown(input_data, 2)).to eq(1)
  end

  it "returns 2 because value has grown twice" do
    input_data = Api::V1::CommonService.check_if_data_exists('[{"date":"2016-10-31","value":25},{"date":"2016-10-31","value":22},{"date":"2015-10-31","value":20}]')
    expect(Api::V1::CommonService.has_grown(input_data, 3)).to eq(2)
  end

  it "returns 2 because value has grown more than 3 times" do
    input_data = Api::V1::CommonService.check_if_data_exists('[{"date":"2016-10-31","value":25},{"date":"2016-10-31","value":22},{"date":"2015-10-31","value":20},{"date":"2014-10-31","value":18},{"date":"2013-10-31","value":15}]')
    expect(Api::V1::CommonService.has_grown(input_data, 3)).to eq(2)
  end

  it "returns 0 because value has not grown at all" do
    input_data = Api::V1::CommonService.check_if_data_exists('[{"date":"2016-10-31","value":10},{"date":"2016-10-31","value":11},{"date":"2015-10-31","value":12},{"date":"2014-10-31","value":13},{"date":"2013-10-31","value":14}]')
    expect(Api::V1::CommonService.has_grown(input_data, 3)).to eq(0)
  end

end
