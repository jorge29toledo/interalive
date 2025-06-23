#!/bin/bash
set -e

if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

echo "⏳ Aguardando banco de dados..."
until pg_isready -h db -p 5432 -U "$POSTGRES_USER"; do
  sleep 1
done
echo "✅ Banco de dados pronto."

bundle check || bundle install

bundle exec rails db:migrate

# Compila o Tailwind antes de subir o server (opcional em dev, mas útil)
echo "🎨 Compilando TailwindCSS..."
bundle exec rails tailwindcss:build

# exec "$@"
exec bundle exec foreman start -f Procfile.dev
