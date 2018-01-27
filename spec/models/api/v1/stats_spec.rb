require 'rails_helper'

RSpec.describe Api::V1::Stats, type: :model do
  it "returns score BAD because no data provided" do
    stats = Api::V1::Stats.new
    expect(stats.filter_fundamental_roe('[]')).to eq(Api::V1::Stats::BAD)
  end

  it "returns score BAD because value is null" do
    stats = Api::V1::Stats.new
    expect(stats.filter_fundamental_roe('[{"date":"2007-10-31","value":null}]')).to eq(Api::V1::Stats::BAD)
  end

  it "returns score EXCELLENT because latest roe is greater than 30%" do
    stats = Api::V1::Stats.new
    expect(stats.filter_fundamental_roe('[{"date":"2016-10-31","value":0.409791},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.103653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(Api::V1::Stats::EXCELLENT)
  end

  it "returns score EXCELLENT because latest roe is equal t0 30%" do
    stats = Api::V1::Stats.new
    expect(stats.filter_fundamental_roe('[{"date":"2016-10-31","value":0.300000},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.103653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(Api::V1::Stats::EXCELLENT)
  end

  it "returns score VERY_GOOD because latest roe is less than 30% but more than 20%" do
    stats = Api::V1::Stats.new
    expect(stats.filter_fundamental_roe('[{"date":"2016-10-31","value":0.210000},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.103653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(Api::V1::Stats::VERY_GOOD)
  end

  it "returns score GOOD because latest roe is less than 20% but more than 15%" do
    stats = Api::V1::Stats.new
    expect(stats.filter_fundamental_roe('[{"date":"2016-10-31","value":0.157000},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.103653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(Api::V1::Stats::GOOD)
  end

  it "returns score MARGINAL because latest roe is less than 15% but more than 12%" do
    stats = Api::V1::Stats.new
    expect(stats.filter_fundamental_roe('[{"date":"2016-10-31","value":0.147000},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.103653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(Api::V1::Stats::MARGINAL)
  end

  it "returns score BAD because latest roe is less than 12%" do
    stats = Api::V1::Stats.new
    expect(stats.filter_fundamental_roe('[{"date":"2016-10-31","value":0.107000},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.103653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(Api::V1::Stats::BAD)
  end
end
