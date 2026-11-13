
#!/usr/bin/env bash

# Ubuntu DevOps Environment Verification
# Checks installations, services and permissions.

PASS=0
FAIL=0
WARN=0

pass() {
    echo -e "\e[32m[PASS]\e[0m $1"
    ((PASS++))
}

fail() {
    echo -e "\e[31m[FAIL]\e[0m $1"
    ((FAIL++))
}

warn() {
    echo -e "\e[33m[WARN]\e[0m $1"
    ((WARN++))
}

check_command() {
    local cmd="$1"
    local version_arg="${2:---version}"

    if command -v "$cmd" >/dev/null 2>&1; then
        pass "$cmd installed: $(command -v "$cmd")"
        "$cmd" "$version_arg" 2>&1 | head -n 1
    else
        fail "$cmd is not installed"
    fi
}

echo "======================================"
echo " UBUNTU DEVOPS HEALTH CHECK"
echo "======================================"

echo
echo "===== 1. CLOUD TOOLS ====="

check_command aws
check_command az
check_command terraform
check_command ansible
check_command ansible-playbook

echo
echo "===== 2. CONTAINER TOOLS ====="

check_command docker
check_command kubectl
check_command minikube

if docker info >/dev/null 2>&1; then
    pass "Docker daemon accessible"
else
    fail "Docker daemon inaccessible"
fi

if docker compose version >/dev/null 2>&1; then
    pass "Docker Compose installed"
else
    fail "Docker Compose unavailable"
fi

if systemctl is-active --quiet docker; then
    pass "Docker service running"
else
    warn "Docker service is not running"
fi

echo
echo "===== 3. DEVELOPMENT TOOLS ====="

check_command node
check_command npm
check_command jq
check_command git
check_command python3

echo
echo "===== 4. KUBERNETES CHECK ====="

if command -v kubectl >/dev/null 2>&1; then
    if kubectl version --client >/dev/null 2>&1; then
        pass "kubectl client working"
    else
        fail "kubectl client error"
    fi

    if kubectl cluster-info >/dev/null 2>&1; then
        pass "Kubernetes cluster accessible"
    else
        warn "Kubernetes cluster unavailable"
    fi
fi

if command -v minikube >/dev/null 2>&1; then
    if minikube status >/dev/null 2>&1; then
        pass "Minikube cluster running"
    else
        warn "Minikube is not running"
    fi
fi

echo
echo "===== 5. LINUX PERMISSIONS ====="

for cmd in aws az terraform ansible docker kubectl node jq; do
    if command -v "$cmd" >/dev/null 2>&1; then
        BIN=$(command -v "$cmd")
        if [[ -x "$BIN" ]]; then
            pass "$cmd is executable"
        else
            fail "$cmd is not executable"
        fi
    fi
done

if [[ -r "$HOME" && -w "$HOME" && -x "$HOME" ]]; then
    pass "Home directory permissions OK"
else
    fail "Home directory permission issue"
fi

if id -nG "$USER" | grep -qw docker; then
    pass "User belongs to docker group"
else
    warn "User is not in docker group (sudo may be required)"
fi

if [[ -f "$HOME/.aws/credentials" ]]; then
    PERM=$(stat -c "%a" "$HOME/.aws/credentials")
    if [[ "$PERM" == "600" ]]; then
        pass "AWS credentials file permissions secure (600)"
    else
        warn "AWS credentials permissions are $PERM; recommended 600"
    fi
fi

if [[ -d "$HOME/.ssh" ]]; then
    PERM=$(stat -c "%a" "$HOME/.ssh")
    if [[ "$PERM" == "700" ]]; then
        pass "SSH directory permissions secure (700)"
    else
        warn "SSH directory permissions are $PERM; recommended 700"
    fi
fi

echo
echo "===== 6. SYSTEM INFORMATION ====="

echo "Ubuntu:"
grep PRETTY_NAME /etc/os-release | cut -d= -f2

echo "Kernel:"
uname -r

echo "Disk:"
df -h "$HOME" | tail -n 1

echo "Memory:"
free -h | head -n 2

echo
echo "======================================"
echo " VERIFICATION SUMMARY"
echo "======================================"

echo -e "\e[32mPASS: $PASS\e[0m"
echo -e "\e[31mFAIL: $FAIL\e[0m"
echo -e "\e[33mWARN: $WARN\e[0m"

if [[ "$FAIL" -eq 0 ]]; then
    echo "Core command checks completed without failures."
else
    echo "Some tools need attention."
fi

echo "======================================"
