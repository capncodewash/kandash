require 'net/http'
require 'json'
require 'uri'
require 'pp'

points = []

# Set your JIRA location here. Leave out the trailing slash on the end of the URL.
jenkins_url = 'http://my-jenkins-server.mycompany.com'
view_name = 'View' # The view in Jenkins that you'd like to monitor
healthy_status = 'blue' # The colour of 'healthy' builds in Jenkins' API. 
username = 'Jeeves' # Your Jenkins username
password = 'wooster' # Your Jenkins password

SCHEDULER.every '10s', :first_in => 0 do |job|
  uri = URI.parse(jenkins_url)
  http = Net::HTTP.new(uri.host, uri.port)
  req = Net::HTTP::Get.new("/jenkins/view/#{view_name}/api/json")
  req.basic_auth username, password
  response = http.request(req)
  jobs_data = JSON.parse(response.body)["jobs"]
  
  count=0
  
  if jobs_data
    jobs_data.each do |job| 
      
      if not job['color'] == healthy_status
        print "it isn't healthy\n"
        count+=1
      end
    end
  
    send_event('jenkins_unhealthy', value: count)
  end
end