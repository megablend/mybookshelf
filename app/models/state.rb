class State < ActiveRecord::Base
	has_many :merchants, inverse_of: :state
end
