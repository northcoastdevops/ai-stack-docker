# AI Development Environment

A containerized development environment featuring Open WebUI (Ollama frontend), SearXNG search engine, and related services.

## Services

- **Open WebUI**: AI chat interface (port 8080)
- **Ollama**: AI model backend (port 11434)
- **SearXNG**: Privacy-focused meta search engine
- **Redis**: Cache for SearXNG
- **Nginx**: Reverse proxy with SSL termination
- **Certbot**: SSL certificate management

## Prerequisites

- Docker and Docker Compose
- 16GB+ RAM recommended
- 8+ CPU cores recommended

## Quick Start

1. Clone the repository
2. Configure your domains in `/etc/hosts`:
   ```
   127.0.0.1 ai.internal search.internal
   ```
3. Start the services:
   ```bash
   docker compose up -d
   ```

## Access

- AI Interface: https://ai.internal
- Search Engine: https://search.internal

## Directory Structure

```
.
├── docker-compose.yaml    # Main configuration
├── nginx/
│   ├── nginx.conf        # Nginx configuration
│   ├── generate-certs.sh # SSL certificate generation
│   └── renewal-hook.sh   # Certificate renewal hook
├── redis/
│   └── redis.conf       # Redis configuration
└── searxng/
    └── settings.yml     # SearXNG configuration
```

## Environment Variables

Key environment variables are set in docker-compose.yaml:
- WEBUI_SECRET_KEY: Authentication key for Open WebUI
- SEARXNG_SECRET_KEY: Authentication key for SearXNG

## SSL Certificates

SSL certificates are managed by Certbot. Initial setup:
```bash
./nginx/generate-certs.sh
```

## Data Persistence

All data is stored in Docker volumes:
- open-webui-data: Chat history and settings
- ollama-data: AI models
- searxng-db: Search settings
- redis-data: Cache data

## Service Configurations

### Open WebUI
- Authentication enabled with signup
- Web search integration with SearXNG
- WebSocket support for real-time chat
- CORS configured for ai.internal domain
- Memory limit: 8-16GB
- Worker count: 8

### SearXNG
- Enabled engines: Google, DuckDuckGo, Bing, Wikipedia
- Redis-backed caching
- Safe search disabled
- Google autocomplete enabled
- Request timeout: 10 seconds
- No image proxy

### Redis
- Maximum memory: 768MB
- LRU eviction policy
- Persistence: Save every 60 seconds if 1+ keys changed
- No authentication (development setup)

### Nginx
- SSL/TLS: TLS 1.2, 1.3
- HTTP/2 enabled
- HSTS enabled
- OCSP stapling enabled
- WebSocket proxy support
- Automatic HTTP to HTTPS redirect

### Ollama
- Direct model API access
- Memory limit: 8-16GB
- CPU limit: 8 cores
- Health checks enabled

### Certbot
- Automatic certificate renewal (12-hour checks)
- Standalone verification
- Auto-reload Nginx on renewal

## License
MIT