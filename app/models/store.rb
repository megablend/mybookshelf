class Store < ActiveRecord::Base
    belongs_to :merchant, inverse_of: :store
    belongs_to :store_type, inverse_of: :stores

    # validate form data
    validates :name, presence: {message: "The name of your store can't be blank"}, length: {maximum: 128}
    validates :description, presence: {message: "The description of your store can't be blank"}, length: {minimum: 20}
    validates :url, presence: {message: "The url of your store can't be blank"}, length: {maximum: 128}
    validates :store_type_id, presence: {message: "Please select your preferred store type"}

end