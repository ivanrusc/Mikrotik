/ppp profile
add change-tcp-mss=yes name=L2tp-Netflix only-one=yes use-encryption=yes

/interface l2tp-client
add add-default-route=yes allow=mschap2 connect-to=xxxx.sn.mynetname.net disabled=no keepalive-timeout=30 name=l2tp-to-hq profile=L2tp-Netflix use-ipsec=yes use-peer-dns=yes user=USUARI03 password=AquiUnaContrasenyaSegura

/ip firewall nat
add action=masquerade chain=srcnat comment="LAN -> Internet per WAN" out-interface-list=WAN
add action=masquerade chain=srcnat comment="LAN -> Internet per WAN" out-interface=l2tp-to-hq
/
