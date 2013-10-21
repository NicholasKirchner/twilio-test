class Message < ActiveRecord::Base

  has_many :recipients

  validates :contents, length: { maximum: 140 }, presence: true

end
