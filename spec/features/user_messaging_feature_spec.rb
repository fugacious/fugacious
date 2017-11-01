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

  end

  context 'when viewed' do
    before do
      find('input[name="commit"]').click
    end

    it 'displays the destruction warning' do
      visit message_url(Message.last.token)

      expect(page).to have_content(
        I18n.t(
          'show.destroy_warning_html',
          time_left: time_left_in_words,
          views_left: Message.last.remaining_views.to_i,
          pluralize_views:('s' unless Message.last.remaining_views == 1)
        )
      )
      expect(page).to have_content(I18n.t('flash.temporary'))
      expect(page).to_not have_content(I18n.t('flash.created'))
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
    it "doesn't display destruction warning" do
      fill_in 'message_max_views', with: 1
      find('input[name="commit"]').click
      visit message_url(Message.last)
      expect(page).not_to have_content 'This message will be destroyed'
    end

    it 'displays flash message and renders message shows template' do
      fill_in 'message_max_views', with: 1
      find('input[name="commit"]').click
      warning = (I18n.t('flash.expired_or'))
      message = Message.last

      visit message_url(message)
      visit message_url(message)

      expect(page).to have_content(warning)

      expect(current_path).to eq message_path(message)
    end
  end

  context 'deleting message', js: true do
    it 'redirects to root path' do
      find('input[name="commit"]').click
      click_on(I18n.t('show.destroy_link'))

      expect(current_path).to eq root_path
      expect(page).to have_content(I18n.t('flash.destroy_success'))
    end
  end

  def time_left_in_words
    'about 20 hours'
  end
end
