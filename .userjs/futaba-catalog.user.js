// ==UserScript==
// @name           futaba-catalog
// @include        http://jun.2chan.net/b/*
// ==/UserScript==

(function(){
 var tds = document.getElementsByTagName('td');
 for(var i in tds)
 {
   var threadId = document.createElement('span');
   threadId.setAttribute('class','threadId');
   threadId.innerHTML = ':' + tds[i].childNodes[0].getAttribute('href').match(/\d+/)
   tds[i].insertBefore((threadId);
  }
})();


