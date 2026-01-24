cask "afk" do
  version "1.0.0"
  sha256 :no_check  # Auto-updated by workflow

  url "https://github.com/Harry-kp/afk-releases/releases/download/v1.0.0/Afk_1.0.0_universal.dmg"
  name "AFK"
  desc "Break reminder app - step away from your keyboard"
  homepage "https://afk-app.vercel.app"

  livecheck do
    url "https://github.com/Harry-kp/afk-releases/releases/download/v1.0.0/Afk_1.0.0_universal.dmg"
    strategy :github_latest
  end

  app "Afk.app"

  zap trash: [
    "~/Library/Application Support/com.afk.app",
    "~/Library/Caches/com.afk.app",
    "~/Library/Preferences/com.afk.app.plist",
    "~/Library/Saved Application State/com.afk.app.savedState",
  ]
end
