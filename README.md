#Riemann-health ansible role

[![Build Status](https://travis-ci.org/cortwave/riemann-health.svg?branch=master)](https://travis-ci.org/cortwave/riemann-health)

[Riemann](http://riemann.io) utility for node cpu/memory monitoring

Tested OS
--------------

- Debian 8
- Ubuntu 16.04
- Centos 7

Role Variables
--------------

`riemann_server_host` address of riemann server host

Dependencies
----------------

ruby ~>2.0

Example Playbook
----------------

    - hosts: servers
      roles:
         - { role: cortwave.riemann-health, 
             riemann_server_host: riemann-server-address.com }

License
-------

GPLv2
