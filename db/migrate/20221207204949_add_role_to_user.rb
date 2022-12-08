# frozen_string_literal: true

# This migration adds a role to the user table
class AddRoleToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :role, :integer, default: 0
  end
end
