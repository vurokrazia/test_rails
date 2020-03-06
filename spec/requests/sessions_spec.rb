require "rails_helper"
RSpec.describe "Sessions", type: :request do
  let!(:token) { create(:token)}
  let(:user)   { create(:user)}
  let!(:create_params) { { "user": {"email"=>user.email,"password"=>user.password } }}
  let!(:create_params_empty) { { "user": {"email"=>nil,"password"=>nil } }}
  describe "POST sessions" do
    context "Sessions created successfully" do
      before { post "v1/sessions", params: create_params }
      context "payload" do
        subject { payload }
        it { is_expected.to include(:id, :expires_at, :token) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end  
    end
    context "Sessions empty, can't created" do
      before { post "v1/sessions", params: create_params_empty }
      context "payload" do
        subject { payload }
        it { is_expected.to include(:error) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:bad_request) }
      end  
    end
  end
  private
  def payload
    JSON.parse(response.body).with_indifferent_access
  end
end