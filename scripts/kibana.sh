!/bin/bash
NAMESPACES=(pix superdigital)
  for NAMESPACE in ${NAMESPACES[@]}; do
    DEPLOYMENTS=$(/usr/local/bin/kubectl get deploy -n $NAMESPACE --no-headers 2> /dev/null | awk '{print $1}')
    for DEPLOY in $DEPLOYMENTS; do
        LIMIT=$(/usr/local/bin/kubectl get deploy/$DEPLOY -n $NAMESPACE -o jsonpath="{..resources}")
        echo $DEPLOY,$LIMIT >> limits.txt        
        $HPA=$(/usr/local/bin/kubectl get hpa $DEPLOY -n $NAMESPACE -o jsonpath="{..spec},{..status}")
        echo $DEPLOY,$HPA >> hpa.txt
    done
  done


  DEPLOY=jdpi-spi-lancamento-worker   
  LIMIT=$(/usr/local/bin/kubectl get deploy/jdpi-spi-lancamento-worker -n pix -o jsonpath="{..resources.}")
  echo $DEPLOY $LIMIT

  pix  