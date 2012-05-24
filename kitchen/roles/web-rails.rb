name "web-rails"
description "The base role for rails web servers"
run_list ["recipe[rvm_passenger]", "recipe[rvm_passenger::apache2]"]
