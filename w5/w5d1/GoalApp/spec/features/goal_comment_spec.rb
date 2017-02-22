require 'spec_helper'
require 'rails_helper'

feature "commenting on goal page" do

  before(:each) do
    visit new_user_url
    fill_in 'Username', :with => "testing_username"
    fill_in "Password", :with => "password"
    click_on "Create User"
    click_on "Add Goal"
    fill_in "Goal", :with => "Test Goal"
    click_on "Confirm Goal"
    click_on "Test Goal"

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
