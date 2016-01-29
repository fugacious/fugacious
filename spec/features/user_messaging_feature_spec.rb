require 'rails_helper'

describe 'Message Display' do
  before(:each) do
    visit '/'
    fill_in 'message_body', with: 'this is a message'
  end

  context 'when remaining views' do
    it 'displays message' do
      fill_in 'message_max_views', with: 2
      find('input[name="commit"]').click

      expect(page).to have_content 'this is a message'
    end

    it 'displays destruction warning' do
      fill_in 'message_max_views', with: 2
      find('input[name="commit"]').click

      expect(page).to have_content 'This message will be destroyed'
    end
  end

  context 'when no remaining views' do
    before(:each) do
      fill_in 'message_max_views', with: 0
      find('input[name="commit"]').click
    end

    it 'displays message' do
      expect(page).to have_content 'this is a message'
    end

    it "doesn't display destruction warning" do
      expect(page).to have_no_content 'This message will be destroyed'
    end

    it 'displays flash message' do
      expect(page).to have_content('This message has been deleted')
    end
  end
end
