#Requires AutoHotkey v2.0

#q:: { ; Super (Windows key) + Q
    Run("wezterm-gui.exe") ; Runs thm Window Terminal with WSL
}

#+q:: { ; Super (Windows key) + Shift + Q
    Run("chrome.exe") ; Runs Firefox
}

#p:: {
    ; Run PowerShell with the working directory set
    Run("powershell.exe -NoExit -Command cd C:\Users\abailey\Developer")

}
