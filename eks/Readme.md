## what i need as variables for workspace and tfvars

....VPC....
vpc_name +env
cidr
private_subnets
public_subnets

...eks....
instance_types_general
instance_types_spot
desired_size
min_size
max_size
Environment
disk_size

...IAM...
for all names +$Environment (roles+policyes+users+groups)

...



aws iam get-role --profile am-devops1 --role-name eks-admin

aws sts assume-role --role-arn arn:aws:iam::819401076850:role/eks-admin --role-session-name manager-session --profile manager 
# eks-terraform-pro

# show configmap 
kubectl edit -n kube-system configmap/aws-auth

# change the user

aws eks --region us-east-1 update-kubeconfig --name my-eks
# show config
kubectl config view --minify 

# test
kubectl auth can-i get pods 
kubectl auth can-i create pods

# create quick pods
kubectl run nginx --image nginx

## patch svc type (for argocd // i could change it directely in terraform)//
kubectl patch svc argo-cd-argocd-argocd-server -n argocd --type='json' -p '[{"op":"replace","path":"/spec/type","value":"ClusterIP"}]'

## get password argocdc 

kubectl get secrets n argocd
kub get secrets -n argocd ------ -o yaml 

## port forawrd svc
kubectl -n monitoring port-forward service/prometheus-k8s 9090:9090

## decode base64 secret
echo Z0JqT2xIOXUyZDkzT0kwSw== |base64 --decode

***********************