![travis ci](https://travis-ci.org/cortwave/riemann-health.svg?branch=master)

Riemann-health ansible role
=========

[Riemann](http://riemann.io) utility for node cpu/memory monitoring

Role Variables
--------------

`riemann_server_host` address of riemann server host

Dependencies
----------------

ruby ~>2.0

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: servers
      roles:
         - { role: cortwave.riemann-health, 
             riemann_server_host: riemann-server-address.com }

License
-------

GPLv2
