require 'sinatra'
require 'whois'
require 'json'

get '/:domain_name' do 

	api_key_file = "api-keys.txt";

	# Authenticate request
	valid_request = false
	f = File.open(api_key_file, "r")
	f.each_line do |line|
		if line == request.env['HTTP_WHOIS_API_KEY']
			valid_request = true
			break
		end
	end
	f.close
	error 401 unless valid_request

	# Lookup the domain
	c = Whois::Client.new
	begin
		r = c.lookup(params[:domain_name]);
		response = {"status" => 200, "data" => r.properties}.to_json
		response
	rescue Exception => e
		response = {"status" => 400, "error" => e.message}.to_json
		response
	end

end