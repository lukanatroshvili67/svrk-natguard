# svrk-natguard

Entity native safety wrappers — loaded by other resources via @svrk-natguard/natguard.lua

**Version:** 1.0.0  
**Framework:** VORP (RedM)

## Install

1. Copy this folder into your server's `resources/` directory
2. Add to `server.cfg`:

```cfg
ensure svrk-natguard
```

## Configuration

See the files in this resource for configurable values.

## Notes

Secrets are read from convars rather than hardcoded, so they live in
`server.cfg` and never in source control. Real player identifiers are not
committed; where a list is required, an `.example` file documents the format.

## License

MIT
