class Api::V1::CompanySerializer < ActiveModel::Serializer
  attributes :id, :ticker, :name, :sector, :industry, :exchange, :rank
end
