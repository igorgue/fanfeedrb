FanFeedrb
=========

Usage
-----

    client = Fanfeedr.new :api_key => "YOUR_API_KEY", :tier => 'basic'
    leagues = client.leagues

    puts leagues[0].name
    "NBA"

See more examples in the `test`: `test/fanfeedr_spec.rb`
