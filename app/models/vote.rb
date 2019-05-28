class Vote < ApplicationRecord
  ## Associations
  belongs_to :poll_option
  belongs_to :poll
end