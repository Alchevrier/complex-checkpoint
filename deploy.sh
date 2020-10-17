docker build -t alchevrier/complex-client:latest -t alchevrier/complex-client:$SHA -f ./client/Dockerfile ./client
docker build -t alchevrier/complex-server:latest -t alchevrier/complex-server:$SHA -f ./server/Dockerfile ./server
docker build -t alchevrier/complex-worker:latest -t alchevrier/complex-worker:$SHA -f ./worker/Dockerfile ./worker

docker push alchevrier/complex-client:latest
docker push alchevrier/complex-server:latest
docker push alchevrier/complex-worker:latest

docker push alchevrier/complex-client:$SHA 
docker push alchevrier/complex-server:$SHA 
docker push alchevrier/complex-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=alchevrier/complex-server:$SHA 
kubectl set image deployments/client-deployment client=alchevrier/complex-client:$SHA 
kubectl set image deployments/worker-deployment worker=alchevrier/complex-worker:$SHA 