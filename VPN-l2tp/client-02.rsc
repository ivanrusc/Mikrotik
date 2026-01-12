/interface bridge
add name=bridge-local
/interface list
add name=WAN
add name=LAN
/ip pool
add name=dhcp_pool0 ranges=192.168.99.2-192.168.99.254
/ip dhcp-server
add address-pool=dhcp_pool0 interface=bridge-local lease-time=1d30m name=dhcp1
/ppp profile
add change-tcp-mss=yes name=L2tp-Netflix only-one=yes use-encryption=yes
/interface l2tp-client
add add-default-route=yes allow=mschap2 connect-to=xxxxxxxxxxxx.sn.mynetname.net disabled=no keepalive-timeout=30 name=l2tp-to-hq profile=L2tp-Netflix use-ipsec=yes use-peer-dns=yes user=USUARI01 password=AquiUnaContrasenyaSegura
/interface bridge port
add bridge=bridge-local interface=ether2
add bridge=bridge-local interface=ether3
add bridge=bridge-local interface=ether4
add bridge=bridge-local interface=ether5
/interface list member
add interface=ether1 list=WAN
add interface=bridge-local list=LAN
/ip address
add address=192.168.99.1/24 interface=bridge-local network=192.168.99.0
/ip dhcp-client
add default-route-distance=5 interface=ether1
/ip dhcp-server network
add address=192.168.99.0/24 dns-server=8.8.8.8 gateway=192.168.99.1
/ip dns
set servers=1.1.1.1,8.8.8.8
/ip firewall filter
add action=accept chain=input connection-state=established,related
add action=drop chain=input connection-state=invalid
add action=accept chain=input comment="Gestio des de LAN" in-interface-list=LAN
add action=accept chain=input protocol=icmp
add action=accept chain=input comment="acces ssh winbox" dst-port=22,8291 protocol=tcp src-address=192.168.0.0/16
add action=drop chain=input comment="Drop resta"
add action=fasttrack-connection chain=forward connection-state=established,related hw-offload=yes
add action=accept chain=forward connection-state=established,related
add action=drop chain=forward connection-state=invalid
add action=accept chain=forward comment="LAN -> Internet" in-interface-list=LAN out-interface-list=WAN
add action=accept chain=forward comment="LAN -> VPN" in-interface-list=LAN out-interface=l2tp-to-hq
add action=drop chain=forward comment="Drop resta"
/ip firewall nat
add action=masquerade chain=srcnat comment="LAN -> Internet per WAN" out-interface-list=WAN
add action=masquerade chain=srcnat comment="LAN -> Internet per WAN" out-interface=l2tp-to-hq
/system clock
set time-zone-name=Europe/Madrid
/system identity
set name=Router_02
/system note
set show-at-login=no
/
