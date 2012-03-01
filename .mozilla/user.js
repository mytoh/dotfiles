// settings from these urls
// http://d.hatena.ne.jp/k_hanazuki/20110310/1299749396

// move favicon to statusline
// let statusline = document.getElementById("liberator-statusline");
// let (favicon = document.getElementById("page-proxy-stack")) {
//   favicon.style.maxWidth = favicon.style.maxHeight = "16px"
//   statusline.insertBefore(favicon, statusline.firstChild);
// }

// pref.js
user_pref("browser.cache.memory.enable", true);
user_pref("browser.cache.memory.capacity", 65536);
user_pref("browser.sessionhistory.max_total_viewers", 0);
user_pref("content.interrupt.parsing", true);
user_pref("content.max.tokenizing.time", 2250000);
user_pref("content.notify.backoffcount", 5);
user_pref("content.notify.interval", 750000);
user_pref("content.notify.ontimer", true);
user_pref("content.switch.threshold", 750000);
user_pref("mousewheel.withcontrolkey.action", 0);
user_pref("network.dns.disableIPv6", true);
user_pref("network.http.max-connections", 32);
user_pref("network.http.max-connections-per-server", 8);
user_pref("network.http.max-persistent-connections-per-server", 4); 
user_pref("network.http.pipelining", true);
user_pref("network.http.pipelining.firstrequest", true);
user_pref("network.http.pipelining.maxrequests", 8);
user_pref("nglayout.initialpaint.delay", 0);
user_pref("plugin.expose_full_path", true);
user_pref("ui.submenuDelay", 0);
user_pref("ui.key.contentAccess", 5);
user_pref("font.scale.aa_bitmap.enable",false);
user_pref("fonts.xft.enabled",false);
user_pref("extensions.checkCompatibility.nightly",false);
user_pref("extensions.checkCompatibility.8.0",false);
user_pref("extensions.checkCompatibility.9.0",false);
user_pref("browser.fullscreen.autohide", false);
user_pref("browser.fullscreen.animateUp", 0);
user_pref("network.http.spdy.enabled", true);
user_pref("config.trim_on_minimize", true);
user_pref("dom.popup_allowed_events", "");
user_pref("ui.key.menuAccessKey", 0);
// user_pref("accessibility.typeaheadfind.enablesound", false);
// user_pref("accessibility.typeaheadfind.soundURL", "");
user_pref("dom.max_script_run_time", 9999999999999);
user_pref("dom.event.contextmenu.enabled", false);
user_pref("view_source.wrap_long_lines", true);
user_pref("middlemouse.scrollbarPosition", true);
user_pref("xpinstall.whitelist.required", false);
