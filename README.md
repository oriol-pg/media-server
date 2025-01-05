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