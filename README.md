# Homebrew Tap

Official Homebrew tap for developer tools by Harry-kp.

## Apps

### 🚀 Mercury - API Client
A fast, minimal API client built with Rust. Native performance, 60fps UI, zero subscriptions.

```bash
brew install --cask mercury
```

[Documentation](https://harry-kp.github.io/mercury) • [GitHub](https://github.com/Harry-kp/mercury)

### ⏸️ AFK - Break Reminder
Take regular breaks while coding to reduce eye strain and stay focused.

```bash
brew install --cask afk
```

[Website](https://afk-app.vercel.app) • [GitHub](https://github.com/Harry-kp/afk)

## Quick Start

Add the tap and install any app:

```bash
# Add the tap (only needed once)
brew tap Harry-kp/tap

# Install apps
brew install --cask mercury
brew install --cask afk
```

## Updating

```bash
brew upgrade --cask mercury
brew upgrade --cask afk
```

## Uninstalling

```bash
brew uninstall --cask mercury
brew uninstall --cask afk
```

## First Launch Notes

Since these apps aren't notarized through Apple's App Store, macOS may show a security warning on first launch:

1. **Right-click** the app → **Open** → **Open**
2. Or go to **System Settings** → **Privacy & Security** → Click **"Open Anyway"**

You only need to do this once per app.

Alternatively, you can run:
```bash
xattr -cr /Applications/Mercury.app
xattr -cr /Applications/Afk.app
```

## About

This tap hosts macOS apps built with modern technologies:
- **Mercury**: Rust + GPU acceleration
- **AFK**: Native macOS app

All apps are free, open source, and built with care for developer experience.
