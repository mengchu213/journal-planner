require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe "GET #new" do
    it "returns a successful response" do
      get signin_url
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid credentials" do
      it "logs in the user and redirects to the user's page" do
        post session_url, params: { email_or_username: user.email, password: user.password }
        expect(response).to redirect_to(user)
      end
    end

    context "with invalid credentials" do
      it "does not log in the user and re-renders the new template with an alert" do
        post session_url, params: { email_or_username: "invalid", password: "invalid" }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      post session_url, params: { email_or_username: user.email, password: user.password }
    end

    it "logs out the user and redirects to the root path" do
      delete session_url
      expect(response).to redirect_to(root_url)
    end
  end
end
