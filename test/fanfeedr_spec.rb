# fanfeedr_spec.rb

require 'fanfeedr'
require 'fakeweb'
require 'json'

describe Fanfeedr do
  before :all do
    @api_key = "test_api_key"
    @tier = "basic"
    @leagues_uri = "http://ffapi.fanfeedr.com/tier/api/leagues?api_key=#{@api_key}"
    @response = <<-JSON_RESPONSE
    [{"id": "1fa67523-cef0-5a64-9e21-9af5631109d5", "name": "Boxing"}, {"id": "6a72f772-9933-5d28-abfb-11fdcfbf7ec7", "name": "Formula One"}, {"id": "20f0857f-3c43-5f50-acfc-879f838ee853", "name": "MLB"}, {"id": "d40e07a0-8ff8-5e23-b7be-2f212e3bd307", "name": "NASCAR"}, {"id": "f65226d8-fbf7-5033-a7a0-50de55b57968", "name": "NBA"}, {"id": "ee80f32e-7b1a-51fd-ada0-70bb3f908845", "name": "NCAA Basketball"}, {"id": "961f07ae-1e75-54d6-9951-48b05cc58758", "name": "NCAA Football"}, {"id": "58839c69-5c60-5921-a5ed-1205c2ebcac5", "name": "NCAA Women"}, {"id": "13962b74-cab5-5d0a-93c8-466b6a3fa342", "name": "NFL"}, {"id": "8e5c52c9-b7c0-5343-8141-122e12fdc48f", "name": "NHL"}, {"id": "92c56b74-7860-58ef-8f3d-92402d0fe0cb", "name": "PGA"}, {"id": "f6ad29be-2699-5e5e-841c-1c04a2f5dbd4", "name": "Racing"}, {"id": "0a3c27d2-a655-58e4-a49c-9f3c7411c710", "name": "Soccer"}, {"id": "0f4005bb-b854-5c65-9f28-d564c2e0b7f8", "name": "Tennis"}]
    JSON_RESPONSE
    @response = @response.strip

    FakeWeb.register_uri(:any, @leagues_uri, :body => @response)
  end

  it "should return an array of leagues with ids" do
    #Net::HTTP.get(URI.parse("http://ffapi.fanfeedr.com/tier/api/leagues?api_key=test_api_key")).should eql(@response)
    leagues_names = JSON::load(@response).map { |item| item['name'] }
 
    client = Fanfeedr.new :api_key => @api_key, :tier => @tier
    leagues = client.leagues

    leagues.size.should be > 0

    leagues.each do |league|
      leagues_names.should include(league.name)
    end
  end
end