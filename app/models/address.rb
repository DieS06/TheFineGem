class Address < ApplicationRecord
  def full_address
    attributes.values.join(", ")
  end
end
