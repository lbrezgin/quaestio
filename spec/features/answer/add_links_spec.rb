require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an answer's author
  I'd like to be able to add links
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  given(:link) { 'https://en.wikipedia.org/wiki/Cat' }

  scenario 'User adds link when give an answer', js: true do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'Answers body'
    fill_in 'Link name', with: 'Cats'
    fill_in 'Url', with: link

    click_on 'Answer'

    within '.answers' do
      expect(page).to have_link 'Cats', href: link
    end
  end
end
