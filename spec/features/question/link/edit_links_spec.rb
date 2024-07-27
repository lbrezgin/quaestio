require 'rails_helper'

feature 'User can edit questions links count', %q{
  In order to give more information
  As an author of link
  I'd like to be able to add more links
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, user: user) }
  given(:link) { 'https://en.wikipedia.org/wiki/Cat' }

  scenario 'User adds link when edit question', js: true do
    sign_in(user)

    visit question_path(question)
    click_on 'Edit question'

    within '.question' do
      click_on 'add link'

      fill_in 'Link name', with: 'Cats'
      fill_in 'Url', with: link

      click_on 'Save'
      expect(page).to have_link 'Cats', href: link
    end
  end
end