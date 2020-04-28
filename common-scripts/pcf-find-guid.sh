| jq --raw-output '.[] | select(.installation_name|test("pivotal-container-service.")) | .guid'
