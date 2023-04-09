#! /bin/bash
DB_POD=$(kubectl get pods -A -o=custom-columns=NAME:.metadata.name | grep 'mongodb' | grep -v 'backup') \
&& kubectl exec "${DB_POD}" -it  -n mongodb -- /bin/bash \
-c 'mongo "mongodb://root:${MONGODB_ROOT_PASSWORD}@mongodb.mongodb.svc.cluster.local:10000/pc-on-premises" --authenticationDatabase admin --eval "db.users.updateMany({status:3},{\$set:{status:1}})"'


curl http://`cat $PINGCODE_HOME/conf/index.json|grep base_host |awk -F \" '{print $4}'`/api/typhon/team |awk -F \" '{print $8}'

#获取team_id 
TEAM_ID=$(curl -s  http://`cat $PINGCODE_HOME/conf/index.json|grep base_host |awk -F \" '{print $4}'`/api/typhon/team |awk -F \" '{print $8}')

#获取minio 账号密码

MINIO_ACCESS_KEY=`cat $PINGCODE_HOME/conf/index.json|grep access_key|awk -F \" '{print $4}'`
MINIO_SECRET_KEY=`cat $PINGCODE_HOME/conf/index.json|grep secret_key|awk -F \" '{print $4}'`

#获取minio当前状态
docker stats  `docker ps |grep minio |grep -v POD |awk  '{print $1}'` --no-stream

#k8s cgroup kmem的内存泄露问题（有输出即为内存泄露）：
cat /sys/fs/cgroup/memory/kubepods/memory.kmem.slabinfo


docker run --name svn -d -v /Users/yanmi/dockers/svn:/var/svn -p 3690:3690 -p 8800:80 garethflowers/svn-server



docker run -d -p 3343:3343 -p 4434:4434 -p 18080:18080 -v /Users/yanmi/dockers/svn:/opt/csvn/data --name svn-server mamohr/subversion-edge

