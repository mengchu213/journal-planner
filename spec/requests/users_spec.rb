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
    context "when the user is the current user" do
      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      end

      it "destroys the requested user and redirects to the root url" do
        expect {
          delete user_url(user)
        }.to change(User, :count).by(-1)

        expect(response).to redirect_to(root_url)
      end
    end

    context "when the current user is an admin" do
      let(:admin) { create(:admin) } 

      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      end

      it "destroys the requested user and redirects to the users url" do
        expect {
          delete user_url(user)
        }.to change(User, :count).by(-1)

        expect(response).to redirect_to(users_url)
      end
    end
  end

  
  
  
  
end

# Comments:
# 1. The file starts by requiring the 'rails_helper' file, which configures the Rails testing environment.
# 2. RSpec.describe "Users": Initializes a test suite for the Users request.
# 3. let(:user) and let(:admin): These lines create test instances of a user and an admin for use in the tests.
# 4. before: This block stubs the current_user method to return the test user, simulating a logged in user.
# 5. describe "GET /index": This block tests the index action. It allows the current_user method to return the admin to simulate an admin accessing the index action.
# 6. describe "GET /show": This block tests the show action, ensuring that it returns http success.
# 7. describe "GET /new": This block tests the new action, ensuring that it returns http success.
# 8. describe "POST /create": This block tests the create action. It tests both valid and invalid parameters, checking the user count and the http status.
# 9. describe "GET /edit": This block tests the edit action, ensuring that it returns http success.
# 10. describe "PATCH /update": This block tests the update action. It checks whether the user is updated correctly and whether the HTTP response is as expected. It also checks for an unprocessable entity response when invalid attributes are provided.
# 11. describe "DELETE /destroy": This block tests the destroy action. It has two contexts - when the user is the current user and when the current user is an admin. It checks whether the user count is decreased and the correct redirect occurs upon deletion.