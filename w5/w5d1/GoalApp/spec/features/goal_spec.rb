require 'spec_helper'
require 'rails_helper'

feature "CRUDing goals" do
  before(:each) do
    visit new_user_url
    fill_in "Username", :with => "testing_username"
    fill_in "Password", :with => "password"
    click_on "Create User"
  end

  feature "creating goals" do
    scenario "displays comment on user page after creation" do
      click_on "Add Goal"
      fill_in "Goal", with: "Pass the 4th Assessment"
      page.choose("public")
      click_on "Confirm Goal"

      expect(page).to have_content("Pass the 4th Assessment")
    end

    scenario "returns to goal create page if invalid params" do
      click_on "Add Goal"
      click_on "Confirm Goal"

      expect(page).to have_content("New Goal")
      expect(page).to have_content("Name can't be blank")
    end

    scenario "able to set goal to private" do
      click_on "Add Goal"
      fill_in "Goal", with: "Pass the 4th Assessment"
      page.choose("private")
      click_on "Confirm Goal"

      expect(Goal.last.private).to be(true)
    end

    scenario "able to set goal to public" do
      click_on "Add Goal"
      fill_in "Goal", with: "Pass the 4th Assessment"
      page.choose("public")
      click_on "Confirm Goal"

      expect(Goal.last.private).to be(false)
    end

  end

  feature "reading goals" do
    before(:each) do
      click_on "Add Goal"
      fill_in "Goal", with: "Pass the 4th Assessment"
      page.choose("private")
      click_on "Confirm Goal"

      click_on "Add Goal"
      fill_in "Goal", with: "Pass the 5th Assessment"
      page.choose("public")
      click_on "Confirm Goal"
    end

    scenario "displays all goals for current user" do
      expect(page).to have_content("Pass the 4th Assessment")
      expect(page).to have_content("Pass the 5th Assessment")
    end

    scenario "only displays public goals for other users" do
      click_on "Logout"
      visit new_user_url
      fill_in 'Username', :with => "testing_username2"
      fill_in "Password", :with => "password"
      click_on "Create User"
      visit user_url(User.find_by(username: "testing_username"))
      expect(page).to_not have_content("Pass the 4th Assessment")
      expect(page).to have_content("Pass the 5th Assessment")
    end
  end

  feature "updating goals" do
    before(:each) do
      click_on "Add Goal"
      fill_in "Goal", with: "Pass the 4th Assessment"
      page.choose("public")
      click_on "Confirm Goal"
    end

    scenario "current user can see a edit button on his own goals page" do
      expect(page).to have_selector(:button, "Edit Goal")
    end

    scenario "does not allow user to update other users' goals" do
      click_on "Logout"
      visit new_user_url
      fill_in 'Username', :with => "testing_username2"
      fill_in "Password", :with => "password"
      click_on "Create User"
      visit user_url(User.find_by(username: "testing_username"))

      expect(page).to_not have_selector(:button, "Edit Goal")
    end

    scenario "successfully updates user's goal if valid params" do
      click_on "Edit Goal"
      fill_in "Goal", with: "Pass the 5th Assessment"
      click_on "Confirm Goal"

      expect(page).to have_content("Pass the 5th Assessment")
    end

    scenario "returns to goal edit page and shows errors if invalid params" do
      click_on "Edit Goal"
      fill_in "Goal", with: ""
      click_on "Confirm Goal"

      expect(page).to have_content("Edit Goal")
      expect(page).to have_content("Name can't be blank")
    end
  end
  feature "deleting goals" do
    before(:each) do
      click_on "Add Goal"
      fill_in "Goal", with: "Pass the 4th Assessment"
      page.choose("public")
      click_on "Confirm Goal"
    end

    scenario "does not allow user to delete other users' goals" do
      click_on "Logout"
      visit new_user_url
      fill_in 'Username', :with => "testing_username2"
      fill_in "Password", :with => "password"
      click_on "Create User"
      visit user_url(User.find_by(username: "testing_username"))

      expect(page).to_not have_selector(:button, "Delete Goal")
    end


    scenario "sucessfully deletes own goals" do
      click_on "Delete Goal"

      expect(page).to_not have_content("Pass the 4th Assessment")
    end

  end
end
