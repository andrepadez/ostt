# frozen_string_literal: true

class Ostt < Formula
  desc "Open Speech-to-Text: Terminal application for recording and transcribing audio"
  homepage "https://github.com/kristoferlund/ostt"
  license "MIT"
  version "0.0.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/kristoferlund/ostt/releases/download/v#{version}/ostt-aarch64-apple-darwin.tar.gz"
      sha256 "SKIP"
    else
      url "https://github.com/kristoferlund/ostt/releases/download/v#{version}/ostt-x86_64-apple-darwin.tar.gz"
      sha256 "SKIP"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/kristoferlund/ostt/releases/download/v#{version}/ostt-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "SKIP"
    else
      url "https://github.com/kristoferlund/ostt/releases/download/v#{version}/ostt-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "SKIP"
    end
  end

  depends_on "openssl"
  depends_on "ffmpeg"
  
  on_linux do
    depends_on "alsa-lib"
  end

  def install
    # Extract architecture-specific directory from archive
    arch_dir = if OS.mac?
                 if Hardware::CPU.arm?
                   "ostt-aarch64-apple-darwin"
                 else
                   "ostt-x86_64-apple-darwin"
                 end
               else
                 if Hardware::CPU.arm?
                   "ostt-aarch64-unknown-linux-gnu"
                 else
                   "ostt-x86_64-unknown-linux-gnu"
                 end
               end

    # Install the main binary
    bin.install "#{arch_dir}/ostt"

    # Install documentation
    doc.install "#{arch_dir}/README.md"
  end

  def post_install
    puts ""
    puts "ostt has been successfully installed!"
    puts ""
    puts "Getting started:"
    puts "  1. Configure API credentials:"
    puts "     ostt auth"
    puts ""
    puts "  2. Start recording and transcribing:"
    puts "     ostt"
    puts ""
    puts "  3. View command history:"
    puts "     ostt history"
    puts ""
    puts "Configuration:"
    puts "  - Config: ~/.config/ostt/"
    puts "  - Data: ~/.local/share/ostt/"
    puts "  - Logs: ~/.local/state/ostt/"
    puts ""
    puts "Note: On first run, ostt will automatically set up configuration"
    puts "      files. Hyprland users will get WM integration files created"
    puts "      automatically in ~/.config/ostt/ and ~/.local/bin/"
    puts ""
    if OS.linux?
      puts "Linux users: Install clipboard support (wl-clipboard or xclip)"
      puts ""
    end
  end

  test do
    # Test that the binary exists and can show help
    system "#{bin}/ostt", "help"
  end
end
