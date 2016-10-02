class Post < ApplicationRecord
  belongs_to :post_type
  validates_presence_of :title, :body
end
