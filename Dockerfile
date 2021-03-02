FROM alpine:3.13 as builder
RUN apk add --no-cache \
    acl \
    fcgi \
    file \
    gettext \
    git \
    curl \
    unzip\
    python3-dev \
    py3-pip \
    gcc \
    linux-headers \
    musl-dev \
    libffi-dev \
    openssl-dev

RUN git clone --recursive  --depth 1 --branch v2 --single-branch  https://github.com/aws/aws-cli.git

WORKDIR aws-cli

RUN pip install --ignore-installed -r requirements.txt && \
    pip install -e . && \
    aws --version

FROM alpine:3.13 as runner

RUN apk add --no-cache python3 \
    groff

COPY --from=builder /usr/bin/aws* /usr/bin/
COPY --from=builder /usr/lib/python3.8/site-packages /usr/lib/python3.8/site-packages
COPY --from=builder /aws-cli /aws-cli
