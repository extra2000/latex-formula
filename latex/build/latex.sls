# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import LATEX with context %}

latex-dir-present:
  file.directory:
    - name: /opt/latex
    - user: {{ LATEX.hostuser.name }}
    - group: {{ LATEX.hostuser.group }}

latex-dockerfile-present:
  file.managed:
    - name: /opt/latex/Dockerfile
    - source: salt://latex/files/Dockerfile.jinja
    - user: {{ LATEX.hostuser.name }}
    - group: {{ LATEX.hostuser.group }}
    - template: jinja

build-latex:
  cmd.run:
    - name: podman build -t {{ LATEX.image }} .
    - cwd: /opt/latex
    - runas: {{ LATEX.hostuser.name }}
