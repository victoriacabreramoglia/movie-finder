class Review < ApplicationRecord
  belongs_to :critic
  include Clients
end
