---
title: Configuration
section: Build
approved: true
---

# Configuration

Every service reads its settings from the environment at startup.

| Setting | Default | Meaning |
| --- | --- | --- |
| `PORT` | `8080` | HTTP port |
| `DATABASE_URL` | none, required | Postgres connection string |
| `EXPORT_RATE_LIMIT` | `10` | Export requests per minute per team |
| `UPLOAD_MAX_MB` | `50` | Largest accepted upload |

A malformed value stops the service at startup with the setting's name in the
error.

The sync-conflict worker will add its own settings once its spec lands, and
this page will list them then.
