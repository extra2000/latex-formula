# -*- coding: utf-8 -*-
# vim: ft=sls

latex-dir-present:
  file.directory:
    - name: /opt/latex

latex-dockerfile-present:
  file.managed:
    - name: /opt/latex/Dockerfile
    - source: salt://latex/files/Dockerfile.jinja
    - template: jinja

install-latex:
  cmd.run:
    - name: sudo sh -c "ulimit -n 524288 && exec su {{ pillar['latex']['user'] }} -c 'podman build --ulimit nofile=1024:524288 -t extra2000/latex .'"
    - cwd: /opt/latex
    - runas: {{ pillar['latex']['user'] }}
