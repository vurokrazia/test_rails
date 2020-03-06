require "rails_helper"
RSpec.describe "pagination", type: :request do
  let!(:bearer)   { create(:token)}
  let!(:auth_headers) { {'Authorization' =>	 "Bearer #{bearer.token}"} }
  let!(:activity_logs) { create_list(:activity_log,60)}
  let(:max_results) { 30 }
  let(:page_1) { 1 }
  let(:page_2) { 2 }
  let(:page_3) { 3 }
  
  describe "Pagination of babies" do 
    describe "GET v1/babies pagination first page" do
      before { get "v1/babies?page=#{page_1}&max_results=#{max_results}", headers: auth_headers  }
      it "should return 30 babies" do 
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload.size).to eq(max_results)
        expect(response).to have_http_status(200)
      end
    end
    describe "GET v1/babies pagination second page" do
      before { get "v1/babies?page=#{page_2}&max_results=#{max_results}", headers: auth_headers  }
      it "should return 30 babies" do 
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload.size).to eq(max_results)
        expect(response).to have_http_status(200)
      end
    end
    describe "GET v1/babies pagination third page" do
      before { get "v1/babies?page=#{page_3}&max_results=#{max_results}", headers: auth_headers  }
      it "should return 0 babies" do 
        payload = JSON.parse(response.body)
        expect(payload).to be_empty
        expect(response).to have_http_status(200)
      end
    end
  end
  describe "Pagination of activities" do 
    describe "GET v1/activities pagination first page" do
      before { get "v1/activities?page=#{page_1}&max_results=#{max_results}", headers: auth_headers  }
      it "should return 30 activities" do 
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload.size).to eq(max_results)
        expect(response).to have_http_status(200)
      end
    end
    describe "GET v1/activities pagination second page" do
      before { get "v1/activities?page=#{page_2}&max_results=#{max_results}", headers: auth_headers  }
      it "should return 30 activities" do 
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload.size).to eq(max_results)
        expect(response).to have_http_status(200)
      end
    end
    describe "GET v1/activities pagination third page" do
      before { get "v1/activities?page=#{page_3}&max_results=#{max_results}", headers: auth_headers  }
      it "should return 0 activities" do 
        payload = JSON.parse(response.body)
        expect(payload).to be_empty
        expect(response).to have_http_status(200)
      end
    end
  end
  describe "Pagination of assistants" do 
    describe "GET v1/assistants pagination first page" do
      before { get "v1/assistants?page=#{page_1}&max_results=#{max_results}", headers: auth_headers  }
      it "should return 30 assistants" do 
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload.size).to eq(max_results)
        expect(response).to have_http_status(200)
      end
    end
    describe "GET v1/assistants pagination second page" do
      before { get "v1/assistants?page=#{page_2}&max_results=#{max_results}", headers: auth_headers  }
      it "should return 30 assistants" do 
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload.size).to eq(max_results)
        expect(response).to have_http_status(200)
      end
    end
    describe "GET v1/assistants pagination third page" do
      before { get "v1/assistants?page=#{page_3}&max_results=#{max_results}", headers: auth_headers  }
      it "should return 0 assistants" do 
        payload = JSON.parse(response.body)
        expect(payload).to be_empty
        expect(response).to have_http_status(200)
      end
    end
  end
  describe "Pagination of activity_logs" do 
    describe "GET v1/activity_logs pagination first page" do
      before { get "v1/activity_logs?page=#{page_1}&max_results=#{max_results}", headers: auth_headers  }
      it "should return 30 activity_logs" do 
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload.size).to eq(max_results)
        expect(response).to have_http_status(200)
      end
    end
    describe "GET v1/activity_logs pagination second page" do
      before { get "v1/activity_logs?page=#{page_2}&max_results=#{max_results}", headers: auth_headers  }
      it "should return 30 activity_logs" do 
        payload = JSON.parse(response.body)
        expect(payload).to_not be_empty
        expect(payload.size).to eq(max_results)
        expect(response).to have_http_status(200)
      end
    end
    describe "GET v1/activity_logs pagination third page" do
      before { get "v1/activity_logs?page=#{page_3}&max_results=#{max_results}", headers: auth_headers  }
      it "should return 0 activity_logs" do 
        payload = JSON.parse(response.body)
        expect(payload).to be_empty
        expect(response).to have_http_status(200)
      end
    end
  end
end