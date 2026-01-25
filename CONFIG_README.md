# Configuration File Guide

## Overview

The miniBroker app requires a configuration file named `miniBroker-config.json` to be placed in a specific location depending on how you run the app.

## File Location

### When running from source (development):
The config file should be placed in the **parent directory** of the project:
```
/Users/kam/repos/NEW2/qomet/agora/miniBroker-config.json
```

### When running the built .app (production):
The config file should be in the same directory as the `miniBroker.app` bundle:
```
/path/to/miniBroker.app
/path/to/miniBroker-config.json
```

## Configuration Structure

```json
{
  "configurations": {
    "grpc": {
      "host": "localhost",
      "port": 50051,
      "useSecure": false
    },
    "participant": {
      "apiKey": "your-api-key-here",
      "participantId": "test-participant",
      "name": "Test User"
    },
    "app": {
      "name": "miniBroker",
      "version": "1.0.0",
      "environment": "development"
    },
    "network": {
      "defaultTimeoutSeconds": 30,
      "connectivityCheckIntervalMs": 3000,
      "enableDebugLogging": true
    },
    "ui": {
      "defaultPageSize": 50,
      "maxPageSize": 200,
      "refreshIntervalMs": 2000
    }
  }
}
```

## Configuration Fields

### grpc
- **host**: The gRPC server hostname or IP address (default: "localhost")
- **port**: The gRPC server port (default: 50051)
- **useSecure**: Whether to use TLS/SSL (default: false)

### participant
- **apiKey**: Your API key for authentication (required)
- **participantId**: Your participant identifier
- **name**: Display name for the participant

### app
- **name**: Application name
- **version**: Application version
- **environment**: Current environment (development/staging/production)

### network
- **defaultTimeoutSeconds**: Network request timeout in seconds
- **connectivityCheckIntervalMs**: How often to check connectivity (milliseconds)
- **enableDebugLogging**: Enable debug output

### ui
- **defaultPageSize**: Default number of items per page in lists
- **maxPageSize**: Maximum allowed page size
- **refreshIntervalMs**: UI refresh interval in milliseconds

## Quick Setup

1. Copy the sample config file to the correct location:
   ```bash
   cp "miniBroker-config.json" /Users/kam/repos/NEW2/qomet/agora/
   ```

2. Edit the config file with your settings:
   - Change `grpc.host` to your server address
   - Change `grpc.port` to your server port
   - Add your `participant.apiKey`

3. Restart the app

## Notes

- The config file is **required** for the app to run
- The file must be valid JSON
- The API key is extracted from `configurations.participant.apiKey`
- If the file is not found, you'll see a "Configuration error" message