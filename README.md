A simple [Dashing](http://shopify.github.com/dashing) dashboard with extra widgets which enable you to limit your current work in progress, in line with Kanban principles. The extra data retrieval jobs to enable this are:
* jira_wip : Retrieves current 'work in progress' counts from a JIRA Rapid Board. Configure jobs/jira_wip.rb with your JIRA location, username and password to use.
* jenkins_unhealthy : Retrieves build status from a Jenkins view, and reports the number of non-'blue' (healthy) builds. Not strictly Kanban related, but hey, I was writing code and I couldn't stop! Configure jobs/jenkins_unhealthy.rb to use.

To use:
* Make sure you have at least Ruby 1.9
* Clone the repository
* Install the gems necessary for Dashing ('bundle install' should take care of that)
* Customise jobs/jira_wip.rb and jobs/jira_wip.rb as necessary
* Run 'dashing start' from the root directory of the repository
* Visit [http://localhost:3030/](http://localhost:3030/) to view the dashboard.

For more information on Dashing, including its system requirements, check out the [Dashing](http://shopify.github.com/dashing) home page.