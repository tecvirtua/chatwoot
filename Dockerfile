# Usa a imagem da Fazer.AI como base
FROM ghcr.io/fazer-ai/chatwoot:latest

# Instala Node.js e pnpm para poder recompilar
RUN apt-get update && apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g pnpm && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Sobrescreve os arquivos customizados (seu menu/contato)
COPY custom/app/app/javascript/dashboard/components-next/sidebar/Sidebar.vue \
     /app/app/javascript/dashboard/components-next/sidebar/Sidebar.vue

COPY custom/app/app/javascript/dashboard/routes/dashboard/conversation/ContactPanel.vue \
     /app/app/javascript/dashboard/routes/dashboard/conversation/ContactPanel.vue

# Instala dependências e recompila
WORKDIR /app
RUN pnpm install --frozen-lockfile || pnpm install
RUN SECRET_KEY_BASE=fake_key_for_build_only RAILS_ENV=production bundle exec rake assets:precompile
