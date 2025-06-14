#!/bin/bash

# Configuration script for AWS CDK deployment
# This script sets up stack names and other deployment variables
# based on environment variables or defaults

# Color codes for output
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[1;33m'
export BLUE='\033[0;34m'
export NC='\033[0m' # No Color

# Load environment variables from .env file if it exists
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
fi

# Set default values if environment variables are not set
export APP_NAME=${APP_NAME:-"nextjs-app"}
export DOMAIN_NAME=${DOMAIN_NAME:-"example.com"}
export STACK_PREFIX=${STACK_PREFIX:-$(echo "$APP_NAME" | tr '[:lower:]' '[:upper:]' | sed 's/[^A-Z0-9]//g')}

# Directory paths
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
export CDK_DIR="$PROJECT_ROOT/cdk"

# Stack names based on the configured prefix
export FOUNDATION_STACK="${STACK_PREFIX}-Foundation"
export CERTIFICATE_STACK="${STACK_PREFIX}-Certificate"
export EDGE_FUNCTIONS_STACK="${STACK_PREFIX}-EdgeFunctions"
export WAF_STACK="${STACK_PREFIX}-WAF"
export CDN_STACK="${STACK_PREFIX}-CDN"
export MONITORING_STACK="${STACK_PREFIX}-Monitoring"
export APP_STACK="${STACK_PREFIX}-App"
export API_STACK="${STACK_PREFIX}-API"

# Legacy stack names for cleanup/migration
export LEGACY_STACK="VocalTechniqueTranslatorStack"
export LEGACY_WAF_STACK="VocalTechniqueTranslatorWafStack"
export LEGACY_MONITORING_STACK="VocalTechniqueTranslatorMonitoringStack"

# Display configuration
if [ "${1:-}" = "--show-config" ]; then
    echo "🔧 Current configuration:"
    echo "   APP_NAME: $APP_NAME"
    echo "   DOMAIN_NAME: $DOMAIN_NAME"
    echo "   STACK_PREFIX: $STACK_PREFIX"
    echo ""
    echo "📚 Stack names:"
    echo "   Foundation: $FOUNDATION_STACK"
    echo "   Certificate: $CERTIFICATE_STACK"
    echo "   Edge Functions: $EDGE_FUNCTIONS_STACK"
    echo "   WAF: $WAF_STACK"
    echo "   CDN: $CDN_STACK"
    echo "   Monitoring: $MONITORING_STACK"
    echo "   App: $APP_STACK"
fi