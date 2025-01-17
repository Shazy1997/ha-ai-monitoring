# Home Assistant AI Monitoring Stack

Complete monitoring solution for Home Assistant AI services using Prometheus and Grafana. This stack provides comprehensive monitoring, alerting, and visualization for AI-powered Home Assistant services.

## Features

- **Complete Monitoring Stack:**
  - Prometheus for metrics collection
  - Grafana for visualization
  - Custom AI service exporters
  - Automated setup scripts
  - Alert configurations

- **Monitored Services:**
  - OpenWakeWord (Wake word detection)
  - Piper (Text-to-speech)
  - Whisper (Speech-to-text)
  - System metrics (Node Exporter)
  - Docker metrics
  - Home Assistant metrics

## Directory Structure

- `/prometheus`: Prometheus configuration and rules
- `/grafana`: Dashboards and data source configurations
- `/config`: General configuration files
- `/alerts.yml`: Alert rules configuration
- `/setup-monitoring.sh`: Automated setup script

## Prerequisites

- Home Assistant installation
- Docker and Docker Compose
- AI Add-ons installed (Piper, Whisper, OpenWakeWord)
- Linux system (tested on Raspberry Pi)

## Installation

1. Clone the repository:
   ```bash
   git clone git@github.com:Shazy1997/ha-ai-monitoring.git
   cd ha-ai-monitoring
   ```

2. Run the setup script:
   ```bash
   ./setup-monitoring.sh
   ```

3. Configure Home Assistant integration:
   - Enable Prometheus integration in Home Assistant
   - Import Grafana dashboards

## Configuration

### Prometheus
Edit `prometheus.yaml` to modify scrape configurations.

### Grafana
Dashboards are automatically provisioned from `/grafana/dashboards`.

### Alerts
Configure alerts in `alerts.yml`.

## Metrics Exporters

AI service metrics are provided by [ha-ai-exporters](https://github.com/Shazy1997/ha-ai-exporters).

## Development

### Testing
Run the verification script:
```bash
./debug-verify.sh
```

### Contributing
1. Fork the repository
2. Create a feature branch
3. Submit a Pull Request

## License
This project is licensed under the MIT License.

## Support
- Create an issue for bugs or feature requests
- Pull requests are welcome
