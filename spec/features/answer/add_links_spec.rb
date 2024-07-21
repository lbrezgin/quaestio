require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an answer's author
  I'd like to be able to add links
} do
  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }

  given(:link) { 'https://en.wikipedia.org/wiki/Cat' }
  given(:sec_link) { 'https://en.wikipedia.org/wiki/Dog' }

  background do
    sign_in(user)
    visit question_path(question)

    fill_in 'Body', with: 'Answers body'
  end

  scenario 'User adds links when give an answer', js: true do
    fill_in 'Link name', with: 'Cats'
    fill_in 'Url', with: link

    click_on 'add link'

    within all('.nested-fields').last do
      fill_in 'Link name', with: 'Dogs'
      fill_in 'Url', with: sec_link
    end

    click_on 'Answer'

    within '.answers' do
      expect(page).to have_link 'Dogs', href: sec_link
      expect(page).to have_link 'Cats', href: link
    end
  end

  scenario 'User adds link with invalid url when asks question', js: true do
    fill_in 'Link name', with: 'Cats'
    fill_in 'Url', with: "invalid url"

    click_on 'Answer'

    expect(page).to have_content "Links url is not a valid URL"
    expect(page).to_not have_link 'Cats', href: "invalid url"
  end
end