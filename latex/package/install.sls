# -*- coding: utf-8 -*-
# vim: ft=sls

{% set user = pillar['latex']['hostuser']['name'] %}
{% set group = pillar['latex']['hostuser']['group'] %}

latex-dir-present:
  file.directory:
    - name: /opt/latex
    - user: {{ user }}
    - group: {{ group }}

latex-dockerfile-present:
  file.managed:
    - name: /opt/latex/Dockerfile
    - source: salt://latex/files/Dockerfile.jinja
    - user: {{ user }}
    - group: {{ group }}
    - template: jinja

install-latex:
  cmd.run:
    - name: podman build -t extra2000/latex .
    - cwd: /opt/latex
    - runas: {{ user }}
