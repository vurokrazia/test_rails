require "rails_helper"
RSpec.describe "Babies", type: :request do
  let!(:create_params) { { "baby": {"name" => "Test", "birthday" => Time.new.strftime("%d/%m/%Y"), "mother_name" => "Mon Test", "father_name" => "Father Test", "address" => "Lazaro Cardenas", "phone" => "2283098384" } }}
  let!(:update_params)  { { "baby": {"name" => "Test UPDATED", "birthday" => Time.new.strftime("%d/%m/%Y"), "mother_name" => "Mon UPDATED", "father_name" => "Father UPDATED", "address" => "Lazaro Cardenas", "phone" => "2283098384" } }}
  let!(:baby_params_empty) { { "baby": {"name" => nil, "birthday" => nil, "mother_name" => nil, "father_name" => nil, "address" => nil, "phone" => nil } } }
  let(:baby) { create(:baby )}
  describe "GET v1/babies" do
    before { get 'v1/babies' }
    it "should return ok" do 
			payload = JSON.parse(response.body)
			expect(payload).to be_empty
			expect(response).to have_http_status(200)
    end
  end
  describe "with data in the DB" do
    let!(:babies) { create_list(:baby, 10)}
    before { get "v1/babies" }
    it "should return all the published babies" do 
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(babies.size)
      expect(response).to have_http_status(200)
    end
  end
  describe "GET v1/babies" do
    before { get "v1/babies/#{baby.id}" }
    it "should return baby" do 
			expect(payload_crud).to_not be_empty
			expect(response).to have_http_status(200)
    end
  end
  describe "POST babies" do
    context "Baby created successfully" do
      before { post "v1/babies", params: create_params }
      context "payload" do
        subject { payload_crud }
        it { is_expected.to include(:id, :name, :birthday, :mother_name, :father_name, :address, :phone ) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end  
    end
    context "Baby empty, can't created" do
      before { post "v1/babies", params: baby_params_empty }
      context "payload" do
        subject { payload_crud }
        it { is_expected.to include(:error) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:unprocessable_entity) }
      end  
    end
    describe "PUT babies" do
      context "Baby updated successfully" do
        before { put "v1/babies/#{baby.id}", params: update_params }
        context "payload" do
          subject { payload_crud }
          it { is_expected.to include(:id, :name, :birthday, :mother_name, :father_name, :address, :phone ) }
        end  
        context "response" do
          subject { response }
          it { is_expected.to have_http_status(:ok) }
        end  
      end
      context "Baby empty, can't updated" do
        before { put "v1/babies/#{baby.id}", params: baby_params_empty }
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
  end

  private
  def payload_crud
    JSON.parse(response.body).with_indifferent_access
  end
end