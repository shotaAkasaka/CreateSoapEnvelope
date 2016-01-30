require "date"

outfile = "setstock.xml"

top = <<EOS
<?xml version="1.0" encoding="UTF-8"?>
<soapenv:Envelope xmlns:soapenv="http://www.w3.org/2003/05/soap-envelope">
EOS

# loginid = "20000003"
loginid = ARGV[0]
# password = "p@ssw0rd"
password = ARGV[1]

head = <<EOS
  <soapenv:Header>
    <loginid>#{loginid}</loginid>
    <password>#{password}</password>
  </soapenv:Header>
EOS

body_start = <<EOS
  <soapenv:Body>
EOS

# start_day = 20160201.to_s
# end_day = 20160301.to_s

start_day = ARGV[2].to_s
end_day = ARGV[3].to_s

start_date = Date.new(start_day[0,4].to_i, start_day[4,2].to_i, start_day[6,2].to_i)
end_date = Date.new(end_day[0,4].to_i, end_day[4,2].to_i, end_day[6,2].to_i)

body_content = ""
stock = ARGV[4]

(start_date..end_date).each{ |day|
  body_part = <<EOS
    <date>#{day.to_s.delete('-')}</date>
    <room>#{stock}</room>
EOS
  body_content.concat(body_part)
}

body_end = <<EOS
  </soapenv:Body>
EOS

bottom = <<EOS
</soapenv:Envelope>
EOS

File.open(outfile, "w") do |file|
  file.puts(top)
  file.puts(head)
  file.puts(body_start)
  file.puts(body_content)
  file.puts(body_end)
  file.puts(bottom)
end

