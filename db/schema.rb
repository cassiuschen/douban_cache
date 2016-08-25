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

ActiveRecord::Schema.define(version: 20160825142210) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "comments", force: :cascade do |t|
    t.integer  "rank",       default: 0
    t.integer  "valueable",  default: 0
    t.text     "content",                null: false
    t.integer  "movie_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["movie_id"], name: "index_comments_on_movie_id", using: :btree
  end

  create_table "movies", force: :cascade do |t|
    t.string   "title"
    t.hstore   "info",         default: {}
    t.float    "rank"
    t.string   "douban_id",                 null: false
    t.integer  "status",       default: 0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "genre",                                  array: true
    t.string   "starring",                               array: true
    t.string   "director",                               array: true
    t.date     "release_date"
    t.integer  "runtime"
    t.integer  "sum_of_rank"
    t.index ["director"], name: "index_movies_on_director", using: :gin
    t.index ["douban_id"], name: "index_movies_on_douban_id", unique: true, using: :btree
    t.index ["genre"], name: "index_movies_on_genre", using: :gin
    t.index ["starring"], name: "index_movies_on_starring", using: :gin
  end

  add_foreign_key "comments", "movies"
end