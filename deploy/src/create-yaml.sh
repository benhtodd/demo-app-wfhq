#! /bin/zsh

### 
## Applies the yaml files
### 
source values.sh

echo "   namespace: " $K8S_NAMESPACE
echo " application: " $K8S_APPLICATION
echo "     cluster: " $K8S_CLUSTER
echo "    location: " $K8S_LOCATION
echo "  repository: " $K8S_REPOSITORY
echo "   wavefront: " $WF_PROXY_HOST

for f in *.yaml ; do
	echo "creating ../$f"
	envsubst < $f > ../$f
done

if [ ! -d "../namespace/" ]
then 
	mkdir ../namespace
fi
for f in namespace/* ; do
	echo "creating ../$f"
	envsubst < $f > ../$f
done

if [ ! -d "../services/" ]
then 
	mkdir ../services
fi
for f in services/* ; do
	if 
	echo "creating ../$f"
	envsubst < $f > ../$f
done

if [ ! -d "../data/" ]
then 
	mkdir ../data
fi
for f in data/*.yaml ; do
	if [ -f $f ]; then
		echo "creating ../$f"
		envsubst < $f > ../$f
	fi
done

if [ -f data/inventory.conf ]; then
	echo "creating ../data/inventory.conf"
	envsubst < data/inventory.conf > ../data/inventory.conf
fi


#echo "create ../../payments/src/Payments/applicationTags.yaml"
#envsubst < apptags/applicationTags.yaml > ../../payments/src/Payments/applicationTags.yaml
