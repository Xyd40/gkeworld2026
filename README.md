GKE World 2026
A complete end-to-end demonstration of deploying a containerized Nginx application to Google Kubernetes Engine (GKE) Autopilot using Terraform for Infrastructure-as-Code (IaC).

Prerequisites
    • GCP Project
      gkeworld2026
    • Local Tools
      Google Cloud SDK (gcloud), Terraform, Docker, kubectl.
    • Auth
       Run gcloud auth application-default login to give Terraform access.

1. Infrastructure Setup (Terraform)
We use Terraform to provision a VPC, an Artifact Registry, and a GKE Autopilot cluster.
Bash
cd ~/gcp-infra
terraform init
terraform apply -auto-approve
Creates the skeleton of your cloud environment.
2. Application Build (Docker)
Build the custom Nginx image and push it to the private Artifact Registry.
Bash
# Authenticate Docker to GCP
gcloud auth configure-docker us-central1-docker.pkg.dev

# Build and Push (v1)
export REPO_URL="us-central1-docker.pkg.dev/gkeworld2026/devops-lab/my-app:v1"
docker build -t $REPO_URL .
docker push $REPO_URL

3. Kubernetes Deployment (kubectl)
Deploy the application pods and expose them via a Public Load Balancer.
Bash
# Apply the Deployment and Service
kubectl apply -f app-deploy.yaml

# Check status (Wait for EXTERNAL-IP)
kubectl get service real-app-service

Access the site
Visit http://<EXTERNAL-IP> in your browser.

4. Troubleshooting
      1. Firewall Issues
    •  If the site is unreachable, ensure Port 80 is open in the GCP VPC Firewall.
      2. Pending Pods
    •  Autopilot takes ~2 minutes to provision new nodes. Run kubectl get nodes to see them spinning up.
      3. Auth Errors
    •  Ensure your Docker helper is configured: gcloud auth configure-docker.
 
5. Cleanup
To stop billing and delete all resources
Bash
terraform destroy -auto-approve
