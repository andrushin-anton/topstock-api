require 'rails_helper'
require_relative '../../../../app/services/api/v1/economic_moat_service'

RSpec.describe Api::V1::EconomicMoatService, type: :service do
  #ROE
  it "returns score 0 because no data provided" do
    expect(Api::V1::EconomicMoatService.filter_roe('[]')).to eq(0)
  end

  it "returns score 0 because only 2 times the roe was bigger than 15%" do
    expect(Api::V1::EconomicMoatService.filter_roe('[{"date":"2016-10-31","value":0.169791},{"date":"2015-10-31","value":0.184653},{"date":"2014-10-31","value":0.103653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(0)
  end

  it "returns score 1 because the roe was bigger than 15% in the last 3 years" do
    expect(Api::V1::EconomicMoatService.filter_roe('[{"date":"2016-10-31","value":0.169791},{"date":"2015-10-31","value":0.184653},{"date":"2014-10-31","value":0.193653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(1)
  end

  it "returns score 0 because the roe was not bigger than 15% in the last 3 years" do
    expect(Api::V1::EconomicMoatService.filter_roe('[{"date":"2016-10-31","value":0.109791},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.033653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(0)
  end

  #ROA
  it "returns score 0 because no data provided" do
    expect(Api::V1::EconomicMoatService.filter_roa('[]')).to eq(0)
  end

  it "returns score 0 because only 2 times the roe was bigger than 6%" do
    expect(Api::V1::EconomicMoatService.filter_roa('[{"date":"2016-10-31","value":0.069791},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.043653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(0)
  end

  it "returns score 1 because the roe was bigger than 6% in the last 3 years" do
    expect(Api::V1::EconomicMoatService.filter_roa('[{"date":"2016-10-31","value":0.109791},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.073653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(1)
  end

  it "returns score 0 because the roe was not bigger than 6% in the last 3 years" do
    expect(Api::V1::EconomicMoatService.filter_roa('[{"date":"2016-10-31","value":0.029791},{"date":"2015-10-31","value":0.014653},{"date":"2014-10-31","value":0.033653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(0)
  end


  # Depreciation / Gross Profit
  it "returns score 0 because no data provided" do
    expect(Api::V1::EconomicMoatService.filter_dep('[]', '[{"date":"2016-10-31","value":2197000000.0}]')).to eq(0)
  end

  it "returns score 0 because no data provided" do
    expect(Api::V1::EconomicMoatService.filter_dep('[{"date":"2016-10-31","value":2197000000.0}]', '[]')).to eq(0)
  end

  it "returns score 2 because the result is less than 8%" do
    expect(Api::V1::EconomicMoatService.filter_dep('[{"date":"2016-10-31","value":246000000.0},{"date":"2015-10-31","value":253000000.0}]', '[{"date":"2016-10-31","value":3360000000.0},{"date":"2015-10-31","value":2041000000.0}]')).to eq(2)
  end

  it "returns score 1 because the result is bigger than 8% but less than 18%" do
    expect(Api::V1::EconomicMoatService.filter_dep('[{"date":"2016-10-31","value":246000000.0},{"date":"2015-10-31","value":253000000.0}]', '[{"date":"2016-10-31","value":2360000000.0},{"date":"2015-10-31","value":2041000000.0}]')).to eq(1)
  end

  it "returns score 0 because the result is bigger than 18%" do
    expect(Api::V1::EconomicMoatService.filter_dep('[{"date":"2016-10-31","value":246000000.0},{"date":"2015-10-31","value":253000000.0}]', '[{"date":"2016-10-31","value":246000000.0},{"date":"2015-10-31","value":2041000000.0}]')).to eq(0)
  end


  # Final Score
  it "returns score VERY_STRONG" do
    expect(Api::V1::EconomicMoatService.final_score(1,1, 2)).to eq(Api::V1::EconomicMoatService::VERY_STRONG)
  end

  it "returns score STRONG" do
    expect(Api::V1::EconomicMoatService.final_score(1,1, 1)).to eq(Api::V1::EconomicMoatService::STRONG)
  end

  it "returns score WEAK" do
    expect(Api::V1::EconomicMoatService.final_score(1,1, 0)).to eq(Api::V1::EconomicMoatService::WEAK)
  end

  it "returns score WEAK when roa and dep are 0" do
    expect(Api::V1::EconomicMoatService.final_score(1,0, 0)).to eq(Api::V1::EconomicMoatService::WEAK)
  end

end