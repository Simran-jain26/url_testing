#!/usr/bin/ruby -w

require 'rexml/document'
require 'net/http'
require 'zlib'
require 'open-uri'
require 'zip'
require 'mail'
include REXML

url = URI.parse("http://www.thrillophilia.com/sitemap.xml.gz")
req = Net::HTTP.new(url.host, url.port)
#req.use_ssl = true
res = req.request_head(url.path)
#puts res.code
if res.code == "301"

uri = "http://www.thrillophilia.com/sitemap.xml.gz"
source = open(uri)
gz = Zlib::GzipReader.new(source)
result = gz.read

file3=File.open("sitemap.xml","w")

file3.puts result


#file1 = File.open("right.txt", "w")
file2 = File.open("wrong.txt", "w")
f=1
g=1
xmlfile = File.open("sitemap.xml")
xmldoc = Document.new(xmlfile)
XPath.each(xmldoc,"/urlset/url[]/loc"){|e| 

begin
     f=1
     URI.parse(e.text+"/")
rescue
	 f=0
         file2.puts e.text+"wrong Url\n"
end 
if f==1
     url= URI.parse(e.text+"/")
	 req = Net::HTTP.new(url.host, url.port)
begin

g=1
req.request_head(url.path)
rescue
g=0
file2.puts e.text+"wrong request\n"
end 
end

}
#file1.close
file2.close
else
options = { :address              => "smtp.gmail.com",
            :port                 => 587,
	    :user_name            => 'simranjain24941@gmail.com',
            :password             => '*******',
            :authentication       => 'plain',
            :enable_starttls_auto => true  }

Mail.defaults do
  delivery_method :smtp, options
end

Mail.deliver do
       to 'simran@thrillophilia.com'
       from 'simranjain24941@gmail.com'
  subject 'Test'
     body 'http://www.thrillophilia.com/sitemap.xml.gz is not working'
end
end
if File.zero?("wrong.txt")
return
else
options = { :address              => "smtp.gmail.com",
            :port                 => 587,
            :user_name            => 'simranjain24941@gmail.com',
            :password             => '******',
            :authentication       => 'plain',
            :enable_starttls_auto => true  }

Mail.defaults do
  delivery_method :smtp, options
end

Mail.deliver do
       to 'simran@thrillophilia.com'
       from 'simranjain24941@gmail.com'
  subject 'Test'
     body 'body.txt'
     add_file '/home/user/Downloads/wrong.txt'
    
end
end















