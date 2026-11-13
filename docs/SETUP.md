# Setup and Troubleshooting

## Package Managers

The following installation methods were used:

- APT for Ubuntu packages.
- HashiCorp repository for Terraform.
- Ansible PPA for Ansible.
- AWS official installer for AWS CLI.
- Microsoft repository for Azure CLI.
- NVM for Node.js.
- Docker official repository for Docker.
- Official Minikube and kubectl installation methods.

## Troubleshooting Performed

### Docker
Verified Docker daemon and socket permissions.

### Kubernetes
Resolved port 8080 conflict by using an alternative port.

### Terraform and Ansible
Verified installation and executable permissions.

### Cloud CLIs
Verified AWS CLI and Azure CLI versions.

### WSL2
Confirmed Ubuntu running under WSL2.

## Verification

Run:

```bash
./scripts/verify.sh
