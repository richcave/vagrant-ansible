#!/bin/bash
#
# iptables example configuration script
#
# Flush all current rules from iptables
#
 iptables -F
#
# Allow connections

 iptables -A INPUT -p tcp --dport 22 -j ACCEPT     # SSH
 iptables -A INPUT -p tcp --dport 25 -j ACCEPT     # SMTP
 iptables -A INPUT -p tcp --dport 53 -j ACCEPT     # DNS
 iptables -A INPUT -p udp --dport 53 -j ACCEPT     # DNS
 iptables -A INPUT -p tcp --dport 80 -j ACCEPT     # Apache
 iptables -A INPUT -p tcp --dport 110 -j ACCEPT    # POP3
 iptables -A INPUT -p udp --dport 123 -j ACCEPT    # Network Time Protocol
 iptables -A INPUT -p tcp --dport 143 -j ACCEPT    # IMAP
 iptables -A INPUT -p tcp --dport 389 -j ACCEPT    # LDAP
 iptables -A INPUT -p tcp --dport 443 -j ACCEPT    # Apache 
 iptables -A INPUT -p tcp --dport 636 -j ACCEPT    # LDAPS
 iptables -A INPUT -p tcp --dport 993 -j ACCEPT    # IMAPS
 iptables -A INPUT -p tcp --dport 995 -j ACCEPT    # POP3S
 iptables -A INPUT -p tcp --dport 3306 -j ACCEPT   # MySQL
 iptables -A INPUT -p tcp --dport 5027 -j ACCEPT   # Pylons
	  
#
# Set default policies for INPUT, FORWARD and OUTPUT chains
#
 iptables -P INPUT DROP
 iptables -P FORWARD DROP
 iptables -P OUTPUT ACCEPT
#
# Set access for localhost
#
 iptables -A INPUT -i lo -j ACCEPT
#
# Accept packets belonging to established and related connections
#
 iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#
# Save settings
#
 /sbin/service iptables save