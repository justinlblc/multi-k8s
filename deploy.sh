#series of command to build, tag and push images, among with applying configs. 
docker build -t justlblc445/multi-client:latest -t justlblc445/multi-client:$SHA -f ./client/Dockerfile.dev ./client
docker build -t justlblc445/multi-server:latest -t justlblc445/multi-server:$SHA -f ./server/Dockerfile.dev ./server
docker build -t justlblc445/multi-worker:latest -t justlblc445/multi-worker:$SHA -f ./worker/Dockerfile.dev ./worker

#Pushing images
docker push justlblc445/multi-client:latest
docker push justlblc445/multi-server:latest
docker push justlblc445/multi-worker:latest

docker push justlblc445/multi-client:$SHA
docker push justlblc445/multi-server:$SHA
docker push justlblc445/multi-worker:$SHA

#Applying configs
kubectl apply -f k8s

#Imperatively set latest images on each deployments
kubectl set image deployments/server-deployment server=justlblc445/multi-server:$SHA
kubectl set image deployments/client-deployment client=justlblc445/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=justlblc445/multi-worker:$SHA
