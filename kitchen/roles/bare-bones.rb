name "bare-bones"
description "The base role for all systems"
run_list ["recipe[sudo]", "recipe[main]", "recipe[cron]", "recipe[firewall]", "recipe[build-essential]", "recipe[fail2ban]", "recipe[git]", "recipe[subversion]", "recipe[rvm::system]", "recipe[rvm::gem_package]",  "recipe[zsh]"]
