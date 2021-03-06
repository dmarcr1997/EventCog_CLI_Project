class EventCog::API
    def fetch_api #get events from API and then create new events 
        key = ENV.fetch('TICKETMASTER_KEY')
        url = "https://app.ticketmaster.com/discovery/v2/events.json?countryCode=US&apikey=#{key}"
        response = HTTParty.get(url)
        response.parsed_response
        response["_embedded"]["events"].each do |event|
            EventCog::Event.new({ #create new events from info recieved
                "name" => event["name"],
                "date" => event["dates"]["start"]["localDate"],
                "url" => event["url"], 
                "venue" => event["_embedded"]["venues"][0]["name"], 
                "location" => "#{event["_embedded"]["venues"][0]["address"]["line1"]}, #{event["_embedded"]["venues"][0]["state"]["stateCode"]}"
            })
        end 
    end
end
