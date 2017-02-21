require 'rails_helper'

describe 'User Messaging' do
  before(:each) do
    visit '/'
    fill_in 'message_body', with: 'this is a message'
    fill_in 'message_max_views', with: 2
  end

  context 'when first created' do
    before do
      find('input[name="commit"]').click
    end

    it 'displays a successful created message' do
      expect(page).to have_content(I18n.t('flash.created'))
    end

    context 'when viewed' do
      before do
        visit message_url(Message.last.token)
      end

      it 'displays the destruction warning' do
        visit message_url(Message.last.token)
        expect(page).to have_content(I18n.t('show.destroy_warning_html'))
      end

      it 'does not display the successfully created message' do
        visit message_url(Message.last.token)
        expect(page).to_not have_content(I18n.t('flash.created'))
      end
    end
  end

  context 'when created and viewed with remaining views' do
    before do
      find('input[name="commit"]').click
      visit message_url(Message.last.token)
    end

    it 'displays message' do
      expect(page).to have_content 'this is a message'
    end

    it 'displays destruction warning' do
      warning = I18n.t('show.destroy_warning_html',
        time_left: 'about 20 hours',
        views_left: 1,
        pluralize_views: '')
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
      warning = (I18n.t('flash.deleted'))
    end
  end
end
