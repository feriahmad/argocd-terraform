resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "argo"
  chart      = "argo-cd"
  version    = "8.2.5"

  values = [file("values.yml")]
}
