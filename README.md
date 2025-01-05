# Media Stack Project

A Docker-based media server stack with secure secrets management.

## 🚀 Getting Started

### Prerequisites
- Docker and Docker Compose
- Make
- Bash

### Initial Setup
1. Clone this repository
2. Run the setup script:
   ```bash
   make setup
   ```

## 🔐 Secrets Management

This project uses encrypted secrets for secure configuration. You'll need a password to encrypt/decrypt the secrets file.

### Path Configuration
Before starting the stack, you need to configure the correct paths in `docker-compose.yml`. Update the following volume mappings according to your system:

```yaml
# VPN Service
- /path/to/gluetun/config:/gluetun      # VPN configuration directory

# Transmission
- /path/to/transmission/config:/config   # Transmission settings
- /path/to/downloads:/downloads          # Download directory
- /path/to/watch:/watch                  # Watch directory for auto-downloads

# Media Libraries
- /path/to/movies:/movies                # Movies library
- /path/to/tv:/tv                        # TV Shows library
- /path/to/books:/books                  # Books library
- /path/to/media:/media                  # Combined media library for Jellyfin

# Application Configs
- /path/to/jackett/config:/config        # Jackett configuration
- /path/to/radarr/config:/config         # Radarr configuration
- /path/to/sonarr/config:/config         # Sonarr configuration
- /path/to/readarr/config:/config        # Readarr configuration
- /path/to/jellyfin/config:/config       # Jellyfin configuration
```

Example configuration for a typical setup:
```yaml
- /home/user/mediaserver/config/gluetun:/gluetun
- /home/user/mediaserver/config/transmission:/config
- /home/user/mediaserver/downloads:/downloads
- /home/user/mediaserver/watch:/watch
- /home/user/mediaserver/movies:/movies
- /home/user/mediaserver/tv:/tv
- /home/user/mediaserver/books:/books
- /home/user/mediaserver/media:/media
```

### Managing Secrets
- **Encrypt secrets:**
  ```bash
  make encrypt PASSWORD=your-password
  ```
- **Decrypt secrets:**
  ```bash
  make decrypt PASSWORD=your-password
  ```

## 🎮 Usage

### First Time Start
For the first time running the stack:
```bash
make first-start PASSWORD=your-password
```

### Regular Operations
- **Start the stack:**
  ```bash
  make start
  ```

- **Stop the stack:**
  ```bash
  make stop
  ```

- **Clean up all resources:**
  ```bash
  make clean
  ```

## 📋 Available Commands

| Command | Description |
|---------|-------------|
| `make setup` | Install required dependencies |
| `make encrypt` | Encrypt secrets file |
| `make decrypt` | Decrypt secrets file |
| `make first-start` | Initial start of the media stack |
| `make start` | Start the media stack |
| `make stop` | Stop the media stack |
| `make clean` | Clean up all resources |
| `make verify` | Verify integrity of encrypted secrets |

## 🔍 Help

For detailed information about available commands:

```bash
make help
```


## ⚠️ Important Notes

- Always keep your encryption password safe
- The `PASSWORD` parameter is required for encryption/decryption operations
- Run `make first-start` only for the initial setup
- Use `make start` for subsequent starts after initial setup

## 🛡️ Security

- Secrets are stored in an encrypted format
- The encryption/decryption process is handled securely through dedicated scripts
- Regular integrity verification is available through the `make verify` command