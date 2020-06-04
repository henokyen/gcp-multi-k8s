docker build -t henok2346/multi-client:latest -t henok2346/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t henok2346/multi-server:latest -t henok2346/multi-server:$GIT_SHA  -f ./server/Dockerfile ./server
docker build -t henok2346/multi-worker:latest -t henok2346/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push henok2346/multi-client:latest
docker push henok2346/multi-server:latest
docker push henok2346/multi-worker:latest

docker push henok2346/multi-client:$GIT_SHA
docker push henok2346/multi-server:$GIT_SHA
docker push henok2346/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployment/client-deployment client=henok2346/multi-client:$GIT_SHA
kubectl set image deployment/server-deployment server=henok2346/multi-server:$GIT_SHA
kubectl set image deployment/worker-deployment worker=henok2346/multi-worker:$GIT_SHA