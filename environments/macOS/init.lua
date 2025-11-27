-- === Config ===
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

	-- Remember the currently focused app to restore later (optional)
	local frontApp = hs.application.frontmostApplication()

	-- Start Ghostty running OSTT with window-position/size flags
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
