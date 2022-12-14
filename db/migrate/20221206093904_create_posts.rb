# frozen_string_literal: true

# This migration creates a Post table
class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :article
      t.text :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
