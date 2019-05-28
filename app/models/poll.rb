class Poll < ApplicationRecord
  ## Associations
  has_many :options, class_name: 'PollOption'
end
