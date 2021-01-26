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
end
