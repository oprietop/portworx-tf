#!/bin/bash
#set -x

export WORKDIR=/root/deploy
export KUBECONFIG=/root/admin.conf
export K8S_VERSION=$(kubectl version --short | grep Server | awk '{print $3}')

echo "Changing dir to '$WORKDIR'."
if [ -d "$WORKDIR" ]; then
    cd "$WORKDIR"
else
    echo "Failed!!"
    exit 1
fi

if [ -d "px" ]; then
    while true; do
        echo "Deploying ETCD."
        kubectl create -f etcd
        sleep 10
        echo "Waiting fo the ETCD service IP..."
        ETCD_IP=$(kubectl get svc etcd-cluster-client --template={{.spec.clusterIP}})
        [ "$?" -ne "0" ] && continue
        echo "Got: ${ETCD_IP}\n"
        [ "${ETCD_IP}" != "<no value>" ] && break
    done
fi

if [ -d "px" ]; then
    echo "Fetching px-spec."
    curl -o px/px-spec.yaml "http://install.portworx.com?cluster=mycluster&kvdb=etcd://$ETCD_IP:2379&drives=/dev/sdb&k8sVersion=$K8S_VERSION"
    
    echo "Deploying Portworx."
    kubectl create -f px
fi

if [ -d "extra" ]; then
    echo "Extra deployments..."
    kubectl create -f extra
fi
