require "rails_helper"
RSpec.describe "Assistant", type: :request do
  let!(:user) { create(:user)}
  let!(:create_params) { { "assistant": {"user_id"=>user.id, "name" => "Test Name","group" => "Test Group", "address" => "Test Address","phone" => "2283098384" } }}
  let!(:update_params) { { "assistant": {"user_id"=>user.id, "name" => "Test Name UPDATED", "group" => "Test Group UPDATED", "address" => "Test Address UPDATED","phone" => "1283098381" } }}
  let!(:assistant_params_empty) { { "assistant": {"name" => nil, "group" => nil, "address" => nil,"phone" => nil } }}
  let(:assistant) { create(:assistant)}
  let!(:bearer)   { create(:token)}
  let!(:auth_headers) { {'Authorization' =>	 "Bearer #{bearer.token}"} }
  describe "GET v1/assistants without auth_token" do
    before { get 'v1/assistants' }
      context "payload" do
        subject { payload_crud }
        it { is_expected.to include(:error) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:unauthorized) }
      end  
  end
  describe "GET v1/assistants" do
    before { get 'v1/assistants', headers: auth_headers }
    it "should return ok" do 
			payload = JSON.parse(response.body)
			expect(payload).to be_empty
			expect(response).to have_http_status(200)
    end
  end
  describe "with data in the DB" do
    let!(:assistants) { create_list(:assistant, 10)}
    before { get "v1/assistants", headers: auth_headers }
    it "should return all the published assistants" do 
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(assistants.size)
      expect(response).to have_http_status(200)
    end
  end
  describe "GET v1/assistants" do
    before { get "v1/assistants/#{assistant.id}", headers: auth_headers }
    it "should return assistant" do 
			expect(payload_crud).to_not be_empty
			expect(response).to have_http_status(200)
    end
  end
  describe "POST assistants" do
    context "Assistants created successfully" do
      before { post "v1/assistants", params: create_params, headers: auth_headers }
      context "payload" do
        subject { payload_crud }
        it { is_expected.to include(:id, :name, :group,  :address, :phone ) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end  
    end
    context "Assistants empty, can't created" do
      before { post "v1/assistants", params: assistant_params_empty, headers: auth_headers }
      context "payload" do
        subject { payload_crud }
        it { is_expected.to include(:error) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:unprocessable_entity) }
      end  
    end
  end
  describe "PUT Assistants" do
    context "Assistant updated successfully" do
      before { put "v1/assistants/#{assistant.id}", params: update_params, headers: auth_headers }
      context "payload" do
        subject { payload_crud }
        it { is_expected.to include(:id, :name, :group,  :address, :phone ) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end  
    end
    context "Assistant empty, can't updated" do
      before { put "v1/assistants/#{assistant.id}", params: assistant_params_empty, headers: auth_headers }
      context "payload" do
        subject { payload_crud }
        it { is_expected.to include(:error) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:unprocessable_entity) }
      end  
    end
  end
  private
  def payload_crud
    JSON.parse(response.body).with_indifferent_access
  end
end