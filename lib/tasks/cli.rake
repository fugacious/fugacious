namespace :cli do
  desc 'Symlink fugu to /usr/local/bin (or override with FUGU_PATH)'
  task :symlink do |t, args|
    path = ENV['FUGU_PATH'] || '/usr/local/bin'
    cmd = "/bin/ln -nfs #{Dir.pwd}/bin/fugu #{path}"

    if ENV['USE_SUDO']
      exec('/usr/bin/sudo ' + cmd)
    else
      exec(cmd)
    end

    puts 'Done...'
  end
end
