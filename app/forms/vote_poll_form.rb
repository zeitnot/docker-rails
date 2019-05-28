class VotePollForm
  include ActiveModel::Model

  attr_accessor :poll, :option, :option_id, :ip, :success

  validates_presence_of :option_id, message: 'Selection is required.'
  validate :validate_poll_and_option, if: :option_id
  validate :validate_if_poll_voted

  def initialize(params = {})
    @poll       = params[:poll]
    @option     = @poll.options.find_by(id: params[:option_id])
    @option_id  = @option&.id
    @ip         = params[:ip]
  end


  def save
    if valid?
      poll.vote_for(option,ip)
      self.success = true
    else
      self.success = false
      false
    end
  end

  private

  def validate_poll_and_option
    errors.add(:base, 'Option is not found.') unless option
  end

  def validate_if_poll_voted
    voted = Vote.where(poll: poll, ip: ip).exists?
    errors.add(:base, 'You voted for this poll before.') if voted
  end
end