variable "argocd_values" {
  type    = string
  default = <<-EOF
    server:
      ingress:
        enabled: true
        ingressClassName: nginx
        annotations:
          cert-manager.io/cluster-issuer: letsencrypt-production  
        hosts:
          - argocd.am-devops.com
        tls:
          - secretName: argocd-tls
            hosts:
              - argocd.am-devops.com  

    EOF
}

resource "random_password" "argocd_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "kubernetes_secret" "argocd_password" {
  metadata {
    name = "argocd-password"
  }

  data = {
    ARGOCD_PASSWORD = base64encode(random_password.argocd_password.result)
  }

  depends_on = [random_password.argocd_password]
}

resource "helm_release" "argocd" {

  name       = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  create_namespace = true
  version    = "5.46.7"
  namespace  = "argocd"

  set {
    name  = "server.service.type"
    value = "ClusterIP"
  }

  set {
    name  = "server.configEnabled"
    value = "true"
  }

  set {
    name  = "server.name"
    value = "argocd-server"
  }

  set {
    name  = "controller.args.appResyncPeriod"
    value = "30"
  }

  set {
    name  = "controller.args.repoServerTimeoutSeconds"
    value = "15"
  }

    # set {
    #     name = "ingress.enabled" ## what i nedd is argicd ingress+metrics
    #     value = true
    # }
    #  set {
    #     name = "ingress.ClassName"
    #     value = "nginx"
    # }

    #  set {
    #     name = "ingress.enabled"
    #     value = true

 values = [var.argocd_values]

 depends_on = [helm_release.nginx_ingress, kubernetes_secret.argocd_password]
  # depends_on = [kubernetes_secret.argocd_password]

}
# provider "kubectl" {
#   host                   = data.aws_eks_cluster.default.endpoint
#   cluster_ca_certificate = base64decode(data.aws_eks_cluster.default.certificate_authority[0].data)
#   load_config_file       = false

#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.default.id]
#     command     = "aws"
#   }
# }

# resource "kubectl_manifest" "application" {
#   yaml_body = <<-EOF
# ---
# apiVersion: argoproj.io/v1alpha1
# kind: Application
# metadata:
#   name: argo-test-app
#   namespace: argocd
# spec:
#      project: default
#      source:
#        repoURL: https://github.com/am-devops09/argocd.git
#        targetRevision: HEAD  ## choice of branche // can i do ${var.Environment}
#        path: k8s
#        directory:
#          recurse: true
#      destination:
#        server: https://kubernetes.default.svc
#        namespaces: default
#      syncPolicy:
#           syncOptions:
#           - CreateNamespace=true
#           automated:
#             prune: true
#             selfHeal: true
# EOF
# }

