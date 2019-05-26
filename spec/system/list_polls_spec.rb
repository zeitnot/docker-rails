require 'rails_helper'

RSpec.describe 'List Polls' do
  it 'list polls' do
    visit polls_path
    expect(page).to have_text(/how is/i)
  end
end