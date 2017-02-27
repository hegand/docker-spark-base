FROM hegand/hadoop-base:2.6

ENV SPARK_VERSION 1.6.3
ENV SPARK_MAJOR_VERSION 1.6
ENV SPARK_FULL_VERSION spark-${SPARK_VERSION}-bin-without-hadoop
ENV SPARK_HOME /usr/local/spark
ENV SPARK_CONF_DIR $SPARK_HOME/conf
ENV SPARK_DIST_CLASSPATH   ${HADOOP_HOME}/conf:${HADOOP_HOME}/share/hadoop/common/lib/*:${HADOOP_HOME}/share/hadoop/common/*:${HADOOP_HOME}/share/hadoop/hdfs:${HADOOP_HOME}/share/hadoop/hdfs/lib/*:${HADOOP_HOME}/share/hadoop/hdfs/*:${HADOOP_HOME}/share/hadoop/yarn/lib/*:${HADOOP_HOME}/share/hadoop/yarn/*:${HADOOP_HOME}/share/hadoop/mapreduce/lib/*:${HADOOP_HOME}/share/hadoop/mapreduce/*
ENV PATH $PATH:$SPARK_HOME/bin

RUN apk --update --no-cache add bash python libc6-compat

RUN adduser -D -s /bin/bash -u 1200 spark

RUN set -x && \
    mkdir -p /usr/local && \
    cd /tmp && \
    wget -q http://apache.claz.org/spark/spark-${SPARK_VERSION}/${SPARK_FULL_VERSION}.tgz -O - | tar -xz && \
    mv ${SPARK_FULL_VERSION} /usr/local && \
    ln -s /usr/local/${SPARK_FULL_VERSION} ${SPARK_HOME} && \
    rm -rf ${SPARK_HOME}/examples ${SPARK_HOME}/data ${SPARK_HOME}/ec2 ${SPARK_HOME}/lib/spark-examples*.jar && \
    chown -R spark:spark ${SPARK_HOME}/

WORKDIR ${SPARK_HOME}
