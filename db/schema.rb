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

ActiveRecord::Schema.define(version: 2020_06_06_011041) do

  create_table "areas", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "prefecture", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content", limit: 255, null: false
    t.bigint "user_id"
    t.bigint "image_post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_comments_on_created_at"
    t.index ["image_post_id"], name: "index_comments_on_image_post_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "image_post_likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "image_post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["image_post_id"], name: "index_image_post_likes_on_image_post_id"
    t.index ["user_id", "image_post_id"], name: "index_image_post_likes_on_user_id_and_image_post_id", unique: true
    t.index ["user_id"], name: "index_image_post_likes_on_user_id"
  end

  create_table "image_posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "picture", null: false
    t.text "content", limit: 255
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "created_at"], name: "index_image_posts_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_image_posts_on_user_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "content", limit: 255, null: false
    t.bigint "user_id"
    t.bigint "talk_room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["talk_room_id"], name: "index_messages_on_talk_room_id"
    t.index ["user_id", "created_at"], name: "index_messages_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "partipications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.boolean "permission"
    t.bigint "user_id"
    t.bigint "recruitment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recruitment_id"], name: "index_partipications_on_recruitment_id"
    t.index ["user_id"], name: "index_partipications_on_user_id"
  end

  create_table "recruitment_likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "recruitment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recruitment_id"], name: "index_recruitment_likes_on_recruitment_id"
    t.index ["user_id", "recruitment_id"], name: "index_recruitment_likes_on_user_id_and_recruitment_id", unique: true
    t.index ["user_id"], name: "index_recruitment_likes_on_user_id"
  end

  create_table "recruitments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "title", limit: 50, null: false
    t.text "content", limit: 255, null: false
    t.date "date"
    t.string "picture"
    t.bigint "user_id"
    t.bigint "area_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area_id"], name: "index_recruitments_on_area_id"
    t.index ["user_id", "created_at"], name: "index_recruitments_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_recruitments_on_user_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "follower_id", null: false
    t.string "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "talk_rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.bigint "recruitment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recruitment_id"], name: "index_talk_rooms_on_recruitment_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "provider"
    t.string "uid"
    t.string "name", default: "", null: false
    t.text "introduction", limit: 255
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "image_posts"
  add_foreign_key "comments", "users"
  add_foreign_key "image_post_likes", "image_posts"
  add_foreign_key "image_post_likes", "users"
  add_foreign_key "image_posts", "users"
  add_foreign_key "messages", "talk_rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "partipications", "recruitments"
  add_foreign_key "partipications", "users"
  add_foreign_key "recruitment_likes", "recruitments"
  add_foreign_key "recruitment_likes", "users"
  add_foreign_key "recruitments", "areas"
  add_foreign_key "recruitments", "users"
  add_foreign_key "talk_rooms", "recruitments"
end
