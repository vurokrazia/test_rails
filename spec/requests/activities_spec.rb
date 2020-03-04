require "rails_helper"
RSpec.describe "Activities", type: :request do
  let!(:create_params) { {"activity": {"name" => "Kinedu Test","description" => "Description"} } }
  let!(:update_params) { {"activity": {"name" => "Kinedu Test 2","description" => "Description test"} } }
  let!(:activity_params_empty) { {"activity": {"name" => "","description" => ""} } }
  let(:activity) { create(:activity )}
  describe "GET v1/activities" do
    before { get 'v1/activities' }
    it "should return ok" do 
			payload = JSON.parse(response.body)
			expect(payload).to be_empty
			expect(response).to have_http_status(200)
    end
  end
  describe "with data in the DB" do
    let! (:activities) { create_list(:activity, 10)}
    it "should return all the published posts" do 
      get 'v1/activities'
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(activities.size)
      expect(response).to have_http_status(200)
    end
  end
  describe "GET v1/activities" do
    before { get "v1/activities/#{activity.id}" }
    it "should return activity" do 
			expect(payload_crud).to_not be_empty
			expect(response).to have_http_status(200)
    end
  end
  describe "POST activities" do
    context "Activity created successfully" do
      before { post "v1/activities", params: create_params }
      context "payload" do
        subject { payload_crud }
        it { is_expected.to include(:id, :name, :description) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end  
    end
    context "Activity empty, can't created" do
      before { post "v1/activities", params: activity_params_empty }
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
  describe "PUT activities" do
    context "Activity updated successfully" do
      before { put "v1/activities/#{activity.id}", params: update_params }
      context "payload" do
        subject { payload_crud }
        it { is_expected.to include(:id, :name, :description) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end  
    end
    context "Activity empty, can't updated" do
      before { put "v1/activities/#{activity.id}", params: activity_params_empty }
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
  describe "DESTROY activities" do
    context "Activity destroy successfully" do
      before { destroy "v1/activities/#{activity.id}"}
      context "payload" do
        subject { payload_crud }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end  
    end
  end
  private
  def payload_crud
    JSON.parse(response.body).with_indifferent_access
  end
end