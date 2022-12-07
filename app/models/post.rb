# frozen_string_literal: true

# This is the top level comment for post model
class Post < ApplicationRecord
  belongs_to :user

  has_many :comments
end
