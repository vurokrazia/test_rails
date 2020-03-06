require "rails_helper"
RSpec.describe "Grettings", type: :request do
  let!(:say_hello) { "Hello World" }
  let!(:say_hola) { "Hola Mundo" }
  describe "GET grettings default" do
    before { get 'http://localhost:3000/api/grettings' }
    it "should return Hola Mundo of default" do 
      expect(payload).to_not be_empty
      expect(payload["message"]).to eq(say_hola)
			expect(response).to have_http_status(200)
    end
  end
  describe "GET es/grettings" do
    before { get 'http://localhost:3000/es/api/grettings' }
    it "should return Hola Mundo" do 
      expect(payload).to_not be_empty
      expect(payload["message"]).to eq(say_hola)
			expect(response).to have_http_status(200)
    end
  end
  describe "GET en/grettings" do
    before { get 'http://localhost:3000/en/api/grettings' }
    it "should return Hola Mundo" do 
      expect(payload).to_not be_empty
      expect(payload["message"]).to eq(say_hello)
			expect(response).to have_http_status(200)
    end
  end
  private
  def payload
    JSON.parse(response.body).with_indifferent_access
  end
end