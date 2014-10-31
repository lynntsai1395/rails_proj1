class Pokemon < ActiveRecord::Base
	validates :name, uniqueness: true, presence: true
	belongs_to :trainer
end
