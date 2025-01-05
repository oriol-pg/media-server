.PHONY: help setup encrypt decrypt start stop clean verify

# Colors for terminal output
GREEN := \033[0;32m
RED := \033[0;31m
NC := \033[0m # No Color

help: ## Show this help menu
	@echo "Usage: make [TARGET] [ARGS...]"
	@echo ""
	@echo "Targets:"
	@awk 'BEGIN {FS = ":.*##"; printf "\033[36m"} /^[a-zA-Z_-]+:.*?##/ { printf "  %-15s %s\n", $$1, $$2 }' $(MAKEFILE_LIST)
	@echo ""
	@echo "Arguments:"
	@echo "  PASSWORD=your-password    Required for encrypt/decrypt operations"

setup: ## Install required dependencies
	@./scripts/setup.sh

encrypt: ## Encrypt secrets file (requires PASSWORD=)
	@if [ -z "$(PASSWORD)" ]; then echo "$(RED)Error: PASSWORD is required$(NC)"; exit 1; fi
	@./scripts/encrypt.sh "$(PASSWORD)"
	@echo "$(GREEN)Secrets encrypted successfully!$(NC)"

decrypt: verify ## Decrypt secrets file (requires PASSWORD=)
	@if [ -z "$(PASSWORD)" ]; then echo "$(RED)Error: PASSWORD is required$(NC)"; exit 1; fi
	@./scripts/decrypt.sh "$(PASSWORD)"

first-start: decrypt ## Start the media stack (requires PASSWORD=)
	@echo "Starting media stack..."
	@docker-compose up -d
	@echo "$(GREEN)Media stack started successfully!$(NC)"

start: decrypt ## Start the media stack (once secrets are decrypted)
	@docker-compose up -d
	@echo "$(GREEN)Media stack started successfully!$(NC)"

stop: ## Stop the media stack
	@echo "Stopping media stack..."
	@docker-compose down
	@echo "$(GREEN)Media stack stopped successfully!$(NC)"

clean: stop ## Clean up all resources
	@./scripts/cleanup.sh
	@echo "$(GREEN)Cleanup completed!$(NC)"

verify: ## Verify integrity of encrypted secrets
	@./scripts/verify.sh