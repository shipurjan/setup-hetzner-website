# vps-webhost-init

One command to provision a production-ready VPS with Docker, auto-HTTPS, fail2ban honeypots, GitHub CI/CD, and a Lighthouse-perfect SPA Astro frontend.

## Project Structure

- `init.sh` - Main script that provisions the VPS
- `default.conf` - Default configuration values
- `p10k.zsh` - Powerlevel10k theme config
- `template/` - Files deployed to `/root/$DOMAIN/` on the VPS
  - `docker/` - Docker Compose and Caddy config
  - `frontend/` - Astro site source
  - `scripts/` - Monitoring scripts (health, disk, security updates)
  - `.github/workflows/` - CI/CD pipelines
- `dev/` - Development/deployment helpers
  - `deploy.sh` - Automated Hetzner deployment
  - `default.env` - Environment template for deploy script

## Template System

Placeholders use format `__#TEMPLATE#:VARIABLE__` (compatible with Astro).
Variables: DOMAIN, EMAIL, ADMIN_LOGIN, ADMIN_PASSWORD, TELEGRAM_BOT_TOKEN, TELEGRAM_CHAT_ID

## Docker Services

1. **frontend** - Astro build (outputs to volume)
2. **caddy** - Reverse proxy with auto-HTTPS, serves static files
3. **dozzle** - Log viewer at logs.$DOMAIN

## CI/CD Workflows

- `ci.yml` - Type check + build on PR/push
- `deploy.yml` - SSH deploy to VPS after CI passes
- `lighthouse.yml` - Performance scoring on PRs
- `gitleaks.yml` - Secret scanning

## Security Features

- fail2ban with 50+ honeypot patterns
- SSH hardening (key-only, optional custom port)
- Caddy security headers + bot blocking
- Telegram alerts for bans

## Testing

Use `dev/deploy.sh` with Hetzner credentials to test on real VPS.
Add `--staging` flag to use Let's Encrypt staging environment.
