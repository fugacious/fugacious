require 'rails_helper'
require 'faker'

feature 'visitor', user_flow: true do
  context 'when visiting app directly' do
    before do
      visit root_url
    end

    it 'shows the new message form' do
      screenshot_and_save_page
    end

    context 'with a valid message and options' do
      before do
        fill_in 'message_body', with: Faker::Internet.password(48)
        fill_in 'message_max_views', with: 2
        find('input[name="commit"]').click
      end

      it 'displays my message for sharing' do
        screenshot_and_save_page
        @message_uri = current_url
      end

      context 'when viewing a message with views remaining' do
        before do
          visit @message_uri
        end

        it 'shows the message' do
          screenshot_and_save_page
        end

      end

      context 'when viewing a message with one view remaining' do
        before do
          2.times do
            visit @message_uri
          end
        end

        it 'shows the message and notifies of final view' do
          screenshot_and_save_page
        end
      end

      context 'when viewing a message without views remaining' do
        before do
          3.times do
            visit @message_uri
          end
        end

        it 'shows a friendly error message' do
          screenshot_and_save_page
        end
      end
    end
  end
end
