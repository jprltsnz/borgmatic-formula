# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import borgmatic with context %}



{% if borgmatic.use_pip %}

borgmatic-ensure-pip-and-reqs:
  pkg.installed:
    - pkgs: {{ borgmatic.pkg.pip_reqs|json }}

borgmatic-package-install-pip-pkg-installed:
  pip.installed:
    - name: borgmatic

{% else %}

borgmatic-package-install-pkg-installed:
  pkg.installed:
    - pkgs:
        - {{ borgmatic.pkg.borg }}
        - {{ borgmatic.pkg.borgmatic }}

{% endif %}
