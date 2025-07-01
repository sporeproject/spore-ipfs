FROM ipfs/go-ipfs:v0.24.0

EXPOSE 4001 5001 8080
VOLUME /data/ipfs

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENTRYPOINT ["/start.sh"]

