FROM paperist/alpine-texlive-ja

RUN apk --update add gnupg curl
RUN tlmgr update --self --all
RUN tlmgr install dirtree
