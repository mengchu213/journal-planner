require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end

  describe "GET /index" do
    it "returns http success" do
      get categories_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    context 'when user is not signed in' do
      before do
        allow_any_instance_of(CategoriesController).to receive(:current_user).and_return(nil)
      end
  
      it "redirects to the sign in page with an alert" do
        get category_path(category)
        expect(response).to redirect_to(new_session_url)
        expect(flash[:alert]).to eq("Please Sign In first!")
      end
    end
  
    context 'when user is signed in' do
      before do
        allow_any_instance_of(CategoriesController).to receive(:current_user).and_return(user)
      end
  
      it "returns http success" do
        get category_path(category)
        expect(response).to have_http_status(:success)
      end
    end
  end
  
  

  describe "GET /new" do
    it "returns http success" do
      get new_category_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      let(:valid_params) { { category: attributes_for(:category) } }

      it "creates a new Category" do
        expect {
          post categories_path, params: valid_params
        }.to change(Category, :count).by(1)
      end

      it "redirects to the created category" do
        post categories_path, params: valid_params
        expect(response).to redirect_to(Category.last)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) { { category: attributes_for(:category, name: nil) } }
  
      it "does not create a new Category" do
        expect {
          post categories_path, params: invalid_params
        }.not_to change(Category, :count)
      end
  
      it "returns a unprocessable entity response" do
        post categories_path, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
  

  describe "GET /edit" do
    it "returns http success" do
      get edit_category_path(category)
      expect(response).to have_http_status(:success)
    end
  end

  describe "PATCH /update" do
    let(:new_attributes) { { category: { name: 'New Category Name' } } }
    let(:invalid_attributes) { { category: { name: '' } } }

    it "updates the requested category" do
      patch category_path(category), params: new_attributes
      category.reload
      expect(category.name).to eq('New Category Name')
    end

    it "redirects to the category" do
      patch category_path(category), params: new_attributes
      category.reload
      expect(response).to redirect_to(category)
    end
    it "returns unprocessable entity status when update fails" do
      patch category_path(category), params: invalid_attributes
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested category" do
      category = create(:category, user: user)
      expect {
        delete category_url(category)
      }.to change(Category, :count).by(-1)
    end
  
    it "redirects to the categories list" do
      category = create(:category, user: user)
      delete category_url(category)
      expect(response).to redirect_to(categories_url)
    end
  end

end
