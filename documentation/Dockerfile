FROM scratch

USER 1000

COPY site /site
COPY target/x86_64-unknown-linux-musl/release/doc /

CMD [ "/documentation" ]
