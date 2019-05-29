module ApplicationHelper
  def voted_at(poll)
    ip = request.remote_ip
    vote = poll.options.map(&:votes).flatten.detect{ |vote| vote.ip == ip }
    vote.created_at.to_s(:long) if vote
  end
end
