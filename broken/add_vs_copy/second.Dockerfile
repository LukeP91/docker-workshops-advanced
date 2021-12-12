FROM busybox:1.24

COPY files.tar.gz /
RUN tar czvf files.tar.gz
