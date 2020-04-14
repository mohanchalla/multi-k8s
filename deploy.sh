docker build -t krishnachalla/multi-client:latest -t krishnachalla/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t krishnachalla/multi-server:latest -t krishnachalla/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t krishnachalla/multi-worker:latest -t krishnachalla/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker
docker push krishnachalla/multi-client:latest
docker push krishnachalla/multi-server:latest
docker push krishnachalla/multi-worker:latest

docker push krishnachalla/multi-client:$GIT_SHA
docker push krishnachalla/multi-server:$GIT_SHA
docker push krishnachalla/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=krishnachalla/multi-client:$GIT_SHA
kubectl set image deployments/server-deployment server=krishnachalla/multi-server:$GIT_SHA
kubectl set image deployments/worker-deployment worker=krishnachalla/multi-worker:$GIT_SHA