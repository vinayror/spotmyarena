require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rvm' # for rvm support. (http://rvm.io)
require 'yaml'
require 'io/console'

['base', 'nginx', 'unicorn', 'mysql', 'check'].each do |pkg|
  require "#{File.join(__dir__, 'recipes', "#{pkg}")}"
end

set :application, 'spotmyarena'
set :user, set_user
set :deploy_to, "/home/#{user}/#{application}"


# Source Code Details
set :github_username, 'ramlaxmanyadav'#set_git_user_name
set :github_password, 'lucky_4922'#set_git_password

set :repository, "https://github.com/ramlaxmanyadav/spotmyarena.git"
set :branch, set_branch

set :ruby_version, "#{File.readlines(File.join(__dir__, '..', '.ruby-version')).first.strip}"
set :gemset, "#{File.readlines(File.join(__dir__, '..', '.ruby-gemset')).first.strip}"

task :environment do
  set :rails_env, ENV['on'].to_sym unless ENV['on'].nil?
  require "#{File.join(__dir__, 'deploy', "#{rails_env}_configurations_files", "#{rails_env}.rb")}"
  invoke :"rvm:use[#{ruby_version}@#{gemset}]"
end

# SSL certificates path
set :ssl_enabled, true
set :cert_path, "#{deploy_to}/current/ssl-certs/#{rails_env}/SSL.crt"
set :cert_key_path, "#{deploy_to}/current/ssl-certs/#{rails_env}/YOUR_KEY_NAME"

# For system-wide RVM install.
#   set :rvm_path, '/usr/local/rvm/bin/rvm'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log', 'config/unicorn.rb']


# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.

task :setup => :environment do
  invoke :set_sudo_password
  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/log"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/config"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config"]

  queue! %[mkdir -p "#{deploy_to}/#{shared_path}/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/tmp/pids"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue! %[touch "#{deploy_to}/#{shared_path}/config/unicorn.rb"]
  invoke :setup_prerequesties
  invoke :setup_yml
  queue %[echo "-----> Be sure to edit 'shared/config/*.yml files'."]

end

task :setup_prerequesties => :environment do
  queue! %[sudo -A apt-get install mysql-server mysql-client git-core libmysqlclient-dev nodejs nginx imagemagick libmagickcore-dev libmagickwand-dev]
  queue! %[mkdir "#{deploy_to}"]
  queue! %[chown -R "#{user}" "#{deploy_to}"]
  queue! %[source "#{rvm_path}"]
  queue! %[rvm install "#{ruby_version}"]
  invoke :"rvm:use[#{ruby_version}@#{gemset}]"
  queue! %[gem install bundler]
  # #setup nginx
  invoke :'nginx:setup'
  # #set unicorn settings
  invoke :'unicorn:setup'
  invoke :'nginx:restart'
end

task :setup_yml => :environment do
  invoke :set_sudo_password
  Dir[File.join(__dir__, '*.example.yml')].each do |_path|
    queue! %[echo "#{erb _path}" > "#{File.join(deploy_to, 'shared/config', File.basename(_path, '.example.yml') +'.yml')}"]
  end
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  to :before_hook do
    # Put things to run locally before ssh
  end
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'check:revision'
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'mysql:create_database'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
  end
  invoke :restart
end

task :set_sudo_password => :environment do
  queue! "echo '#{erb(File.join(__dir__, 'deploy', "#{rails_env}_configurations_files", 'sudo_password.erb'))}' > /home/#{user}/SudoPass.sh"
  queue! "chmod +x /home/#{user}/SudoPass.sh"
  queue! "export SUDO_ASKPASS=/home/#{user}/SudoPass.sh"
end

desc 'Restart unicorn server'
task :restart => :environment do
  invoke :set_sudo_password
  queue! %[sudo -A service unicorn_#{application} stop]
  queue! %[sudo -A service nginx restart]
  queue! %[sudo -A service unicorn_#{application} start]
end