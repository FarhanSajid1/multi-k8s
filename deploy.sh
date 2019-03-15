docker build -t farhansajid2/multi-client:latest -t farhansajid2/multi-client:$SHA  ./client
docker build -t farhansajid2/multi-server:latest -t farhansajid2/multi-server:$SHA ./server
docker build -t farhansajid2/multi-worker:latest -t farhansajid2/multi-worker:$SHA ./worker

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


