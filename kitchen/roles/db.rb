name "db"
description "The base role for db servers"
run_list ["recipe[mysql::server]"]