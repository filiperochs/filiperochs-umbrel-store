ARG NODE_VERSION=20
ARG DEBIAN_CODE=bullseye
ARG REPO_URL=https://github.com/MathMan05/Fermi.git
ARG BRANCH=main
ARG CLIENT_PATH=fermi

FROM node:${NODE_VERSION}-${DEBIAN_CODE} AS builder

ARG REPO_URL
ARG BRANCH
ARG CLIENT_PATH

WORKDIR /build

RUN apt-get update && \
    apt-get install -y --no-install-recommends git build-essential python3 && \
    rm -rf /var/lib/apt/lists/*

# Clone the repository (shallow) and checkout the requested branch
RUN git clone --depth 1 --branch "${BRANCH}" "${REPO_URL}" repo || git clone "${REPO_URL}" repo

WORKDIR /build/repo/${CLIENT_PATH}

RUN npm ci --no-audit --no-fund
RUN npm run build

FROM node:${NODE_VERSION}-${DEBIAN_CODE} AS final
WORKDIR /usr/src/app

ARG CLIENT_PATH
COPY --from=builder /build/repo/${CLIENT_PATH} /usr/src/app

ENV NODE_ENV=production
ENV PORT=5236

EXPOSE 5236

RUN useradd -u 1000 -m appuser || true
USER appuser

CMD [ "npm", "run", "start" ]
