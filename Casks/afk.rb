cask "afk" do
  version "1.0.0"
  sha256 "5507706598fb9354c65a0b0bfde71cde2a322adf6bd97ccba48a9570e9328481"

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
