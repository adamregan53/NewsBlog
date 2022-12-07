# frozen_string_literal: true

# this is uses to remove commenter field from Comments table
class RemoveCommenterFromComments < ActiveRecord::Migration[7.0]
  def change
    remove_column :comments, :commenter, :text
  end
end
