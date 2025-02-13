docker build -t klima77/multi-client:latest -t klima77/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t klima77/multi-server:latest -t klima77/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t klima77/multi-worker:latest -t klima77/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push klima77/multi-client:latest
docker push klima77/multi-server:latest
docker push klima77/multi-worker:latest

docker push klima77/multi-client:$SHA
docker push klima77/multi-server:$SHA
docker push klima77/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=klima77/multi-server:$SHA
kubectl set image deployments/client-deployment client=klima77/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=klima77/multi-worker:$SHA
