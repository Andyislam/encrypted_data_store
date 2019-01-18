project includes 2 API endpoints. 

GET /api/v1/data_encrypting_keys/rotate/status will return the current status of the rotate job. 
PUT /api/v1/data_encrypting_keys/rotate will either cue a rotate key job or return a message stating it's already in progress. 

Rspec tests can be run with the following commands.
models > bundle exec rspec spec/models
controllers (includes api controller)  > bundle exec rspec spec/controllers
integration test > bundle exec rspec spec/requests

