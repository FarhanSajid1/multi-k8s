docker build -t farhansajid2/multi-client:latest -t farhansajid2/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t farhansajid2/multi-server:latest -t farhansajid2/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t farhansajid2/multi-worker:latest -t farhansajid2/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push farhansajid2/multi-client:latest
docker push farhansajid2/multi-client:$SHA

docker push farhansajid2/multi-server:latest
docker push farhansajid2/multi-server:$SHA

docker push farhansajid2/multi-worker:latest
docker push farhansajid2/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=farhansajid2/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=farhansajid2/multi-worker:$SHA
kubectl set image deployments/client-deployment client=farhansajid2/multi-client:$SHA

