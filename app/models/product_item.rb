class ProductItem < ApplicationRecord
  belongs_to :product_model
  belongs_to :warehouse

  before_validation:ensure_code_is_random

  validates :code, :price, :batch, presence: true
  validates :code, uniqueness: true
  validates :code, length: { is: 20 }
  
  private
    def ensure_code_is_random
      if code.nil?
        self.code = SecureRandom.alphanumeric(20)
      end
    end
end
