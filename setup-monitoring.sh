#!/bin/bash

# Configuration
MONITOR_DIR="/home/shazy/project-management/monitoring"
LOG_DIR="${MONITOR_DIR}/logs"
CONFIG_DIR="${MONITOR_DIR}/config"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

log() {
    echo -e "${GREEN}[$(date '+%Y-%m-%d %H:%M:%S')] $1${NC}"
}

error() {
    echo -e "${RED}[$(date '+%Y-%m-%d %H:%M:%S')] ERROR: $1${NC}"
}

# Create required directories
setup_directories() {
    log "Creating directories..."
    mkdir -p "${LOG_DIR}"
    mkdir -p "${CONFIG_DIR}"
    mkdir -p "${MONITOR_DIR}/prometheus"
    mkdir -p "${MONITOR_DIR}/grafana/dashboards"
    mkdir -p "${MONITOR_DIR}/grafana/datasources"
}

# Configure log rotation
setup_logrotate() {
    log "Setting up log rotation..."
    sudo cp "${MONITOR_DIR}/logrotate.conf" /etc/logrotate.d/ai-monitoring
    sudo chmod 644 /etc/logrotate.d/ai-monitoring
    sudo chown root:root /etc/logrotate.d/ai-monitoring
}

# Install Node Exporter for system metrics
install_node_exporter() {
    log "Installing Node Exporter..."
    if ! command -v node_exporter &> /dev/null; then
        wget https://github.com/prometheus/node_exporter/releases/download/v1.7.0/node_exporter-1.7.0.linux-arm64.tar.gz
        tar xvfz node_exporter-*.tar.gz
        sudo mv node_exporter-*/node_exporter /usr/local/bin/
        rm -rf node_exporter-*
        
        # Create system service
        sudo tee /etc/systemd/system/node_exporter.service << 'SERVICEEOF'
[Unit]
Description=Node Exporter
After=network.target

[Service]
Type=simple
User=shazy
ExecStart=/usr/local/bin/node_exporter
Restart=always

[Install]
WantedBy=multi-user.target
SERVICEEOF

        sudo systemctl daemon-reload
        sudo systemctl enable node_exporter
        sudo systemctl start node_exporter
    else
        log "Node Exporter already installed"
    fi
}

# Configure Docker metrics
setup_docker_metrics() {
    log "Configuring Docker metrics..."
    sudo tee /etc/docker/daemon.json << 'DOCKEREOF'
{
  "metrics-addr": "127.0.0.1:9323",
  "experimental": true
}
DOCKEREOF

    sudo systemctl restart docker
}

# Enable Prometheus in Home Assistant
setup_ha_prometheus() {
    log "Setting up Home Assistant Prometheus integration..."
    # This needs to be done through the UI or API
    log "Please enable Prometheus integration in Home Assistant UI"
    log "Navigate to Configuration -> Integrations -> Add Integration -> Prometheus"
}

# Main setup
main() {
    log "Starting monitoring setup..."
    
    setup_directories
    setup_logrotate
    install_node_exporter
    setup_docker_metrics
    setup_ha_prometheus

    log "Configuration complete!"
    log "Please complete the following manual steps:"
    echo "1. Enable Prometheus integration in Home Assistant"
    echo "2. Import Grafana dashboards through the UI"
    echo "3. Verify all exporters are running:"
    echo "   - Node Exporter (port 9100)"
    echo "   - Docker metrics (port 9323)"
    echo "4. Check log rotation: sudo logrotate -d /etc/logrotate.d/ai-monitoring"
}

# Run main setup
main "$@"
