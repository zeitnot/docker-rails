class Poll < ApplicationRecord
  ## Associations
  has_many :options, class_name: 'PollOption'
  has_many :votes

  def vote_for(option, ip)
    votes.create(poll_option: option, ip: ip)
  end
end
