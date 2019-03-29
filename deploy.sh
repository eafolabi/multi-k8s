docker build -t eafolabi/multi-client:latest -t eafolabi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t eafolabi/multi-server:latest -t eafolabi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t eafolabi/multi-worker:latest -t eafolabi/multi-worker:$SHA -f ./worker/Dockerfile ./worker


docker push eafolabi/multi-client:latest
docker push eafolabi/multi-worker:latest
docker push eafolabi/multi-server:latest


docker push eafolabi/multi-client:$SHA
docker push eafolabi/multi-worker:$SHA
docker push eafolabi/multi-server:$SHA

kubectl apply -f k8s-multi

kubectl set image deployments/server-deployment server=eafolabi/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=eafolabi/multi-worker:$SHA
kubectl set image deployments/client-deployment client=eafolabi/multi-client:$SHA