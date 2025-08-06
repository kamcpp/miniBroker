# FIXYL Quick - FIX Protocol Client

A Flutter-based FIX protocol client application for macOS and Windows, designed for trading and financial messaging.

## Features

- **FIX 4.2 Protocol Support**: Full implementation of FIX 4.2 standard
- **Multiple Message Types**: Support for Logon, New Order Single, Security Definition Request, Order Cancel Request
- **Real-time Message Monitoring**: View sent/received FIX messages with field parsing
- **External Configuration**: JSON-based configuration for easy deployment
- **Cross-platform**: Supports macOS and Windows
- **Custom Logo Integration**: Personalized app branding

## Setup Instructions

### Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK
- macOS (for macOS builds) or Windows (for Windows builds)
- Git

### Installation

1. **Clone the repository**:
   ```bash
   git clone <your-gitlab-repo-url>
   cd mini-broker
   ```

2. **Install Flutter dependencies**:
   ```bash
   flutter pub get
   ```

3. **Create your configuration file**:
   ```bash
   cp Config.template.json Config.json
   ```

4. **Edit Config.json** with your FIX server details:
   - Update `ipAddress` and `port` for your FIX servers
   - Set your `senderCompID`, `targetCompID`, and `account` values
   - Modify `messageDefaults` as needed for your trading requirements
   - Update `RawData` with your authentication token

### Building

#### macOS Build
```bash
flutter build macos --release
```

#### Windows Build
```bash
flutter build windows --release
```

### Deployment

1. **Copy the built application** from `build/macos/Build/Products/Release/` or `build/windows/runner/Release/`
2. **Place Config.json** beside the application executable
3. **Ensure FIX42.xml** is included in the assets folder

## Configuration

The application uses an external `Config.json` file that must be placed beside the executable. This allows for easy configuration changes without rebuilding the app.

### Config.json Structure

```json
{
  "configurations": {
    "FIX.4.2": {
      "fixVersion": "FIX.4.2",
      "dictionaryLocation": "assets/FIX42.xml",
      "environments": {
        "DEV": {
          "name": "FIX.4.2-DEV",
          "ipAddress": "127.0.0.1",
          "port": 5001,
          "hbInterval": 30,
          "senderCompID": "YOUR_SENDER_ID",
          "targetCompID": "YOUR_TARGET_ID",
          "account": "YOUR_ACCOUNT"
        }
      },
      "messageDefaults": {
        "Logon": {
          "EncryptMethod": "0",
          "HeartBtInt": "30",
          "RawData": "{\"provider\":\"your_provider\",\"auth_token_type\":\"jwt\",\"auth_token\":\"your_token\"}",
          "ResetSeqNumFlag": "Y"
        }
      }
    }
  }
}
```

## Usage

1. **Launch the application**
2. **Select your environment** (DEV/Staging)
3. **Click Connect** to establish FIX connection
4. **Send messages** using the FIX Messages section
5. **Monitor traffic** in the Message Monitor panel

## Project Structure

```
lib/
├── config/
│   └── environment_config.dart    # Configuration management
├── models/
│   ├── config_model.dart         # Configuration data models
│   └── fix_definitions.dart      # FIX message definitions
├── screens/
│   ├── home_page.dart            # Main application screen
│   ├── logon_page.dart           # Logon message screen
│   ├── new_order_single_page.dart # New Order Single screen
│   ├── security_definition_request_page.dart
│   └── logout_page.dart          # Logout message screen
├── services/
│   ├── fix_client_service.dart   # FIX protocol client
│   └── fix_dictionary_parser.dart # FIX dictionary parser
├── widgets/
│   └── fix_message_form.dart     # Reusable message form
└── main.dart                     # Application entry point
```

## Development

### Adding New Message Types

1. Add message definition to `models/fix_definitions.dart`
2. Create new screen in `screens/` folder
3. Add message defaults to Config.json
4. Update field mapping in `home_page.dart`

### Customizing Logo

Replace `logo.png` in the root directory and run:
```bash
./convert_icon.sh
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and questions, please create an issue in the GitLab repository.
