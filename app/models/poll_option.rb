class PollOption < ApplicationRecord
  ## Associations
  has_many :votes
end
