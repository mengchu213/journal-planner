require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  let(:user) { create(:user) }
  let(:category) { create(:category, user: user) }
  let(:task) { create(:task, category: category) }
  let(:valid_attributes) { attributes_for(:task) }
  let(:invalid_attributes) { { name: "" } }

  

  describe "GET /index" do
    
    context 'when user is not signed in' do
        it 'does not return tasks' do
          get category_tasks_url(category)
          expect(response.body).not_to match(/task-selector/)
        end
      end

    context 'when user is not signed in' do
      it 'redirects to the sign-in page' do
        get category_tasks_url(category)
        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'when user is signed in' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        task
        get category_tasks_url(category)
      end

      it "renders a successful response" do
        expect(response).to be_successful
      end

      it "fetches the tasks" do
        expect(Task.where(category: category)).to include(task)
      end
    end
  end

  describe "GET /show" do
    context 'when user is not signed in' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(nil)
        get category_task_url(category.id, task.id)
      end
  
      it 'redirects to the sign-in page' do
        expect(response).to redirect_to(new_session_url)
      end
  
      it 'sets a flash alert message' do
        expect(flash[:alert]).to eq 'Please sign in first!'
      end
    end
  
    context 'when user is signed in' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        get category_task_url(category.id, task.id)
      end
  
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end
    end
  end
  

  describe "GET /new" do
    context 'when user is not signed in' do
      it 'redirects to the sign-in page' do
        get new_category_task_url(category)
        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'when user is signed in' do
      before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        get new_category_task_url(category)
      end

      it "includes input fields for task creation" do
        expect(response.body).to match(/<input [^>]*type="text" [^>]*name="task\[name\]"/)
      end

      it "returns a successful response" do
        expect(response).to be_successful
      end
    end
  end


  describe "POST /create" do
    context "with valid parameters" do
        before do
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
          end
      it "creates a new Task" do
        expect {
          post category_tasks_url(category), params: { task: valid_attributes }
        }.to change(Task, :count).by(1)
      end

      it "redirects to the category show page" do
        post category_tasks_url(category), params: { task: valid_attributes }
        expect(response).to redirect_to(category_url(category))
      end
    end

    context "with invalid parameters" do
        before do
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
          end
      it "does not create a new Task" do
        expect {
          post category_tasks_url(category), params: { task: invalid_attributes }
        }.to change(Task, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post category_tasks_url(category), params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
        before do
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
          end
      let(:new_attributes) { { name: "New Task Name" } }

      it "updates the requested task" do
        patch category_task_url(category, task), params: { task: new_attributes }
        task.reload
        expect(task.name).to eq("New Task Name")
      end

      it "redirects to the category show page" do
        patch category_task_url(category, task), params: { task: new_attributes }
        task.reload
        expect(response).to redirect_to(category_url(category))
      end
    end


    context "with invalid parameters" do
        before do
            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
          end
      it "renders an unsuccessful response (i.e. to display the 'edit' template)" do
        patch category_task_url(category, task), params: { task: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      end
    it "destroys the requested task" do
      task
      expect {
        delete category_task_url(category, task)
      }.to change(Task, :count).by(-1)
    end

    it "redirects to the tasks list" do
      delete category_task_url(category, task)
      expect(response).to redirect_to(category_url(category))
    end
  end

end
