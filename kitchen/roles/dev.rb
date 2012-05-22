name "dev"
description "The dev role for all systems"
run_list ["recipe[build-essential]",	
	"recipe[apache2-1.0.0]",
	"recipe[build-essential-1.0.0]", 
	"recipe[fail2ban-1.0.0]",
	"recipe[git-0.9.0]",
	"recipe[imagemagick-0.2.0]",
	"recipe[iptables-0.9.3]",
	"recipe[logwatch-0.1.0]",
	"recipe[monit-0.6.0]",
	"recipe[munin-0.10.1]",
	"recipe[mysql-1.0.8]",
	"recipe[openssh-0.8.0]",
	"recipe[openssl-1.0.0]",
	"recipe[postfix-0.8.2]",
	"recipe[rvm-0.8.3]",
	"recipe[subversion-0.8.3]"]