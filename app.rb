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
		d = r.properties
		d[:registrar] = d[:registrar].to_h
		if d[:registrant_contacts].is_a? Array
			d[:registrant_contacts][0] = d[:registrant_contacts][0].to_h
		end
		if d[:admin_contacts].is_a? Array
			d[:admin_contacts][0] = d[:admin_contacts][0].to_h
		end
		if d[:technical_contacts].is_a? Array
			d[:technical_contacts][0] = d[:technical_contacts][0].to_h
		end
		response = {"status" => 200, "data" => d}
	rescue Exception => e
		response = {"status" => 400, "error" => e.message}
	end

	# Respond
	JSON.pretty_generate(response)

end