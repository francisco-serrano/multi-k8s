docker build -t franciscoserrano/multi-client:latest -t franciscoserrano/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t franciscoserrano/multi-server:latest -t franciscoserrano/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t franciscoserrano/multi-worker:latest -t franciscoserrano/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push franciscoserrano/multi-client:latest
docker push franciscoserrano/multi-server:latest
docker push franciscoserrano/multi-worker:latest

docker push franciscoserrano/multi-client:$SHA
docker push franciscoserrano/multi-server:$SHA
docker push franciscoserrano/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=franciscoserrano/multi-server:$SHA
kubectl set image deployments/client-deployment client=franciscoserrano/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=franciscoserrano/multi-worker:$SHA