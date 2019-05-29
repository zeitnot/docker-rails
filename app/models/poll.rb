class Poll < ApplicationRecord
  ## Associations
  has_many :options, class_name: 'PollOption'
  has_many :votes

  def vote_for(option, ip)
    votes.create(poll_option: option, ip: ip)
  end

  class << self
    def stats
      sql = <<-SQL
        SELECT p.id, p.poll_id, 
          (SELECT COUNT(*) FROM votes WHERE votes.poll_option_id = p.id)::int * 100.0 / 
          (SELECT COUNT(*) FROM votes WHERE votes.poll_id = p.poll_id)::int
        FROM poll_options AS p
        right join votes using(poll_id)
      SQL

      connection.select_all(sql).rows.each_with_object({}) do |result,hash|
        option_id, poll_id, score = result
        hash[[poll_id, option_id]] = Float(score).round
      end
    end
  end
end
