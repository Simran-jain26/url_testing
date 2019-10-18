require 'mail'
require 'net/http'
require 'json'


    uri = URI 'https://www.thrillophilia.com/v2/booking_requests?source=EnquiryLandingPa'
    https = Net::HTTP.new(uri.host, uri.port)
    https.use_ssl = true
    req=Net::HTTP::Post.new(uri.path,'Content-Type' => 'application/json');
    req.body={"booking_request[referer]":"https://www.thrillophilia.com/",
"booking_request[type]":"SendEnquiry",
"booking_request[bookable_id]":	"8923",
"booking_request[meta_sourceable_type]":"Card",
"booking_request[url]":	"/tours/5-days-and-4-nights-adventure-tour-in-dubai",
"booking_request[page_url]":"https://www.thrillophilia.com/listings/search?utf8=%E2%9C%93&tour%5Bdestination_slug%5D=&tour%5Bsearch%5D=leh&commit=Search",
"booking_request[content_card_title]":"4+Days+Cheapest+Dubai+Tour+Package+30%+off",
"booking_request[name]":"simran",
"booking_request[email]":"simranjain24941@gmail.com",
"booking_request[phone]":"9214932192",
"booking_request[date_of_travel]":"32/10/2019",
"booking_request[no_of_people]":"1"
}.to_json
res=https.request(req)
#puts res.code

if res.code != "200"


options = { :address              => "smtp.gmail.com",
            :port                 => 587,
	    :user_name            => 'simranjain24941@gmail.com',
            :password             => 'simmi9214924941',
            :authentication       => 'plain',
            :enable_starttls_auto => true  }

Mail.defaults do
  delivery_method :smtp, options
end

Mail.deliver do
       to 'simran@thrillophilia.com'
       from 'simranjain24941@gmail.com'
  subject 'Test'
     body 'Send enquiry is not working'
end
end
 

