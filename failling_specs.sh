rspec ./spec/controllers/people_controller_spec.rb:152 # PeopleController#show 404s if no person is found via id
rspec ./spec/controllers/people_controller_spec.rb:147 # PeopleController#show 404s if the id is invalid
rspec ./spec/controllers/people_controller_spec.rb:167 # PeopleController#show 404s if no person is found via diaspora handle
rspec ./spec/controllers/people_controller_spec.rb:157 # PeopleController#show 404s if no person is found via username
rspec ./spec/lib/api/openid_connect/token_endpoint_spec.rb:39 # Api::OpenidConnect::TokenEndpoint the authorization code grant type when the authorization code is valid should return an id token with a kid