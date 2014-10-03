# create database
db_name = 'mpstr'
execute "createdb" do
  command "/usr/bin/mysql -u root < #{Chef::Config[:file_cache_path]}/createdb.sql"
  action :nothing
  not_if "/usr/bin/mysql -u root -D #{db_name}"
end

template "#{Chef::Config[:file_cache_path]}/createdb.sql" do
  owner 'root'
  group 'root'
  mode 644
  source 'createdb.sql.erb'
  variables({
    :db_name => db_name,
    })
  notifies :run, 'execute[createdb]', :immediately
end

# create database user
user_name = 'root'
user_password = 'allied55'
execute 'createuser' do
  command "/usr/bin/mysql -u root < #{Chef::Config[:file_cache_path]}/createuser.sql"
  action :nothing
  not_if "/usr/bin/mysql -u #{user_name} -p#{user_password} -D #{db_name}"
end

template "#{Chef::Config[:file_cache_path]}/createuser.sql" do
  owner 'root'
  group 'root'
  mode 644
  source 'createuser.sql.erb'
  variables({
      :db_name => db_name,
      :username => user_name,
      :password => user_password,
    })
  notifies :run, 'execute[createuser]', :immediately
end

# create schema
schema_file = 'create_schema_mpstr.sql'
execute "create_schema_mpstr" do
  command "/usr/bin/mysql -u root -p#{user_password} -D #{db_name} < #{Chef::Config[:file_cache_path]}/create_schema_mpstr.sql"
  action :nothing
  not_if "/usr/bin/mysql -u #{user_name} -p#{user_password} -D #{db_name}  -e 'show tables' | wc -l | xargs expr 1 /"
end

template "#{Chef::Config[:file_cache_path]}/create_schema_mpstr.sql" do
  owner 'root'
  group 'root'
  mode 644
  source 'create_schema_mpstr.sql.erb'
  notifies :run, 'execute[create_schema_mpstr]', :immediately
end
