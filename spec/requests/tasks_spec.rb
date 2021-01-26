require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET tasks#index" do
    before(:example) do
      @first_task = FactoryBot.create(:task)
      @second_task = FactoryBot.create(:task)
      get tasks_path
      @json_response = JSON.parse(response.body)
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'contains the correct number of entries' do
      expect(@json_response['tasks'].count).to eq(2)
    end

    it 'task contains expected attributes' do
      expect(@json_response['tasks'].first).to include({
        'id' => @first_task.id,
        'title' => @first_task.title
      })
    end
  end

  describe 'POST tasks#create' do
    context 'when the task is valid' do
      before(:example) do
        @task_params = FactoryBot.attributes_for(:task)
        post tasks_path, params: { task: @task_params }
      end

      it 'returns http created' do
        expect(response).to have_http_status(:created)
      end

      it 'saves the Task to the database' do
        expect(Task.last.title).to eq(@task_params[:title])
      end
    end

    context 'when the task is invalid' do
      before(:example) do
        @task_params = FactoryBot.attributes_for(:task, :invalid)
        post tasks_path, params: { task: @task_params }
        @json_response = JSON.parse(response.body)
      end

      it 'return http unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns the correct number of errors' do
        expect(@json_response['errors'].count).to eq(1)
      end

      it 'errors contains the correct error message' do
        expect(@json_response['errors'].first).to eq("Title can't be blank")
      end
    end
  end
end
