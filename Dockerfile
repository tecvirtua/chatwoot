# Sempre pegar a ÚLTIMA imagem do Chatwoot da Fazer.AI
FROM ghcr.io/fazer-ai/chatwoot:latest

# Sobrescreve os arquivos customizados (seu menu/contato)
COPY custom/app/app/javascript/dashboard/components-next/sidebar/Sidebar.vue \
     /app/app/javascript/dashboard/components-next/sidebar/Sidebar.vue

COPY custom/app/app/javascript/dashboard/routes/dashboard/conversation/ContactPanel.vue \
     /app/app/javascript/dashboard/routes/dashboard/conversation/ContactPanel.vue

# Recompila os assets depois de sobrescrever os arquivos
WORKDIR /app
RUN SECRET_KEY_BASE=fake_key_for_build_only RAILS_ENV=production bundle exec rake assets:precompile
