#!/usr/bin/env ruby

mpath = '.vagrant/machines'

if (ARGV[0])
  # Create the ssh cache file for a specific machine in the current vagrant directory.
  vagrants = [ARGV[0]]
else
  # Create the ssh cache files for all machines in the current vagrant directory.
  vagrants = %x(vagrant status | egrep '(active|running)').split(/\n/)
end

n = vagrants.count

puts "Caching vagrant ssh-config for #{n} machine(s)."

# TODO: Maintenance
# Dir.glob("#{mpath}/*/vssh").each { |file| File.delete(file)}

vagrants.each do |vagrant|
  vm = vagrant.split(' ')[0]
  next unless vm

  puts "Caching vagrant ssh-config for #{vm}"

  ssh_config = %x(vagrant ssh-config #{vm})
  next unless ssh_config
  
  user = ssh_config.lines.grep(/User/)[0].split(' ')[1]
  next unless user

  host = ssh_config.lines.grep(/HostName/)[0].split(' ')[1]
  next unless host

  port = ssh_config.lines.grep(/Port/)[0].split(' ')[1]
  next unless port

  iden = ssh_config.lines.grep(/IdentityFile/)[0].split(' ')[1]
  next unless iden
  
  vssh = "ssh #{user}@#{host} -p #{port} -i #{iden}"
  File.write("#{mpath}/#{vm}/vssh", vssh)
  File.chmod(0755, "#{mpath}/#{vm}/vssh")
end