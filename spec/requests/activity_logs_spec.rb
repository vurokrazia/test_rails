require "rails_helper"
RSpec.describe "Activity logs", type: :request do
  let!(:baby) { create(:baby)}
  let!(:activity) { create(:activity)}
  let!(:assistant) { create(:assistant)}
  let!(:datetime_params) { DateTime.now.to_s(:db) }
  let!(:datetime_params_n) { (DateTime.now + 1.hour) }
  let!(:create_params) { {"activity_log": { "baby_id" => baby.id,  "assistant_id" => assistant.id, "activity_id" => activity.id,  "start_time" => datetime_params,  "stop_time" => datetime_params, "duration" => 2, "comments" => "Lorem"} } }
  let!(:update_params) { {"activity_log": {"start_time" => datetime_params,  "stop_time" => datetime_params_n.to_s(:db), "duration" => 2, "comments" => "Lorem"} } }
  let!(:activity_log_params_empty) { {"activity_log": { "baby_id" => nil,  "assistant_id" => nil, "activity_id" => nil,  "start_time" => nil, "stop_time" => nil , "duration" => nil, "comments" => nil} } }
  let!(:activity_log_error_datetime) { {"activity_log": { "baby_id" =>  baby.id, "assistant_id" =>  assistant.id, "activity_id" =>  activity.id, "start_time" =>  datetime_params_n.to_s(:db),  "stop_time" => datetime_params ,  "duration" =>  7, "comments" =>  "Ut sed enim eaque."}} }
  let!(:activity_log_error_format_datetime) { {"activity_log": { "baby_id" =>  baby.id, "assistant_id" =>  assistant.id, "activity_id" =>  activity.id, "start_time" =>  "12:33 qw-23-2",  "stop_time" => "99 99 99 12-34-2020",  "duration" =>  7, "comments" =>  "Ut sed enim eaque."}} }
  let(:activity_log) { create(:activity_log )}
  describe "GET v1/activity_logs" do
    before { get 'v1/activity_logs' }
    it "should return ok" do 
			payload = JSON.parse(response.body)
			expect(payload).to be_empty
			expect(response).to have_http_status(200)
    end
  end
  describe "Search" do
    let!(:search_assistant) { create(:assistant)}
    let!(:search_activity) { create(:activity)}
    let!(:search_baby) { create(:baby)}
    let!(:activity_logs_list) { create_list(:activity_log, 10)}
    let!(:search_baby_list) { create_list(:activity_log, 3, baby_id:search_baby.id)}
    let!(:search_activity_list) { create_list(:activity_log, 5, activity_id:search_activity.id)}
    let!(:search_assistant_list) { create_list(:activity_log, 10, assistant_id:search_assistant.id)}
    let(:search_list) { create_list(:activity_log, 15, baby_id:search_baby.id, activity_id:search_activity.id, assistant_id:search_assistant.id)}
    it "should filter activity logs for baby" do
      get "/v1/activity_logs?baby_id=#{search_baby.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload.size).to eq(search_baby_list.size)
      expect(payload.map {|p| p["id"]}.sort).to eq(search_baby_list.map(&:id).sort)
      expect(response).to have_http_status(200)
    end
    it "should filter activity logs for activity" do
      get "/v1/activity_logs?activity_id=#{search_activity.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload.size).to eq(search_activity_list.size)
      expect(payload.map {|p| p["id"]}.sort).to eq(search_activity_list.map(&:id).sort)
      expect(response).to have_http_status(200)
    end
    it "should filter activity logs for assistant" do
      get "/v1/activity_logs?assistant_id=#{search_assistant.id}"
      payload = JSON.parse(response.body)
      expect(payload).to_not be_empty
      expect(payload.size).to eq(search_assistant_list.size)
      expect(payload.map {|p| p["id"]}.sort).to eq(search_assistant_list.map(&:id).sort)
      expect(response).to have_http_status(200)
    end
    it "should all filters activity logs nothing rows" do
      get "/v1/activity_logs?baby_id=#{search_baby.id}&activity_id=#{search_activity.id}&assistant_id=#{search_assistant.id}"
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(payload.size).to eq(0)
      expect(response).to have_http_status(200)
    end
  end
  describe "Search 15 rows" do
    let!(:search_list) { create_list(:activity_log, 15, baby_id:search_baby.id, activity_id:search_activity.id, assistant_id:search_assistant.id)}
    it "should all filters activity logs" do
      get "/v1/activity_logs?baby_id=#{search_baby.id}&activity_id=#{search_activity.id}&assistant_id=#{search_assistant.id}"
      payload = JSON.parse(response.body)
      expect(payload).to be_empty
      expect(payload.size).to eq(search_list.size)
      expect(response).to have_http_status(200)
    end
  end
  describe "with data in the DB" do
    let!(:activity_logs) { create_list(:activity_log, 10)}
    before { get "v1/activity_logs" }
    it "should return all the published activity_logs" do 
      payload = JSON.parse(response.body)
      expect(payload.size).to eq(activity_logs.size)
      expect(response).to have_http_status(200)
    end
  end
  describe "GET v1/activity_logs" do
    before { get "v1/activity_logs/#{activity_log.id}" }
    it "should return activity_log" do 
			expect(payload_crud).to_not be_empty
			expect(response).to have_http_status(200)
    end
  end
  describe "POST activity_logs" do
    context "Activity_logs created successfully" do
      before { post "v1/activity_logs", params: create_params }
      context "payload" do
        subject { payload_crud }
        it { is_expected.to include(:id, :baby_id,:assistant_id,:activity_id,:start_time,:stop_time,:duration,:comments) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end  
    end
    context "Activity_logs empty, can't created" do
      before { post "v1/activity_logs", params: activity_log_params_empty }
      context "payload" do
        subject { payload_crud }
        it { is_expected.to include(:error) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:unprocessable_entity) }
      end  
    end
    context "Activity_logs with datetime incorrect's, can't created" do
      before { post "v1/activity_logs", params: activity_log_error_datetime }
      context "payload" do
        subject { payload_crud }
        it { is_expected.to include(:error) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:unprocessable_entity) }
      end  
    end
    context "Activity_logs with datetime format incorrect's, can't created" do
      before { post "v1/activity_logs", params: activity_log_error_format_datetime }
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
  describe "PUT activity_logs" do
    context "Activity_logs updated successfully" do
      before { put "v1/activity_logs/#{activity_log.id}", params: update_params }
      context "payload" do
        subject { payload_crud }
        it { is_expected.to include(:id, :baby_id,:assistant_id,:activity_id,:start_time,:stop_time,:duration,:comments) }
      end  
      context "response" do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end  
    end
    context "Activity_logs empty, can't updated" do
      before { put "v1/activity_logs/#{activity_log.id}", params: activity_log_params_empty }
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