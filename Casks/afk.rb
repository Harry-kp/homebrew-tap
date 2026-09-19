cask "afk" do
  version "1.1.1"
  sha256 "0e48716a6d3a0e54eb46a6eea3a217196b401c2fb898bb4448a7d0e2e437571f"

  url "https://github.com/Harry-kp/afk/releases/download/v#{version}/Afk_#{version}_universal.dmg"
  name "Afk"
  desc "Break reminder app - step away from your keyboard"
  homepage "https://afk-app.vercel.app"

  livecheck do
    url :url
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
