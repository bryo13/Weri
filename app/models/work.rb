class Work < ApplicationRecord

    WillPaginate.per_page = 7

    def self.search(search)
    	where("name LIKE ?", "%#{search}%")
  	end

    
    belongs_to :user
    belongs_to :category
    has_many   :feedbacks, dependent: :destroy
    has_many   :comments, dependent: :destroy
    has_many_attached :attaches
    validates :name, presence: true
    
end
