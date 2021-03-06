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

ActiveRecord::Schema.define(version: 20180509155256) do

  create_table "comments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "contributions_id"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "contribution_id"
    t.integer "parent_id"
    t.index ["contribution_id"], name: "index_comments_on_contribution_id"
    t.index ["contributions_id"], name: "index_comments_on_contributions_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "contributions", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "numComments"
    t.integer "user_id"
    t.integer "points"
    t.float "hot_score"
    t.index ["user_id"], name: "index_contributions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "about"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "secret"
    t.string "api_key", default: ""
  end

  create_table "votecomments", force: :cascade do |t|
    t.integer "user_id"
    t.integer "comment_id"
    t.integer "upvotecom", default: 0
    t.integer "downvotecom", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_votecomments_on_comment_id"
    t.index ["user_id"], name: "index_votecomments_on_user_id"
  end

  create_table "votes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "contribution_id"
    t.integer "upvote", default: 0
    t.integer "downvote", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contribution_id"], name: "index_votes_on_contribution_id"
    t.index ["user_id"], name: "index_votes_on_user_id"
  end

end
