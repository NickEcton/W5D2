class PostSub < ApplicationRecord
  validates :sub_id, presence: true
  validates :post_id, presence: true

  belongs_to :sub,
  foreign_key: :sub_id,
  class_name: :Sub

  belongs_to :post,
  foreign_key: :post_id,
  class_name: :Post
end
