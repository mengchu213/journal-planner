RSpec.describe "Home", type: :request do
    describe "GET #home" do
      context "when user is signed in" do
        let(:user) { create(:user) }
  
        before do
          post session_url, params: { email_or_username: user.email, password: user.password }
        end
  
        it "redirects to categories path" do
          get root_path
          expect(response).to redirect_to(categories_path)
        end
      end
  
      context "when user is not signed in" do
        it "renders the home page" do
          get root_path
          expect(response).to be_successful
        end
      end
    end
  end
  