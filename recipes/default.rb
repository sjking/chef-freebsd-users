#
# Cookbook Name:: chef-freebsd-users
# Recipe:: default
#
# The MIT License (MIT)
# 
# Copyright (c) 2015 Steve King
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

users = data_bag(node['chef_freebsd_users']['data_bag-dir'])

users.each do |login|
  user = data_bag_item('users', login)

  user login do
    comment user['comment']
    home user['home']
    shell user['shell']
    password user['password']
  end

  directory 'create-home-directory' do
    path "#{user['home']}"
    owner user['id']
    group user['id']
    mode '0755'
  end

  directory 'create-ssh-directory' do
    path "#{user['home']}/.ssh"
    owner user['id']
    group user['id']
    mode '0700'
  end

  file 'create-authorized-keys-file' do
    content user['ssh_keys'].join("\n")
    path "#{user['home']}/.ssh/authorized_keys"
    mode '0600'
    owner user['id']
    group user['id']
  end

  chef_freebsd_users_groupmod 'add-user-to-groups' do
    user user['id']
    groups user['groups']
  end
end
