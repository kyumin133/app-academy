require 'rails_helper'

RSpec.describe UsersController, type: :controller do



  describe "GET #new" do
    it "renders the new users page" do
      get :new, user: {}

      expect(response).to render_template("new")
    end
  end


  describe "POST #create" do
    it "redirects to the show user page if valid params" do
      post :create, user: {username: "john", password: "password" }
      expect(response).to redirect_to(user_url(User.find_by(username: "john")))
    end

    it "renders new users page if invalid params" do
      post :create, user: {username: "samantha" }

      expect(response).to render_template("new")
    end
  end

  describe "GET #show" do
    it "renders the show user page" do
      User.create(username: "samantha", password: "password")
      get :show, id: User.find_by(username: "samantha").id

      expect(response).to render_template("show")
    end
  end

end
