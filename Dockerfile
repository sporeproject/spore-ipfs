FROM ipfs/kubo:v0.26.0          

COPY start.sh /start.sh
RUN chmod +x /start.sh


EXPOSE 4001 5001 8080 8081
VOLUME /data/ipfs

ENTRYPOINT ["/start.sh"]
