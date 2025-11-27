# macOS - Hammerspoon Popup Integration

## About Hammerspoon

[Hammerspoon](https://www.hammerspoon.org/) is a powerful, well-established open-source automation tool for macOS. It allows you to control your Mac using Lua scripts, enabling deep system integration and custom workflows. Hammerspoon has been actively maintained for years and is trusted by thousands of macOS power users.

With ostt integrated via Hammerspoon, you get instant voice-to-text transcription accessible from any application through a global hotkey.

**Alternative:** If you use [iTerm2](https://iterm2.com/), you can achieve similar functionality using its built-in [Hotkey Window](https://iterm2.com/features.html) feature without needing Hammerspoon.

## Setup

### Prerequisites

1. **Install Hammerspoon:**
   - Download from [hammerspoon.org](https://www.hammerspoon.org/)
   - Or install via Homebrew: `brew install --cask hammerspoon`

2. **Install ostt:**
   ```bash
   brew install kristoferlund/ostt/ostt
   ```

3. **Install Ghostty terminal:**
   - Download from [ghostty.org](https://ghostty.org/)
   - Follow the installation instructions on their website

### One-Time Configuration

1. **Launch Hammerspoon** - It will appear in your menu bar
2. **Open Hammerspoon config** - Click the Hammerspoon menu bar icon → "Open Config"
3. **Add the following to your `init.lua`:**

```lua
-- === ostt Configuration ===
local OSTT_BIN = "/opt/homebrew/bin/ostt"
local GHOSTTY_BIN = "/Applications/Ghostty.app/Contents/MacOS/ghostty"

local function osttExists()
	local attr = hs.fs.attributes(OSTT_BIN)
	return attr ~= nil and attr.mode == "file"
end

local function spawnOsttPopup()
	if not osttExists() then
		hs.alert.show("OSTT not found or not executable:\n" .. OSTT_BIN)
		return
	end

	-- Remember the currently focused app to restore later
	local frontApp = hs.application.frontmostApplication()

	-- Start Ghostty running OSTT with window position/size flags
	local task = hs.task.new(GHOSTTY_BIN, function(exitCode, stdOut, stdErr)
		-- When Ghostty/OSTT exits, go back to the previous app
		if frontApp then
			frontApp:activate()
		end
	end, {
		"--window-position-x=630",
		"--window-position-y=790",
		"--window-width=50",
		"--window-height=10",
		"--font-size=8",
		"--background=#000000",
		"--window-decoration=none",
		"--macos-window-shadow=false",
		"-e",
		OSTT_BIN,
	})

	task:start()
end

-- Hotkey: Cmd+Shift+R
hs.hotkey.bind({ "cmd", "shift" }, "R", spawnOsttPopup)
```

4. **Reload Hammerspoon** - Click the menu bar icon → "Reload Config"

That's it!

## Usage

1. **Press `Cmd+Shift+R`**: Opens ostt in a popup window and starts recording
2. **Speak your text**: Watch the real-time waveform visualization
3. **Press `Enter`**: Stops recording, transcribes, and copies to clipboard
4. **Press `Cmd+V`**: Paste the transcribed text anywhere

## Customization

### Window Position and Size

Adjust the window parameters in `init.lua`:

```lua
{
	"--window-position-x=630",  -- Horizontal position (pixels from left)
	"--window-position-y=790",  -- Vertical position (pixels from top)
	"--window-width=50",        -- Width in columns
	"--window-height=10",       -- Height in rows
	"--font-size=8",            -- Font size
	-- ...
}
```

**Note:** These values are static and don't adapt to different screen sizes. Adjust based on your display resolution.

### Different Hotkey

Change the hotkey binding in `init.lua`:

```lua
-- Example: Use Ctrl+Alt+R instead
hs.hotkey.bind({ "ctrl", "alt" }, "R", spawnOsttPopup)
```

## Troubleshooting

### Popup Not Appearing

```bash
# Check if ostt is installed at the expected path
ls -l /opt/homebrew/bin/ostt

# Check Hammerspoon console for errors
# Click Hammerspoon menu bar icon → Console
```

### Wrong ostt Path

If ostt is installed elsewhere (e.g., via shell installer):

```bash
# Find ostt location
which ostt

# Update OSTT_BIN in init.lua with the correct path
```

### Popup Not Working with Full-Screen Apps

Due to macOS window manager limitations, full-screen apps run in their own Space, preventing other windows from appearing on top. Consider using ostt in a regular terminal window or switching out of full-screen mode when needed.
