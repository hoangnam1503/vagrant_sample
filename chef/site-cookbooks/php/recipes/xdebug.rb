#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{php53u-pecl-xdebug}.each do |pkg|
    package pkg do
        action :install
    end
end

template "/etc/php.d/xdebug.ini" do
end