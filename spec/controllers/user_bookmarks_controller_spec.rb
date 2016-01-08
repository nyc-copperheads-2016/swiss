require 'rails_helper'

RSpec.describe UserBookmarksController, type: :controller do

  before(:each) do
     u = FactoryGirl.create(:user)
     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(u)
  end

  context "new" do
    it "successfully renders a new UserBookmark form" do
      get :new
      expect(response).to render_template(:new)
    end
  end
  context "create" do
    it "redirects to root path with correct parameters" do
      post :create, url: Faker::Internet.url, user_bookmark: {name: Faker::Book.title}
      expect(response).to redirect_to user_bookmarks_path
    end
    it "redirects back to form with non-existant parameters" do
      post :create, url: Faker::Internet.url, user_bookmark: {name: Faker::Book.title}
      expect(response).to redirect_to new_user_bookmark_path
    end
  end
end