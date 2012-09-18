// ==UserScript==
// @name           futaba-catalog
// @include        http://jun.2chan.net/b/*
// @include        http://may.2chan.net/b/*
// ==/UserScript==



(function(){
 var tds = document.getElementsByTagName('td');
 for(var i in tds)
 {
   var threadId = document.createElement('span');
   threadId.setAttribute('class','threadid');
   threadId.innerHTML = ':' + tds[i].childNodes[0].getAttribute('href').match(/\d+/);
   tds[i].appendChild(threadId);
  }

 // reload page every 1 minute
 setTimeout("location.reload()", 60000);


})();


