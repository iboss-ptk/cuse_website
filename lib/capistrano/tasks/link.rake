desc "link .env and uploads to current release"
task :link_env do
	on roles(:all) do |host|
		if test("ln -nfs #{fetch(:deploy_to)}shared/.env #{fetch(:deploy_to)}current/.env")
			info "linked #{fetch(:deploy_to)}shared/.env to #{fetch(:deploy_to)}current/.env"
		else
			error "linking unsuccessful"
		end
	end 
end

desc "link themes and uploads to current release"
task :link_themes do
	on roles(:all) do |host|
		if test("ln -nfs #{fetch(:deploy_to)}shared/themes #{fetch(:deploy_to)}current/web/app/themes")
			info "linked #{fetch(:deploy_to)}shared/themes to #{fetch(:deploy_to)}current/web/app/themes"
		else
			error "linking unsuccessful"
		end
	end 
end

# desc "composer install"
# task :composer_install do
# 	on roles(:all) do |host|
# 		within '#{fetch(:deploy_to)}/current' { execute(:composer, :install) }
# 	end 
# end

# desc "composer install"
# task :compose_update do
# 	on roles(:all) do |host|
# 		within '#{fetch(:deploy_to)}/current' { execute(:composer, :install) }
# 	end 
# end

desc "setup environment"
task :set_env do
	on roles(:all) do |host|
		invoke "link_env"
		invoke "link_themes"
	end 
end