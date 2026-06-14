cask "crane" do
  version "0.1.5"
  sha256 "6e4df424a8e8b1018a909f2761fe27a8193e1a829140fa28d260b90f6f29ec51"

  url "https://github.com/lewyuburi/crane/releases/download/v#{version}/Crane-#{version}-arm64.dmg"
  name "Crane"
  desc "Native macOS GUI for Apple's container tool"
  homepage "https://github.com/lewyuburi/crane"

  depends_on macos: :tahoe # macOS 26+
  depends_on arch: :arm64  # Apple container is Apple Silicon only

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
