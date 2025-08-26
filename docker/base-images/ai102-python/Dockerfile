FROM python:3.13.7-slim-bookworm

WORKDIR /app

ENV PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1

ARG AZ_VER=2.76.0

# Install Azure CLI
# (https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?view=azure-cli-latest&utm_source=chatgpt.com&pivots=apt)
RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends \
        ca-certificates curl gnupg lsb-release; \
    mkdir -p /etc/apt/keyrings; \
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc \
      | gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg; \
    chmod go+r /etc/apt/keyrings/microsoft.gpg; \
cat >/etc/apt/sources.list.d/azure-cli.sources <<EOF
Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: $(lsb_release -cs)
Components: main
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/microsoft.gpg
EOF

RUN set -eux; \
    apt-get update; \
    apt-get install -y --no-install-recommends azure-cli; \
    rm -rf /var/lib/apt/lists/*


# Main
COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install --upgrade pip setuptools wheel \
 && pip install -r /tmp/requirements.txt

CMD ["bash", "-lc", "tail -f /dev/null"]
