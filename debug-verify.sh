#!/bin/bash

echo "Starting Debug Verification..."

# 1. Enable debug logging
echo "=== Enabling Debug Mode ==="
ha supervisor options --debug=true
ha supervisor reload

# 2. List all add-ons to verify names
echo "=== Listing Available Add-ons ==="
ha addons list

# 3. Get Home Assistant API status
echo "=== Checking Home Assistant API ==="
ha info

# 4. Check Prometheus configuration
echo "=== Checking Prometheus Configuration ==="
cat ~/project-management/monitoring/prometheus.yaml

# 5. Check specific AI service availability
echo "=== Checking AI Services ==="
for service in whisper piper openwakeword; do
    echo "Checking addon_core_${service}..."
    ping -c 1 addon_core_${service} 2>&1 || echo "Service not reachable"
done

# 6. Verify Grafana dashboard
echo "=== Checking Grafana Dashboard Configuration ==="
cat ~/project-management/monitoring/grafana/dashboards/ai-monitoring.json

echo "=== Verification Complete ==="
