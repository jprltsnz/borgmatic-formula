# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import borgmatic with context %}

include:
  - {{ sls_config_clean }}

borgmatic-package-clean-pkg-removed:
  pkg.removed:
    - pkgs:
        - {{ borgmatic.pkg.borg }}
        - {{ borgmatic.pkg.borgmatic }}
    - require:
      - sls: {{ sls_config_clean }}
