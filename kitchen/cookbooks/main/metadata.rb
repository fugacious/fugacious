maintainer        "jgrevich"
maintainer_email  "jgrevich@gmail.com"
license           "Apache 2.0"
description       ""
version           "0.0.1"
recipe            "main", "install/setup items outside normal recipes"

%w{ fedora redhat centos ubuntu debian }.each do |os|
  supports os
end
