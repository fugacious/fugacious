name "web"
description "The base role for web servers"
run_list ["recipe[mysql::server]"]