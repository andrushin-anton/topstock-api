# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180216231554) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_v1_companies", force: :cascade do |t|
    t.string "name"
    t.string "ticker"
    t.string "sector"
    t.string "industry"
    t.string "country"
    t.string "status"
    t.string "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "exchange"
    t.string "price"
    t.string "max_price"
    t.index ["ticker"], name: "index_api_v1_companies_on_ticker", unique: true
  end

  create_table "api_v1_company_logs", force: :cascade do |t|
    t.string "ticker"
    t.string "fundament"
    t.string "moat"
    t.string "max_price"
    t.string "close_price"
    t.string "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_v1_industries", force: :cascade do |t|
    t.string "name"
    t.string "profitmargin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "api_v1_stats", force: :cascade do |t|
    t.string "ticker"
    t.string "roe"
    t.string "netincome"
    t.string "freecashflow"
    t.string "profitmargin"
    t.string "longtermdebt"
    t.string "grossmargin"
    t.string "roa"
    t.string "depreciationexpense"
    t.string "totalgrossprofit"
    t.string "close_price"
    t.string "pricetoearnings"
    t.string "bookvaluepershare"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ticker"], name: "index_api_v1_stats_on_ticker", unique: true
  end

  create_table "companies", force: :cascade do |t|
    t.string "ticker"
    t.string "name"
    t.string "sector"
    t.string "industry"
    t.string "status"
    t.string "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
