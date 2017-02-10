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

      warning = I18n.t('show.destroy_warning_html',
        time_left: 'about 20 hours',
        views_left: 2,
        pluralize_views: 's')
      expect(page.html.include? warning).to eq(true)
    end
  end

  context 'when no remaining views' do
    before(:each) do
      fill_in 'message_max_views', with: 1
      find('input[name="commit"]').click
    end

    it 'displays message' do
      expect(page).to have_content 'this is a message'
    end

    it "doesn't display destruction warning" do
      visit message_url(Message.last)
      expect(page).to have_no_content 'This message will be destroyed'
    end

    it 'displays flash message' do
      visit message_url(Message.last)
      expect(page).to have_content(I18n.t('flash.deleted'))
    end
  end
end
