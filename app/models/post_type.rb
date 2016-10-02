class PostType < ApplicationRecord
  validates_presence_of :name
  has_many :posts
end
