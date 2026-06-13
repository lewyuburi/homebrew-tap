cask "crane" do
  version "0.1.0"
  sha256 "463ccdbaf6f59083f2b610a3b2d43ec19afcc520735064612bc1bf3202031868"

  url "https://github.com/lewyuburi/crane/releases/download/v#{version}/Crane.zip"
  name "Crane"
  desc "Native macOS GUI for Apple's container tool"
  homepage "https://github.com/lewyuburi/crane"

  depends_on macos: ">= :tahoe" # macOS 26

  app "Crane.app"

  # Ad-hoc-signed build: strip quarantine so it launches without the "damaged" prompt.
  # Remove once releases are Developer-ID notarized.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Crane.app"]
  end

  zap trash: [
    "~/Library/Application Support/Crane",
    "~/Library/Preferences/dev.crane.Crane.plist",
  ]
end
