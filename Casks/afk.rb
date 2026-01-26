cask "afk" do
  version "1.1.0"
  sha256 "c7ba83dcad924473d81578980f4b1857afc07b692a1a5ec63ca72bbe63b454a0"

  url "https://github.com/Harry-kp/afk-releases/releases/download/v#{version}/Afk_#{version}_universal.dmg"
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
