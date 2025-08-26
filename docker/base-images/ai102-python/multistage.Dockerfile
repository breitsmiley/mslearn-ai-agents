# === Variant B (альтернатива): копируем az из azurelinux3.0 ===
FROM mcr.microsoft.com/azure-cli:2.74.0-azurelinux3.0 AS azcli

FROM python:3.11-slim
WORKDIR /app
ENV PIP_DISABLE_PIP_VERSION_CHECK=1 PIP_NO_CACHE_DIR=1

# Копируем бинарь и payload Azure CLI с Azure Linux
# Документация: az в /usr/bin/az; payload в /lib64/az на Azure Linux
COPY --from=azcli /usr/bin/az /usr/bin/az
COPY --from=azcli /lib64/az /lib64/az

COPY requirements.txt /tmp/requirements.txt
RUN python -m pip install --upgrade pip setuptools wheel \
 && pip install -r /tmp/requirements.txt

# Проверка (опционально): RUN az --version
CMD ["bash", "-lc", "tail -f /dev/null"]
