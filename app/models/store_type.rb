class StoreType < ActiveRecord::Base
   has_many :stores, inverse_of: :store_type
end