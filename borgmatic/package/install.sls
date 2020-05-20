# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import borgmatic with context %}

borgmatic-package-install-pkg-installed:
  pkg.installed:
    - pkgs:
        - {{ borgmatic.pkg.borg }}
        - {{ borgmatic.pkg.borgmatic }}
