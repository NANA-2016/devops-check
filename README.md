
# Ubuntu DevOps Environment Setup

## Project Overview

This project documents the installation, configuration and verification of a DevOps development environment on Ubuntu 24.04.5 LTS running on WSL2.

## Tools Installed

| Tool | Purpose |
|---|---|
| Git | Version control |
| AWS CLI | AWS cloud management |
| Azure CLI | Azure cloud management |
| Terraform | Infrastructure as Code |
| Ansible | Configuration management |
| Docker | Containerization |
| Docker Compose | Container management |
| Kubernetes | Container orchestration |
| Minikube | Local Kubernetes cluster |
| kubectl | Kubernetes CLI |
| Node.js | Backend development |
| npm | Package management |
| jq | JSON processing |

## Installation Methods

- APT: Ubuntu packages, jq and Ansible.
- HashiCorp APT repository: Terraform.
- AWS official installer: AWS CLI v2.
- Microsoft APT repository: Azure CLI.
- NVM: Node.js.
- Docker official APT repository: Docker Engine and Compose.
- Official Kubernetes installation instructions: kubectl and Minikube.

## Verification Results

The local verification script reported:

- 30 PASS
- 0 FAIL
- 0 WARN

See `evidence/verification-report.txt` for the captured output.

## Kubernetes Cluster

Minikube was configured using Docker as its driver.

Verification commands:

```bash
minikube status
kubectl get nodes -o wide
kubectl get pods -A
```

See `evidence/minikube-node.png` for local cluster evidence.

## Permissions

Docker socket:

```text
srw-rw---- root docker
```

Permission mode: 660.

The current user belongs to the Docker group.

SSH directory permissions: 700.

## Troubleshooting

1. Docker permission denied:
   Check Docker service status and Docker group membership.

2. Kubernetes port already in use:
   Use another local port with kubectl port-forward.

3. Minikube unavailable:
   Check Docker service and run `minikube status`.

4. AWS authentication:
   Configure AWS SSO or approved credentials before accessing AWS resources.

5. Terraform initialization:
   Check network connectivity and provider configuration.

## Repository Structure

- `config/`: Shell configuration.
- `scripts/`: Verification scripts.
- `evidence/`: Verification report and screenshots.
- `docs/`: Setup and troubleshooting documentation.

## Platform

Ubuntu 24.04.5 LTS  
WSL2 Linux Kernel

## Author

Faith
# devops-check

INSTALLED DevOps Tools 

<img width="946" height="585" alt="image" src="https://github.com/user-attachments/assets/fe2a11aa-4ed5-435b-b5b7-e79bf65584dc" />

WORKING kubectl

<img width="962" height="917" alt="image" src="https://github.com/user-attachments/assets/e5bcdd7d-fa54-4437-9650-a038e7f70eb3" />

CHALLENGES MET

Has been abit of a challange connecting to git hub from my terminal. 

Afew  huddles connecting running the terminal and figuring out where to install the different tool. Did it through the 

root teminal which i was not so sure of and it worked 




