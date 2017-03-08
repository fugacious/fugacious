require 'rails_helper'

feature 'Error messages' do
  scenario 'messages form' do
    visit root_path
    find('input[name="commit"]').click

    within('.usa-alert') do
      expect(page).to have_content("Message can't be blank")
    end
  end
end
