cask "mercury" do
  version "0.2.1"
  sha256 :no_check # TODO: Update with SHA256 from workflow logs after v0.2.1 release completes

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
