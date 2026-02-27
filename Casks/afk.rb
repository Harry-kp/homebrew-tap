cask "afk" do
  version "1.1.0"
  sha256 "980007839985a240cb1a46b892596db1c4ae88caca42c564f09b953538ef39de"

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
