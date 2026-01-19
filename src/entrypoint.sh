#!/bin/sh
set -e

ZOTERO_USER=${ZOTERO_USER:-zotero}
ZOTERO_PASS=${ZOTERO_PASS:-zotero}
UID=${UID:-101}
GID=${GID:-101}

echo "Starting Zotero WebDAV..."
echo "User: $ZOTERO_USER"

# Create htpasswd file for basic auth
htpasswd -cb /etc/nginx/.htpasswd "$ZOTERO_USER" "$ZOTERO_PASS"

# WebDAV directory
mkdir -p /var/lib/dav/data
chown -R ${UID}:${GID} /var/lib/dav/data

exec "$@"
