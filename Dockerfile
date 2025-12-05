# Usa a imagem da Fazer.AI como base
FROM ghcr.io/fazer-ai/chatwoot:latest

# Instala Node.js e pnpm (Alpine usa apk, não apt-get)
RUN apk add --no-cache nodejs npm && \
    npm install -g pnpm

# Sobrescreve os arquivos customizados
COPY custom/app/app/javascript/dashboard/components-next/sidebar/Sidebar.vue \
     /app/app/javascript/dashboard/components-next/sidebar/Sidebar.vue

COPY custom/app/app/javascript/dashboard/routes/dashboard/conversation/ContactPanel.vue \
     /app/app/javascript/dashboard/routes/dashboard/conversation/ContactPanel.vue

# Instala dependências e recompila
WORKDIR /app
RUN pnpm install --frozen-lockfile || pnpm install
RUN SECRET_KEY_BASE=fake_key_for_build_only RAILS_ENV=production bundle exec rake assets:precompile
