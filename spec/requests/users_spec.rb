require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    before { allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin) }

    it "returns http success" do
      get users_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get new_user_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:valid_params) { { user: attributes_for(:user) } }

      it "creates a new User" do
        expect {
          post users_path, params: valid_params
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post users_path, params: valid_params
        expect(response).to redirect_to(User.last)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { { user: attributes_for(:user, name: nil) } }

      it "does not create a new User" do
        expect {
          post users_path, params: invalid_params
        }.not_to change(User, :count)
      end

      it "returns a unprocessable entity response" do
        post users_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get edit_user_path(user)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) { { user: { name: 'New User Name' } } }

    it "updates the requested user" do
      patch user_path(user), params: new_attributes
      user.reload
      expect(user.name).to eq('New User Name')
    end

    it "redirects to the user" do
      patch user_path(user), params: new_attributes
      user.reload
      expect(response).to redirect_to(user)
    end

    it "returns an unprocessable entity response" do
      new_attributes = { user: { name: '' } }
      patch user_path(user), params: new_attributes
      expect(response).to have_http_status(:unprocessable_entity)      
    end
    
  end

  describe "DELETE /destroy" do
    let(:user_to_delete) { create(:user) }
  
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_to_delete)
    end
  
    it "destroys the requested user" do
      expect {
        delete user_path(user_to_delete)
      }.to change(User, :count).by(-1)
    end
  
    it "redirects to the users list" do
      delete user_path(user_to_delete)
      expect(response).to redirect_to(categories_url)
    end
  end
  
  
  
end
