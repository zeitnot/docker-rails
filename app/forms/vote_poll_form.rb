class VotePollForm
  include ActiveModel::Model

  attr_accessor :poll, :option, :ip

  validate :validate_poll_and_option
  validate :validate_if_poll_voted

  def initialize(params = {})
    @poll     = params[:poll]
    @option   = @poll.options.find_by(id: params[:option_id])
    @ip       = params[:ip]
  end


  def save
    return poll.vote_for(option,ip) if valid?
    false
  end

  private

  def validate_poll_and_option
    errors.add(:base, 'Option is not found') unless option
  end

  def validate_if_poll_voted
    voted = Vote.where(poll: poll, ip: ip).exists?
    errors.add(:base, 'You voted for this poll before') if voted
  end
end