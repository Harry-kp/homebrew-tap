cask "mercury" do
  version "0.2.1"
  sha256 "4f73b5ed3fe0ab2944e2ff17d62fbd032743e20f88c93fc7e42ad261c429322c"

  url "https://github.com/Harry-kp/mercury/releases/download/v#{version}/Mercury-v#{version}-universal-apple-darwin.tar.gz"
  name "Mercury"
  desc "Fast, minimal API client for developers"
  homepage "https://harry-kp.github.io/mercury"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "Mercury.app"

  zap trash: [
    "~/Library/Application Support/mercury",
    "~/Library/Caches/com.mercury.app",
    "~/Library/Preferences/com.mercury.app.plist",
    "~/Library/Saved Application State/com.mercury.app.savedState",
  ]
end
