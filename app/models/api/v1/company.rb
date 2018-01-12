class Api::V1::Company < ApplicationRecord

  def self.create_company_if_not_exists_from_csv_line(csv_line, exchange_name)
    # ignore if sector is n/a or empty - because it is not a company
    unless csv_line[6].downcase == 'n/a' || csv_line[6] == ''
      begin
        Api::V1::Company.create!(
            :ticker => csv_line[0],
            :name => csv_line[1],
            :exchange => exchange_name,
            :sector => csv_line[6],
            :industry => csv_line[7],
            :status => 'NEW',
            :rank => '0'
        )
        puts csv_line[0] + ' created!'
      rescue ActiveRecord::RecordNotUnique
        # The company already exists.
      end
    end
  end

end
