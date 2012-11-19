require 'net/http'
require 'json'
require 'uri'
require 'pp'

points = []

# Set your JIRA location here. Leave out the trailing slash on the end of the URL.
jira_url = 'http://myjira.mycompany.com'
board_id = '38' # The ID number of the Rapid Board you wish to monitor
wip_status = 'In Progress' # The name of the 'work in progress' status. Get this from the Rapid Board or by querying the API directly. Normally, you don't need to change this.
username = 'Ms. Jira' # Your JIRA username
password = 'Thisismypassword' # Your JIRA password

SCHEDULER.every '60s', :first_in => 0 do |job|
  uri = URI.parse(jira_url)
  http = Net::HTTP.new(uri.host, uri.port)
  req = Net::HTTP::Get.new("/rest/greenhopper/1.0/xboard/work/allData.json?rapidViewId=#{board_id}")
  req.basic_auth username, password
  response = http.request(req)
  issues_data = JSON.parse(response.body)["issuesData"]["issues"]
  
  
  count=0
  
  if issues_data
    issues_data.each do |issue| 
      
      if issue['statusName'] == wip_status
        count+=1
      end
    end

    send_event('jira_wip', value: count)
  end
end