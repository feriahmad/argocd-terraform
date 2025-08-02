resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  #repository = "argo" # For Local Repo/Machine
  chart      = "argo-cd"
  version    = "8.2.5"

  values = [file("values.yml")]
}
