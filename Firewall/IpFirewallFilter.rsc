/ip firewall filter
add action=accept chain=input connection-state=established,related
add action=drop chain=input connection-state=invalid
add action=accept chain=input comment="Gestio des de LAN" in-interface-list=LAN
add action=accept chain=input protocol=icmp
add action=accept chain=input comment="acces ssh winbox" dst-port=22,8291 protocol=tcp src-address=192.168.0.0/16
add action=accept chain=input comment="acces ssh winbox" dst-port=22,8291 protocol=tcp src-address=172.16.45.0/24
add action=drop chain=input comment="Drop resta"
add action=fasttrack-connection chain=forward connection-state=established,related hw-offload=yes
add action=accept chain=forward connection-state=established,related
add action=drop chain=forward connection-state=invalid
add action=accept chain=forward comment="LAN -> Internet" in-interface-list=LAN out-interface-list=WAN
add action=accept chain=forward comment="LAN -> VPN" in-interface-list=LAN out-interface=l2tp-to-hq
add action=drop chain=forward comment="Drop resta"
