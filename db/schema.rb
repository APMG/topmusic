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

ActiveRecord::Schema.define(version: 20170330213925) do

  create_table "ballots", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string "user_id", null: false
    t.integer "poll_id", null: false
    t.string "public_uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_name"
    t.index ["poll_id"], name: "index_ballots_on_poll_id"
    t.index ["public_uid"], name: "index_ballots_on_public_uid", unique: true
    t.index ["user_id", "poll_id"], name: "index_ballots_on_user_id_and_poll_id", unique: true
  end

  create_table "polls", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string "slug"
    t.string "name"
    t.string "selectable"
    t.datetime "open_date"
    t.datetime "close_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "long_title"
    t.text "description"
    t.text "twitter_text"
    t.index ["slug"], name: "index_polls_on_slug", unique: true
  end

  create_table "selections", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.integer "ballot_id"
    t.integer "song_id"
    t.string "freeform"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ballot_id"], name: "index_selections_on_ballot_id"
    t.index ["song_id"], name: "index_selections_on_song_id"
  end

  create_table "songs", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin" do |t|
    t.string "name"
    t.string "name_sort_by"
    t.string "artist"
    t.string "artist_sort_by"
    t.string "album"
    t.string "album_sort_by"
    t.integer "poll_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "album_mbid"
    t.string "album_mb_title"
    t.integer "album_mb_confidence"
    t.boolean "album_mb_lookup", default: false
    t.boolean "has_art"
    t.index ["poll_id"], name: "index_songs_on_poll_id"
  end

  add_foreign_key "ballots", "polls"
  add_foreign_key "selections", "ballots"
  add_foreign_key "selections", "songs"
  add_foreign_key "songs", "polls"
end
