#COLETA OS REQUESTS/LIMITS DOS DEPLOYS
#!/bin/bash

CURRENT_TIME=$(date "+%Y.%m.%d-%H.%M.%S")
NAMESPACES=(pix superdigital)
  for NAMESPACE in ${NAMESPACES[@]}; do
    DEPLOYMENTS=$(/usr/local/bin/kubectl get deploy -n $NAMESPACE --no-headers 2> /dev/null | awk '{print $1}')
    for DEPLOY in $DEPLOYMENTS; do
        REQUEST=$(/usr/local/bin/kubectl get deploy/$DEPLOY -n $NAMESPACE -o jsonpath="{..resources.requests}")
        LIMIT=$(/usr/local/bin/kubectl get deploy/$DEPLOY -n $NAMESPACE -o jsonpath="{..resources.limits}")
        echo $NAMESPACE,$DEPLOY,$REQUEST,$LIMIT >> extract_limits.txt
    done
  done




#VERIFICA SE O HPA É DE MEMORIA OU CPU, OU AMBOS, COM BASE NO ANNOTATION
  #!/bin/bash
NAMESPACES=(pix superdigital)
  for NAMESPACE in ${NAMESPACES[@]}; do
    DEPLOYMENTS=$(/usr/local/bin/kubectl get deploy -n $NAMESPACE --no-headers 2> /dev/null | awk '{print $1}')
    for DEPLOY in $DEPLOYMENTS; do
        HPA_EXISTS=$(kubectl get hpa -n "$NAMESPACE" | grep -w "$DEPLOY" | wc -l)
        if [ "$HPA_EXISTS" -eq "0" ]; then
        echo $NAMESPACE,$DEPLOY, SEM HPA >> tipo_hpa.txt
        else
        METRIC=$(kubectl get hpa "$DEPLOY" -n "$NAMESPACE" -o jsonpath='{.metadata.annotations.autoscaling\.alpha\.kubernetes\.io/current-metrics}')

        TIPO=$(echo $METRIC | grep -o '"name":"memory"')
             
        echo $NAMESPACE,$DEPLOY,$TIPO >> tipo_hpa.txt
        fi
    done
  done





kubectl get hpa token-v2 -n superdigital -o jsonpath='{.metadata.annotations.autoscaling\.alpha\.kubernetes\.io/current-metrics}'


    if [ "$HPA_EXISTS" -eq "0" ]; then

        echo "$NAMESPACE,$DEPLOYMENT SEM HPA"

    else

  kubectl get hpa token-v2 -n superdigital -o jsonpath="{.metadata.annotations.autoscaling.alpha.kubernetes.io/current-metrics}"