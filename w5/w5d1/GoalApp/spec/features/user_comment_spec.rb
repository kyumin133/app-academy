require 'spec_helper'
require 'rails_helper'

feature "commenting on user page" do
  before(:each) do
    visit new_user_url
    fill_in 'Username', :with => "testing_username"
    fill_in "Password", :with => "password"
    click_on "Create User"

    fill_in "Comment", with: "Testing Comment"
    click_on "Add Comment"
  end

  scenario "adds a comment to the page" do
    expect(page).to have_content("Testing Comment")
  end

  scenario "displays the comment author's username" do
    expect(page).to have_content("testing_username")
  end
end
