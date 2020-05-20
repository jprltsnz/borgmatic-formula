# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_file = tplroot ~ '.config.file' %}
{%- from tplroot ~ "/map.jinja" import borgmatic with context %}

include:
  - {{ sls_config_file }}

borgmatic-init-repos:
  cmd.wait:
    - name: "borgmatic init --encryption {{borgmatic.encryption}}"
    - shell: {{ borgmatic.shell }}
    - watch:
      - sls: {{ sls_config_file }}

borgmatic-service-running-service-running:
  service.running:
    - name: {{ borgmatic.service.name }}
    - enable: True
    - watch:
      - sls: {{ sls_config_file }}
