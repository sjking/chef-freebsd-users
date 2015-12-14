def wyrun_supported?
  true
end

include Chef::Mixin::ShellOut
use_inline_resources

action :add do
  new_resource.groups.each do |groupmod|
    if member_in? groupmod
      Chef::Log.info "#{new_resource.user} already added to group #{groupmod} - skipping"
    else
      group groupmod do
        members new_resource.user
        append true
      end
      Chef::Log.info "#{new_resource.user} added to group #{groupmod}"
    end
  end
end

def member_in?(groupmod) 
  cmd = "groups #{new_resource.user}"
  users_groups = shell_out!(cmd).stdout.split(" ")
  users_groups.include? groupmod
end
