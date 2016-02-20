require 'rails_helper'

describe 'Site' do
  it 'has no missing translations at root' do
    visit '/'
    expect(page).not_to have_missing_translations
  end

  it 'has no missing translations at "/show"' do
    visit '/'
    fill_in 'message_body', with: 'this is a message'
    find('input[name="commit"]').click
    expect(page).not_to have_missing_translations
  end
end