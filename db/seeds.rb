# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create default processors
Api::V1::Processor.create(processor_type: 'STATS', status: 'ACTIVE', run_time: DateTime.now, processor_data: '', last_error: '')
Api::V1::Processor.create(processor_type: 'RANK', status: 'ACTIVE', run_time: DateTime.now, processor_data: '', last_error: '')
Api::V1::Processor.create(processor_type: 'IMPORT', status: 'ACTIVE', run_time: DateTime.now, processor_data: '', last_error: '')

# Create default avg profit-margin per industry
Api::V1::Industry.create(name: 'Construction/Ag Equipment/Trucks', profitmargin: '1.44')
Api::V1::Industry.create(name: 'Beverages (Production/Distribution)', profitmargin: '11.05')
Api::V1::Industry.create(name: 'Auto Parts:O.E.M.', profitmargin: '6.7')
Api::V1::Industry.create(name: 'Coal Mining', profitmargin: '8.1')
Api::V1::Industry.create(name: 'Shoe Manufacturing', profitmargin: '11.13')
Api::V1::Industry.create(name: 'Industrial Specialties', profitmargin: '3.75')
Api::V1::Industry.create(name: 'Other Transportation', profitmargin: '4.74')
Api::V1::Industry.create(name: 'Aerospace', profitmargin: '1.25')
Api::V1::Industry.create(name: 'Commercial Banks', profitmargin: '23.1')
Api::V1::Industry.create(name: 'Consumer Electronics/Video Chains', profitmargin: '22.42')
Api::V1::Industry.create(name: 'Forest Products', profitmargin: '5.08')
Api::V1::Industry.create(name: 'Natural Gas Distribution', profitmargin: '72.16')
Api::V1::Industry.create(name: 'Movies/Entertainment', profitmargin: '11.86')
Api::V1::Industry.create(name: 'Paints/Coatings', profitmargin: '0')
Api::V1::Industry.create(name: 'Consumer Electronics/Appliances', profitmargin: '22.42')
Api::V1::Industry.create(name: 'Consumer: Greeting Cards', profitmargin: '0')
Api::V1::Industry.create(name: 'Agricultural Chemicals', profitmargin: '13.94')
Api::V1::Industry.create(name: 'Specialty Chemicals', profitmargin: '1.97')
Api::V1::Industry.create(name: 'Biotechnology: Laboratory Analytical Instruments', profitmargin: '17.11')
Api::V1::Industry.create(name: 'Home Furnishings', profitmargin: '7.35')
Api::V1::Industry.create(name: 'Medical/Dental Instruments', profitmargin: '9.6')
Api::V1::Industry.create(name: 'Transportation Services', profitmargin: '4.8')
Api::V1::Industry.create(name: 'Electronics Distribution', profitmargin: '16.47')
Api::V1::Industry.create(name: 'Industrial Machinery/Components', profitmargin: '4.24')
Api::V1::Industry.create(name: 'Specialty Insurers', profitmargin: '10.14')
Api::V1::Industry.create(name: 'Computer peripheral equipment', profitmargin: '4.09')
Api::V1::Industry.create(name: 'Ophthalmic Goods', profitmargin: '0')
Api::V1::Industry.create(name: 'Paper', profitmargin: '3.91')
Api::V1::Industry.create(name: 'Fluid Controls', profitmargin: '0')
Api::V1::Industry.create(name: 'Mining & Quarrying of Nonmetallic Minerals (No Fuels)', profitmargin: '6.31')
Api::V1::Industry.create(name: 'Publishing', profitmargin: '1.07')
Api::V1::Industry.create(name: 'Business Services', profitmargin: '10.98')
Api::V1::Industry.create(name: 'Biotechnology: Commercial Physical & Biological Resarch', profitmargin: '17.11')
Api::V1::Industry.create(name: 'Engineering & Construction', profitmargin: '1.95')
Api::V1::Industry.create(name: 'Clothing/Shoe/Accessory Stores', profitmargin: '11.13')
Api::V1::Industry.create(name: 'Precious Metals', profitmargin: '3.38')
Api::V1::Industry.create(name: 'Finance Companies', profitmargin: '15.64')
Api::V1::Industry.create(name: 'Specialty Foods', profitmargin: '10.08')
Api::V1::Industry.create(name: 'Computer Manufacturing', profitmargin: '16.47')
Api::V1::Industry.create(name: 'Computer Software: Programming, Data Processing', profitmargin: '25.48')
Api::V1::Industry.create(name: 'Major Banks', profitmargin: '24.23')
Api::V1::Industry.create(name: 'Packaged Foods', profitmargin: '10.08')
Api::V1::Industry.create(name: 'Oil Refining/Marketing', profitmargin: '0')
Api::V1::Industry.create(name: 'Savings Institutions', profitmargin: '24.9')
Api::V1::Industry.create(name: 'Aluminum', profitmargin: '2.58')
Api::V1::Industry.create(name: 'Steel/Iron Ore', profitmargin: '3.38')
Api::V1::Industry.create(name: 'Homebuilding', profitmargin: '1.95')
Api::V1::Industry.create(name: 'Services-Misc. Amusement & Recreation', profitmargin: '4.43')
Api::V1::Industry.create(name: 'Plastic Products', profitmargin: '1.97')
Api::V1::Industry.create(name: 'Auto Manufacturing', profitmargin: '1.44')
Api::V1::Industry.create(name: 'Other Pharmaceuticals', profitmargin: '1.99')
Api::V1::Industry.create(name: 'Building Products', profitmargin: '1.95')
Api::V1::Industry.create(name: 'Building operators', profitmargin: '1.95')
Api::V1::Industry.create(name: 'Integrated oil Companies', profitmargin: '2.57')
Api::V1::Industry.create(name: 'Rental/Leasing Companies', profitmargin: '4.55')
Api::V1::Industry.create(name: 'Broadcasting', profitmargin: '20.72')
Api::V1::Industry.create(name: 'Major Chemicals', profitmargin: '13.94')
Api::V1::Industry.create(name: 'Air Freight/Delivery Services', profitmargin: '4.74')
Api::V1::Industry.create(name: 'Diversified Financial Services', profitmargin: '14.98')
Api::V1::Industry.create(name: 'Electronic Components', profitmargin: '0.88')
Api::V1::Industry.create(name: 'Water Supply', profitmargin: '15.94')
Api::V1::Industry.create(name: 'Diversified Electronic Products', profitmargin: '5.83')
Api::V1::Industry.create(name: 'Books', profitmargin: '3.91')
Api::V1::Industry.create(name: 'Oil/Gas Transmission', profitmargin: '2.57')
Api::V1::Industry.create(name: 'Oil & Gas Production', profitmargin: '2.57')
Api::V1::Industry.create(name: 'Office Equipment/Supplies/Services', profitmargin: '4.41')
Api::V1::Industry.create(name: 'Pollution Control Equipment', profitmargin: '0')
Api::V1::Industry.create(name: 'Military/Government/Technical', profitmargin: '1.25')
Api::V1::Industry.create(name: 'Computer Software: Prepackaged Software', profitmargin: '25.48')
Api::V1::Industry.create(name: 'Retail: Computer Software & Peripheral Equipment', profitmargin: '2.26')
Api::V1::Industry.create(name: 'General Bldg Contractors - Nonresidential Bldgs', profitmargin: '1.95')
Api::V1::Industry.create(name: 'Wholesale Distributors', profitmargin: '2.12')
Api::V1::Industry.create(name: 'Precision Instruments', profitmargin: '0')
Api::V1::Industry.create(name: 'Restaurants', profitmargin: '6.84')
Api::V1::Industry.create(name: 'RETAIL: Building Materials', profitmargin: '5.49')
Api::V1::Industry.create(name: 'Ordnance And Accessories', profitmargin: '11.13')
Api::V1::Industry.create(name: 'Banks', profitmargin: '15.64')
Api::V1::Industry.create(name: 'Tobacco', profitmargin: '21.63')
Api::V1::Industry.create(name: 'Textiles', profitmargin: '11.13')
Api::V1::Industry.create(name: 'Property-Casualty Insurers', profitmargin: '5.29')
Api::V1::Industry.create(name: 'Investment Managers', profitmargin: '24.9')
Api::V1::Industry.create(name: 'Miscellaneous manufacturing industries', profitmargin: '4.42')
Api::V1::Industry.create(name: 'Newspapers/Magazines', profitmargin: '1.07')
Api::V1::Industry.create(name: 'Motor Vehicles', profitmargin: '1.44')
Api::V1::Industry.create(name: 'Other Specialty Stores', profitmargin: '3.75')
Api::V1::Industry.create(name: 'Medical Specialities', profitmargin: '2.46')
Api::V1::Industry.create(name: 'Medical/Nursing Services', profitmargin: '0')
Api::V1::Industry.create(name: 'Real Estate Investment Trusts', profitmargin: '2.83')
Api::V1::Industry.create(name: 'Biotechnology: In Vitro & In Vivo Diagnostic Substances', profitmargin: '17.11')
Api::V1::Industry.create(name: 'Tools/Hardware', profitmargin: '16.47')
Api::V1::Industry.create(name: 'Electric Utilities: Central', profitmargin: '5.83')
Api::V1::Industry.create(name: 'Finance: Consumer Services', profitmargin: '15.64')
Api::V1::Industry.create(name: 'Telecommunications Equipment', profitmargin: '4.79')
Api::V1::Industry.create(name: 'Accident &Health Insurance', profitmargin: '4.53')
Api::V1::Industry.create(name: 'Automotive Aftermarket', profitmargin: '7.04')
Api::V1::Industry.create(name: 'Recreational Products/Toys', profitmargin: '4.43')
Api::V1::Industry.create(name: 'Environmental Services', profitmargin: '8.37')
Api::V1::Industry.create(name: 'Meat/Poultry/Fish', profitmargin: '10.08')
Api::V1::Industry.create(name: 'Other Consumer Services', profitmargin: '0')
Api::V1::Industry.create(name: 'EDP Services', profitmargin: '0')
Api::V1::Industry.create(name: 'Medical Electronics', profitmargin: '9.6')
Api::V1::Industry.create(name: 'Television Services', profitmargin: '20.72')
Api::V1::Industry.create(name: 'Investment Bankers/Brokers/Service', profitmargin: '24.9')
Api::V1::Industry.create(name: 'Package Goods/Cosmetics', profitmargin: '1.3')
Api::V1::Industry.create(name: 'Life Insurance', profitmargin: '4.76')
Api::V1::Industry.create(name: 'Biotechnology: Electromedical & Electrotherapeutic Apparatus', profitmargin: '17.11')
Api::V1::Industry.create(name: 'Oilfield Services/Equipment', profitmargin: '0')
Api::V1::Industry.create(name: 'Marine Transportation', profitmargin: '8.6')
Api::V1::Industry.create(name: 'Semiconductors', profitmargin: '32.62')
Api::V1::Industry.create(name: 'Apparel', profitmargin: '0')
Api::V1::Industry.create(name: 'Hospital/Nursing Management', profitmargin: '0')
Api::V1::Industry.create(name: 'Multi-Sector Companies', profitmargin: '0')
Api::V1::Industry.create(name: 'Department/Specialty Retail Stores', profitmargin: '3.75')
Api::V1::Industry.create(name: 'Finance/Investors Services', profitmargin: '24.9')
Api::V1::Industry.create(name: 'Professional Services', profitmargin: '4.7')
Api::V1::Industry.create(name: 'Advertising', profitmargin: '5.95')
Api::V1::Industry.create(name: 'Food Chains', profitmargin: '6.84')
Api::V1::Industry.create(name: 'Computer Communications Equipment', profitmargin: '4.79')
Api::V1::Industry.create(name: 'Power Generation', profitmargin: '5.83')
Api::V1::Industry.create(name: 'Metal Fabrications', profitmargin: '3.38')
Api::V1::Industry.create(name: 'Hotels/Resorts', profitmargin: '10.43')
Api::V1::Industry.create(name: 'Food Distributors', profitmargin: '0')
Api::V1::Industry.create(name: 'Railroads', profitmargin: '6.7')
Api::V1::Industry.create(name: 'Major Pharmaceuticals', profitmargin: '0')
Api::V1::Industry.create(name: 'Catalog/Specialty Distribution', profitmargin: '3.12')
Api::V1::Industry.create(name: 'Real Estate', profitmargin: '2.83')
Api::V1::Industry.create(name: 'Consumer Specialties', profitmargin: '0')
Api::V1::Industry.create(name: 'Radio And Television Broadcasting And Communications Equipment', profitmargin: '4.79')
Api::V1::Industry.create(name: 'Building Materials', profitmargin: '6.24')
Api::V1::Industry.create(name: 'Trucking Freight/Courier Services', profitmargin: '4.74')
Api::V1::Industry.create(name: 'Biotechnology: Biological Products (No Diagnostic Substances)', profitmargin: '17.11')
Api::V1::Industry.create(name: 'Farming/Seeds/Milling', profitmargin: '0.11')
Api::V1::Industry.create(name: 'Containers/Packaging', profitmargin: '1.3')
Api::V1::Industry.create(name: 'Electrical Products', profitmargin: '5.83')
Api::V1::Industry.create(name: 'Diversified Commercial Services', profitmargin: '0')
Api::V1::Industry.create(name: 'Miscellaneous', profitmargin: '4.42')