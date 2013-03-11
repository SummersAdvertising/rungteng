
set :application, "rungteng"
set :domain, 	  "summers.com.tw"
set :repository,  "git@github.com:HanaHsu/rungteng.git"
set :deploy_to,   "/home/deploy/rungteng"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true 	   # This is where Rails migrations will run

set :deploy_via, :remote_cache
set :deploy_env, "production"
set :rails_env, "production"
set :scm, :git
set :branch, "master"
set :scm_verbose, true
set :use_sudo, false

set :user, "deploy"
set :password, "1qaz2wsx"

default_environment["PATH"] = "/opt/ree/bin:/usr/local/bin:/usr/bin:/bin:/usr/games"

namespace :deploy do
	desc "restart"
	task :restart do
		run "ln -s  #{shared_path}/uploads/ #{current_path}/public/uploads"		
		run "cd #{current_path}; RAILS_ENV=production bundle exec rake db:migrate;rake cache:clear"
	end
end

before("deploy:finalize_update") do
	db_config = "#{shared_path}/config/database.yml.production"
	run "cp #{db_config} #{release_path}/config/database.yml"	
end

