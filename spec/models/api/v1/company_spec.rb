require 'rails_helper'

RSpec.describe Api::V1::Company, type: :model do
  it "returns 5.0" do
    expect(Api::V1::Company.find_out_company_rank(4,4, 55.24, 37.56)).to eq(5.0)
  end

  it "returns 3.5" do
    expect(Api::V1::Company.find_out_company_rank(3,3, 55.24, 55.44)).to eq(3.5)
  end

  it "returns 3.5" do
    expect(Api::V1::Company.find_out_company_rank(3,3, 55.24, 55.44)).to eq(3.5)
  end
end
