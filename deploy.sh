docker build -t lkececi/multi-client-k8s:latest -t lkececi/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t lkececi/multi-server-k8s:latest -t lkececi/multi-server-k8s:$SHA -f ./server/Dockerfile ./server
docker build -t lkececi/multi-worker-k8s:latest -t lkececi/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push lkececi/multi-client-k8s:latest
docker push lkececi/multi-server-k8s:latest
docker push lkececi/multi-worker-k8s:latest

docker push lkececi/multi-client-k8s:$SHA
docker push lkececi/multi-server-k8s:$SHA
docker push lkececi/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lkececi/multi-client-k8s:$SHA
kubectl set image deployments/server-deployment server=lkececi/multi-server-k8s:$SHA
kubectl set image deployments/worker-deployment worker=lkececi/multi-worker-k8s:$SHA