# ArgoCD Terraform CI/CD

This repository contains Terraform configuration for deploying ArgoCD to Kubernetes with automated CI/CD pipelines using GitHub Actions.

## 🏗️ Infrastructure

- **ArgoCD**: Version v3.0.12
- **Helm Chart**: argo-cd 8.2.5
- **Namespace**: argocd
- **Domain**: argocd.kangdeploy.web.id
- **Ingress**: Cloudflare Tunnel

## 🚀 CI/CD Workflows

### 1. Terraform Plan (`terraform-plan.yml`)
**Trigger**: Pull requests to `main` branch
- Runs `terraform fmt`, `init`, `validate`, and `plan`
- Posts plan results as PR comments
- Validates configuration changes before merge

### 2. Terraform Apply (`terraform-apply.yml`)
**Trigger**: 
- Push to `main` branch (automatic)
- Manual workflow dispatch (requires confirmation)
- Deploys infrastructure changes
- Creates deployment summary
- Protected by production environment

### 3. Terraform Destroy (`terraform-destroy.yml`)
**Trigger**: Manual workflow dispatch only
- Requires typing "destroy" to confirm
- Can target specific resources
- Creates destruction summary
- Protected by production environment

## 🔧 Setup Instructions

### 1. Repository Secrets

Add these secrets to your GitHub repository (`Settings > Secrets and variables > Actions`):

```bash
KUBE_CONFIG_DATA  # Base64 encoded kubeconfig file
```

To encode your kubeconfig:
```bash
cat ~/.kube/config | base64 | pbcopy  # macOS
cat ~/.kube/config | base64 -w 0      # Linux
```

### 2. Environment Protection (Recommended)

1. Go to `Settings > Environments`
2. Create environment named `production`
3. Add protection rules:
   - Required reviewers
   - Wait timer
   - Deployment branches (main only)

### 3. Cloud Provider Credentials (if needed)

If using cloud-managed Kubernetes, add appropriate secrets:

**AWS EKS:**
```bash
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY
```

**Azure AKS:**
```bash
ARM_CLIENT_ID
ARM_CLIENT_SECRET
ARM_SUBSCRIPTION_ID
ARM_TENANT_ID
```

**Google GKE:**
```bash
GOOGLE_CREDENTIALS  # Service account JSON
```

## 📋 Usage

### Automatic Deployment
1. Create a pull request with your changes
2. Review the Terraform plan in PR comments
3. Merge to `main` branch
4. Deployment runs automatically

### Manual Deployment
1. Go to `Actions > Terraform Apply`
2. Click `Run workflow`
3. Type "apply" to confirm
4. Click `Run workflow`

### Manual Destruction
1. Go to `Actions > Terraform Destroy`
2. Click `Run workflow`
3. Type "destroy" to confirm
4. Optionally specify target resource
5. Click `Run workflow`

## 🔍 Monitoring

- Check workflow status in `Actions` tab
- View deployment summaries in workflow runs
- Monitor ArgoCD at: https://argocd.kangdeploy.web.id

## 📁 Project Structure

```
.
├── .github/workflows/
│   ├── terraform-plan.yml     # PR validation
│   ├── terraform-apply.yml    # Deployment
│   └── terraform-destroy.yml  # Destruction
├── argocd.tf                  # ArgoCD Helm release
├── provider.tf                # Terraform providers
├── variables.tf               # Input variables
├── values.yml                 # ArgoCD configuration
└── README.md                  # This file
```

## 🛡️ Security Features

- Environment protection for production deployments
- Manual confirmation required for destruction
- Kubernetes config stored as encrypted secret
- Terraform state validation
- Format checking and validation

## 🔧 Local Development

```bash
# Initialize Terraform
terraform init

# Plan changes
terraform plan

# Apply changes
terraform apply

# Destroy infrastructure
terraform destroy
```

## 📝 Configuration

### ArgoCD Values
Edit `values.yml` to customize ArgoCD configuration:
- Domain settings
- Ingress configuration
- User accounts and RBAC
- SSL/TLS settings

### Terraform Variables
Edit `variables.tf` or create `terraform.tfvars`:
```hcl
kubeconfig_path = "/path/to/your/kubeconfig"
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request
5. Review the Terraform plan
6. Merge after approval

## 📞 Support

For issues or questions:
- Create an issue in this repository
- Check ArgoCD documentation: https://argo-cd.readthedocs.io/
- Review Terraform Helm provider docs: https://registry.terraform.io/providers/hashicorp/helm/
