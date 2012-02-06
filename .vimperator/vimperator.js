// settings from these urls
// http://d.hatena.ne.jp/k_hanazuki/20110310/1299749396

// move favicon to statusline
let statusline = document.getElementById("liberator-statusline");
let (favicon = document.getElementById("page-proxy-stack")) {
  favicon.style.maxWidth = favicon.style.maxHeight = "16px"
  statusline.insertBefore(favicon, statusline.firstChild);
}

// pref.js
options.setPref("browser.cache.memory.enable", true);
options.setPref("browser.cache.memory.capacity", 65536);
options.setPref("browser.sessionhistory.max_total_viewers", 0);
options.setPref("content.interrupt.parsing", true);
options.setPref("content.max.tokenizing.time", 2250000);
options.setPref("content.notify.backoffcount", 5);
options.setPref("content.notify.interval", 750000);
options.setPref("content.notify.ontimer", true);
options.setPref("content.switch.threshold", 750000);
options.setPref("mousewheel.withcontrolkey.action", 0);
options.setPref("network.dns.disableIPv6", true);
options.setPref("network.http.max-connections", 32);
options.setPref("network.http.max-connections-per-server", 8);
options.setPref("network.http.max-persistent-connections-per-server", 4); 
options.setPref("network.http.pipelining", true);
options.setPref("network.http.pipelining.firstrequest", true);
options.setPref("network.http.pipelining.maxrequests", 8);
options.setPref("nglayout.initialpaint.delay", 0);
options.setPref("plugin.expose_full_path", true);
options.setPref("ui.submenuDelay", 0);
options.setPref("ui.key.contentAccess", 5);
options.setPref("font.scale.aa_bitmap.enable",false);
options.setPref("fonts.xft.enabled",false);
options.setPref("extensions.checkCompatibility.nightly",false);
options.setPref("extensions.checkCompatibility.8.0",false);
options.setPref("extensions.checkCompatibility.9.0",false);
options.setPref("browser.fullscreen.autohide", false);
options.setPref("browser.fullscreen.animateUp", 0);
options.setPref("network.http.spdy.enabled", true);
options.setPref("config.trim_on_minimize", true);
options.setPref("dom.popup_allowed_events", "");
options.setPref("ui.key.menuAccessKey", 0);

