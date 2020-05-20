# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import borgmatic with context %}
{%- from tplroot ~ "/map.jinja" import appconfigs with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}


borgmatic-config-service-file-managed:
  file.managed:
    - name: {{ borgmatic.config.service }}
    - source: {{ files_switch(['borgmatic.service.jinja'],
                              lookup='borgmatic-service'
                 )
              }}
    - mode: 755
    - user: root
    - group: {{ borgmatic.rootgroup }}
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        borgmatic: {{ borgmatic | json }}

borgmatic-config-timer-file-managed:
  file.managed:
    - name: {{ borgmatic.config.timer }}
    - source: {{ files_switch(['borgmatic.timer.jinja'],
                              lookup='borgmatic-timer'
                 )
              }}
    - mode: 755
    - user: root
    - group: {{ borgmatic.rootgroup }}
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        borgmatic: {{ borgmatic | json }}

{% for name, config in appconfigs.items() %}
borgmatic-config-{{ name }}-file-managed:
  file.managed:
    - name: {{ borgmatic.config.base_dir }}/{{ name }}.yaml
    - source: {{ files_switch(['borgmatic_app_config.jinja'],
                              lookup='borgmatic-config'
                 )
              }}
    - mode: 600
    - dir_mode: 600
    - user: root
    - group: {{ borgmatic.rootgroup }}
    - makedirs: True
    - template: jinja
    - require:
      - sls: {{ sls_package_install }}
    - context:
        config: {{ config | json }}
{% endfor %}
