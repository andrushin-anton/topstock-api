require 'rails_helper'
require_relative '../../../../app/services/api/v1/fundamental_service'

RSpec.describe Api::V1::FundamentalService, type: :service do
  #ROE
  it "returns score BAD because no data provided" do
    expect(Api::V1::FundamentalService.filter_fundamental_roe('[]')).to eq(Api::V1::FundamentalService::BAD)
  end

  it "returns score BAD because value is null" do
    expect(Api::V1::FundamentalService.filter_fundamental_roe('[{"date":"2007-10-31","value":null}]')).to eq(Api::V1::FundamentalService::BAD)
  end

  it "returns score BAD because value is negative" do
    expect(Api::V1::FundamentalService.filter_fundamental_roe('[{"date":"2007-10-31","value":-0.036023}]')).to eq(Api::V1::FundamentalService::BAD)
  end

  it "returns score EXCELLENT because latest roe is greater than 30%" do
    expect(Api::V1::FundamentalService.filter_fundamental_roe('[{"date":"2016-10-31","value":0.409791},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.103653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(Api::V1::FundamentalService::EXCELLENT)
  end

  it "returns score EXCELLENT because latest roe is equal t0 30%" do
    expect(Api::V1::FundamentalService.filter_fundamental_roe('[{"date":"2016-10-31","value":0.300000},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.103653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(Api::V1::FundamentalService::EXCELLENT)
  end

  it "returns score VERY_GOOD because latest roe is less than 30% but more than 20%" do
    expect(Api::V1::FundamentalService.filter_fundamental_roe('[{"date":"2016-10-31","value":0.210000},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.103653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(Api::V1::FundamentalService::VERY_GOOD)
  end

  it "returns score GOOD because latest roe is less than 20% but more than 15%" do
    expect(Api::V1::FundamentalService.filter_fundamental_roe('[{"date":"2016-10-31","value":0.157000},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.103653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(Api::V1::FundamentalService::GOOD)
  end

  it "returns score MARGINAL because latest roe is less than 15% but more than 12%" do
    expect(Api::V1::FundamentalService.filter_fundamental_roe('[{"date":"2016-10-31","value":0.147000},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.103653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(Api::V1::FundamentalService::MARGINAL)
  end

  it "returns score BAD because latest roe is less than 12%" do
    expect(Api::V1::FundamentalService.filter_fundamental_roe('[{"date":"2016-10-31","value":0.107000},{"date":"2015-10-31","value":0.084653},{"date":"2014-10-31","value":0.103653},{"date":"2013-10-31","value":0.140157},{"date":"2012-10-31","value":0.242711},{"date":"2011-10-31","value":0.268008},{"date":"2010-10-31","value":0.237913},{"date":"2009-10-31","value":-0.012222},{"date":"2008-10-31","value":0.270809},{"date":"2007-10-31","value":null}]')).to eq(Api::V1::FundamentalService::BAD)
  end

  # NET INCOME
  it "returns score BAD because no data provided netincome" do
    expect(Api::V1::FundamentalService.filter_fundamental_net_income('')).to eq(Api::V1::FundamentalService::BAD)
  end

  it "returns score EXCELLENT because netincome has grown all last 3 years" do
    expect(Api::V1::FundamentalService.filter_fundamental_net_income('[{"date":"2016-10-31","value":462000000.0},{"date":"2015-10-31","value":401000000.0},{"date":"2014-10-31","value":349000000.0},{"date":"2013-10-31","value":734000000.0},{"date":"2012-10-31","value":1153000000.0},{"date":"2011-10-31","value":1012000000.0},{"date":"2010-10-31","value":684000000.0},{"date":"2009-10-31","value":-31000000.0},{"date":"2008-10-31","value":693000000.0},{"date":"2007-10-31","value":638000000.0}]')).to eq(Api::V1::FundamentalService::EXCELLENT)
  end

  it "returns score VERY_GOOD because netincome has grown only last 2 years" do
    expect(Api::V1::FundamentalService.filter_fundamental_net_income('[{"date":"2016-10-31","value":462000000.0},{"date":"2015-10-31","value":401000000.0},{"date":"2014-10-31","value":549000000.0},{"date":"2013-10-31","value":734000000.0},{"date":"2012-10-31","value":1153000000.0},{"date":"2011-10-31","value":1012000000.0},{"date":"2010-10-31","value":684000000.0},{"date":"2009-10-31","value":-31000000.0},{"date":"2008-10-31","value":693000000.0},{"date":"2007-10-31","value":638000000.0}]')).to eq(Api::V1::FundamentalService::VERY_GOOD)
  end

  it "returns score MARGINAL because netincome hasn't grown in the last 3 years" do
    expect(Api::V1::FundamentalService.filter_fundamental_net_income('[{"date":"2016-10-31","value":362000000.0},{"date":"2015-10-31","value":401000000.0},{"date":"2014-10-31","value":549000000.0},{"date":"2013-10-31","value":734000000.0},{"date":"2012-10-31","value":1153000000.0},{"date":"2011-10-31","value":1012000000.0},{"date":"2010-10-31","value":684000000.0},{"date":"2009-10-31","value":-31000000.0},{"date":"2008-10-31","value":693000000.0},{"date":"2007-10-31","value":638000000.0}]')).to eq(Api::V1::FundamentalService::MARGINAL)
  end

  it "returns score MARGINAL because netincome hasn only 1 year" do
    expect(Api::V1::FundamentalService.filter_fundamental_net_income('[{"date":"2016-10-31","value":362000000.0}]')).to eq(Api::V1::FundamentalService::MARGINAL)
  end

  # CASH FLOW
  it "returns score BAD because no data provided cash flow" do
    expect(Api::V1::FundamentalService.filter_fundamental_cash_flow('')).to eq(Api::V1::FundamentalService::BAD)
  end

  it "returns score EXCELLENT because cash flow has grown all last 3 years" do
    expect(Api::V1::FundamentalService.filter_fundamental_cash_flow('[{"date":"2016-10-31","value":462000000.0},{"date":"2015-10-31","value":401000000.0},{"date":"2014-10-31","value":349000000.0},{"date":"2013-10-31","value":734000000.0},{"date":"2012-10-31","value":1153000000.0},{"date":"2011-10-31","value":1012000000.0},{"date":"2010-10-31","value":684000000.0},{"date":"2009-10-31","value":-31000000.0},{"date":"2008-10-31","value":693000000.0},{"date":"2007-10-31","value":638000000.0}]')).to eq(Api::V1::FundamentalService::EXCELLENT)
  end

  it "returns score VERY_GOOD because cash flow has grown only last 2 years" do
    expect(Api::V1::FundamentalService.filter_fundamental_cash_flow('[{"date":"2016-10-31","value":462000000.0},{"date":"2015-10-31","value":401000000.0},{"date":"2014-10-31","value":549000000.0},{"date":"2013-10-31","value":734000000.0},{"date":"2012-10-31","value":1153000000.0},{"date":"2011-10-31","value":1012000000.0},{"date":"2010-10-31","value":684000000.0},{"date":"2009-10-31","value":-31000000.0},{"date":"2008-10-31","value":693000000.0},{"date":"2007-10-31","value":638000000.0}]')).to eq(Api::V1::FundamentalService::VERY_GOOD)
  end

  it "returns score MARGINAL because cash flow hasn't grown in the last 3 years" do
    expect(Api::V1::FundamentalService.filter_fundamental_cash_flow('[{"date":"2016-10-31","value":362000000.0},{"date":"2015-10-31","value":401000000.0},{"date":"2014-10-31","value":549000000.0},{"date":"2013-10-31","value":734000000.0},{"date":"2012-10-31","value":1153000000.0},{"date":"2011-10-31","value":1012000000.0},{"date":"2010-10-31","value":684000000.0},{"date":"2009-10-31","value":-31000000.0},{"date":"2008-10-31","value":693000000.0},{"date":"2007-10-31","value":638000000.0}]')).to eq(Api::V1::FundamentalService::MARGINAL)
  end

  it "returns score MARGINAL because cash flow hasn only 1 year" do
    expect(Api::V1::FundamentalService.filter_fundamental_cash_flow('[{"date":"2016-10-31","value":362000000.0}]')).to eq(Api::V1::FundamentalService::MARGINAL)
  end

  # Profit Margin Industry
  it "returns score BAD because no data provided profit margin" do
    expect(Api::V1::FundamentalService.filter_fundamental_avg_profit_margin('', 4)).to eq(Api::V1::FundamentalService::BAD)
  end

  it "returns score EXCELLENT because current profit margin is greater then industry AVG" do
    expect(Api::V1::FundamentalService.filter_fundamental_avg_profit_margin('[{"date":"2016-10-31","value":0.109948},{"date":"2015-10-31","value":0.099307}]', 4)).to eq(Api::V1::FundamentalService::EXCELLENT)
  end

  it "returns score GOOD because current profit margin is equal to industry AVG" do
    expect(Api::V1::FundamentalService.filter_fundamental_avg_profit_margin('[{"date":"2016-10-31","value":0.0400},{"date":"2015-10-31","value":0.099307}]', 4)).to eq(Api::V1::FundamentalService::GOOD)
  end

  it "returns score BAD because current profit margin is less than industry's AVG" do
    expect(Api::V1::FundamentalService.filter_fundamental_avg_profit_margin('[{"date":"2016-10-31","value":0.0300},{"date":"2015-10-31","value":0.099307}]', 4)).to eq(Api::V1::FundamentalService::BAD)
  end

  # Profit Margin Company
  it "returns score BAD because no data provided company profit margin" do
    expect(Api::V1::FundamentalService.filter_profit_margin('')).to eq(Api::V1::FundamentalService::BAD)
  end

  it "returns score EXCELLENT because current profit margin is greater then company AVG" do
    expect(Api::V1::FundamentalService.filter_profit_margin('[{"date":"2016-10-31","value":0.109948},{"date":"2015-10-31","value":0.099307},{"date":"2014-10-31","value":0.089307},{"date":"2013-10-31","value":0.079307}]')).to eq(Api::V1::FundamentalService::EXCELLENT)
  end

  it "returns score GOOD because current profit margin is equal to industry AVG" do
    expect(Api::V1::FundamentalService.filter_profit_margin('[{"date":"2016-10-31","value":0.0400},{"date":"2015-10-31","value":0.0400}]')).to eq(Api::V1::FundamentalService::GOOD)
  end

  it "returns score BAD because current profit margin is less than industry's AVG" do
    expect(Api::V1::FundamentalService.filter_profit_margin('[{"date":"2016-10-31","value":0.0300},{"date":"2015-10-31","value":0.2307}]')).to eq(Api::V1::FundamentalService::BAD)
  end

  # Long-term Debt / Net Income
  it "returns score BAD because no debt data provided filter_long_debt_to_net_income" do
    expect(Api::V1::FundamentalService.filter_long_debt_to_net_income('', '[{"date":"2017-10-31", "value":"454545"}]')).to eq(Api::V1::FundamentalService::BAD)
  end

  it "returns score BAD because no income data provided filter_long_debt_to_net_income" do
    expect(Api::V1::FundamentalService.filter_long_debt_to_net_income('[{"date":"2017-10-31", "value":"454545"}]', '')).to eq(Api::V1::FundamentalService::BAD)
  end

  it "returns score EXCELLENT because the score is less than 5 filter_long_debt_to_net_income" do
    expect(Api::V1::FundamentalService.filter_long_debt_to_net_income('[{"date":"2017-10-31", "value":"1904000000.0"}]', '[{"date":"2017-10-31", "value":"462000000.0"}]')).to eq(Api::V1::FundamentalService::EXCELLENT)
  end

  it "returns score GOOD because the score is >= 5 and < 16 filter_long_debt_to_net_income" do
    expect(Api::V1::FundamentalService.filter_long_debt_to_net_income('[{"date":"2017-10-31", "value":"50"}]', '[{"date":"2017-10-31", "value":"8"}]')).to eq(Api::V1::FundamentalService::GOOD)
  end

  it "returns score BAD because the score is > 16 filter_long_debt_to_net_income" do
    expect(Api::V1::FundamentalService.filter_long_debt_to_net_income('[{"date":"2017-10-31", "value":"50"}]', '[{"date":"2017-10-31", "value":"3"}]')).to eq(Api::V1::FundamentalService::BAD)
  end

  # Gross Profit Margin
  it "returns score BAD because no data provided filter_gross_profit_margin" do
    expect(Api::V1::FundamentalService.filter_gross_profit_margin('')).to eq(Api::V1::FundamentalService::BAD)
  end

  it "returns score EXCELLENT because gross_profit_margin >= 40 filter_gross_profit_margin" do
    expect(Api::V1::FundamentalService.filter_gross_profit_margin('[{"date":"2017-10-31", "value":"0.522846"}]')).to eq(Api::V1::FundamentalService::EXCELLENT)
  end

  it "returns score GOOD because gross_profit_margin >= 20 and < 40 filter_gross_profit_margin" do
    expect(Api::V1::FundamentalService.filter_gross_profit_margin('[{"date":"2017-10-31", "value":"0.322846"}]')).to eq(Api::V1::FundamentalService::GOOD)
  end

  it "returns score BAD otherwise filter_gross_profit_margin" do
    expect(Api::V1::FundamentalService.filter_gross_profit_margin('[{"date":"2017-10-31", "value":"0.122846"}]')).to eq(Api::V1::FundamentalService::BAD)
  end

end