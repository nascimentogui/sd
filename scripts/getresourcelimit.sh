#!/bin/bash

CURRENT_TIME=$(date "+%Y.%m.%d-%H.%M.%S")
NAMESPACES=(pix superdigital)
  for NAMESPACE in ${NAMESPACES[@]}; do
    DEPLOYMENTS=$(kubectl get deploy -n $NAMESPACE --no-headers 2> /dev/null | awk '{print $1}')
    for DEPLOY in $DEPLOYMENTS; do
        LIMIT=$(kubectl get deploy/$DEPLOY -n $NAMESPACE -o jsonpath="{..resources.limits}")
        if [ -z "$LIMIT" ]; then
        kubectl top pod -n $NAMESPACE -l app=$DEPLOY --no-headers >> $CURRENT_TIME.txt
        #else
      fi
    done
  done