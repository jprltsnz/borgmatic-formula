# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import borgmatic with context %}

borgmatic-service-clean-service-dead:
  service.dead:
    - name: {{ borgmatic.service.name }}
    - enable: False
