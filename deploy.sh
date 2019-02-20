docker build -t nikolakp/multi-client:latest -t nikolakp/multi-client:$SHA ./client/Dockerfile ./client
docker build -t nikolakp/multi-server:latest -t nikolakp/multi-server:$SHA ./server/Dockerfile ./server
docker build -t nikolakp/multi-worker:latest -t nikolakp/multi-worker:$SHA ./worker/Dockerfile ./worker

docker push nikolakp/multi-client:latest
docker push nikolakp/multi-server:latest
docker push nikolakp/multi-worker:latest

docker push nikolakp/multi-client:$SHA
docker push nikolakp/multi-server:$SHA
docker push nikolakp/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=nikolakp/multi-client:$SHA
kubectl set image deployments/server-deployment server=nikolakp/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nikolakp/multi-worker:$SHA