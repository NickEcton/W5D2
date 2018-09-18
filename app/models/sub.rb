class Sub < ApplicationRecord
  validates :title, presence: true
  validates :description, presence: true
  validates :moderator_id, presence: true

  belongs_to :moderator,
  foreign_key: :moderator_id,
  class_name: :User

  has_many :posts,
  foreign_key: :sub_id,
  class_name: :Post

  has_many :post_subs,
  foreign_key: :sub_id,
  class_name: :PostSub

end
