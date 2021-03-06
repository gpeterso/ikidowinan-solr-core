FROM openjdk:8

ENV SOLR_VERSION 4.10.4
ENV SOLR solr-$SOLR_VERSION

RUN curl --retry 3 http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$SOLR.tgz | tar -C /opt --extract --gzip
RUN mv /opt/$SOLR /opt/solr

RUN useradd --home-dir /opt/solr --comment "Solr Server" solr

ENV SOLR_DIR /opt/solr/example
ENV CONF_DIR $SOLR_DIR/solr/ikidowinan
WORKDIR $CONF_DIR
COPY . .
RUN chown -R solr:solr /opt/solr

USER solr

EXPOSE 8983

WORKDIR $SOLR_DIR
CMD ["java", "-jar", "start.jar"]