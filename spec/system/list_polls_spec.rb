require 'rails_helper'

RSpec.describe 'List Polls' do

  before do
    @polls = FactoryBot.create_list(:poll_with_options, 3)
  end


  context 'poll listing' do

    before do
      visit polls_path
    end

    it 'contains poll name in h3 title' do
      @polls.each do |poll|
        node = page.find("#edit_poll_#{poll.id} .panel h3")
        expect(node.text).to eql(poll.name)
      end
    end

    it 'contains poll options' do
      @polls.each do |poll|
        node = page.find("#edit_poll_#{poll.id} .poll-options")

        expect(poll.options).to be_exists
        poll.options.each do |option|
          expect(node.text).to be_match(/#{option.name}/i)
        end
      end
    end
  end


  it 'toggles polls upon click', js: true do
    visit polls_path

    @polls.each do |poll|
      expect(page.find("#edit_poll_#{poll.id} .poll-options", visible: :all)).to_not be_visible

      page.evaluate_script("$('#edit_poll_#{poll.id} .panel-heading').click()")
      expect(page.find("#edit_poll_#{poll.id} .poll-options")).to be_visible
    end
  end
end