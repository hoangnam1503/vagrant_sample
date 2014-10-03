#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w[
php php-common php-mbstring php-xml php-devel php-process php-cli php-pear php-mysql mysql-server
].each do |pkg|
    package "#{pkg}" do
        action :install
    end
end