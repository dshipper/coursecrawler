set :application, "coursecrawler"             # Can be whatever you want, I use the project name from my SVN repository
set :domain, "coursecrawler.com"                           # The URL for your app
set :user, "p577r674"                                 # Your HostingRails username


# For a Git repository
# See http://www.hostingrails.com/forums/wiki_thread/59 for more info on Git and HostingRails
set :repository,  "#{user}@#{domain}:/home/#{user}/git/#{application}"                  # Or any other valid git clone path
set :scm, :git
set :branch, "master"


# set :scm_username, "svn_username"                   #if http
# set :scm_password, "svn_password"                   #if http
set :use_sudo, false                                  # HostingRails users don't have sudo access
set :deploy_to, "/home/#{user}/apps/#{application}"   # Where on the server your app will be deployed
set :deploy_via, :checkout                            # For this tutorial, svn checkout will be the deployment method, but check out :remote_cache in the future
set :group_writable, false                            # By default, Capistrano makes the release group-writable. You don't want this with HostingRails
# set :mongrel_port, "4444"                           # Mongrel port that was assigned to you
# set :mongrel_nodes, "4"                             # Number of Mongrel instances for those with multiple Mongrels

default_run_options[:pty] = true
# Cap won't work on windows without the above line, see
# http://groups.google.com/group/capistrano/browse_thread/thread/13b029f75b61c09d
# Its OK to leave it true for Linux/Mac

ssh_options[:keys] = %w(/Path/To/id_rsa)              # If you are using ssh_keys

role :app, domain
role :web, domain
role :db,  domain, :primary => true

namespace :deploy do
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end