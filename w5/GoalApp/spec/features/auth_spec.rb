
require 'spec_helper'
require 'rails_helper'


feature "the signup process" do

  scenario "has a new user page" do
    visit new_user_url
    expect(page).to have_content "New User!"
  end

  feature "signing up a user" do
    scenario "shows username on the homepage after signup" do
      visit new_user_url
      fill_in 'Username', :with => "testing_username"
      fill_in "Password", :with => "password"
      click_on "Create User"

      expect(page).to have_content("testing_username")
    end


  end

end

feature "logging in" do

  scenario "shows username on the homepage after login" do
    visit new_session_url
    fill_in 'Username', :with => "testing_username"
    fill_in "Password", :with => "password"
    click_on "Login"

    expect(page).to have_content("testing_username")

  end

end

feature "logging out" do

  scenario "begins with a logged out state" do
    visit new_session_url
    fill_in 'Username', :with => "testing_username"
    fill_in "Password", :with => "password"
    click_on "Login"

    click_on "Logout"
    expect(page).to have_content("Login")
    # expect(session[:session_token]).to eq nil
  end

  scenario "doesn't show username on the homepage after logout" do
    visit new_session_url
    fill_in 'Username', :with => "testing_username"
    fill_in "Password", :with => "password"
    click_on "Login"

    click_on "Logout"
    expect(page).to_not have_content("testing_username")
  end

end
