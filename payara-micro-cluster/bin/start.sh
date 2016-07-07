#!/bin/bash

PORT=${PORT:-8080}
GC_PERIOD=${GC_PERIOD:-300}
GC_DEBUG=${GC_DEBUG:-0}
HAZELCAST_CONFIG="$HOME/config/hazelcast.xml";

sed -i "s@GROUPNAME@${HAZELCAST_GROUP}@g" $HAZELCAST_CONFIG;
sed -i "s@PASSWORD@${HAZELCAST_PASSWORD}@g" $HAZELCAST_CONFIG;

source $HOME/bin/memoryConfig.sh

[ "$VERT_SCALING" != "false" -a "$VERT_SCALING" != "0" ] && JAVA_OPTS="$JAVA_OPTS -javaagent:$HOME/lib/jelastic-gc-agent.jar=period=$GC_PERIOD,debug=$GC_DEBUG"

java $JAVA_OPTS -jar $HOME/payara-micro.jar --port $PORT --deploymentDir $HOME/deployments --hzConfigFile $HOME/config/hazelcast.xml 

