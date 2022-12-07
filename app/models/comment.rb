# frozen_string_literal: true

# This is the top level comment for comment model
class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
end
