

// ==UserScript==
// @name           delicious-delete-links
// @include        http://delicious.com/*
// ==/UserScript==

(function(){
  var tds = document.getElementsByClassName('link  None');
  for(var i in tds)
{
  var point = tds[i].childNodes[1].innerHTML.indexOf('http://mmm1');
  if (point != -1){
  var  matched = tds[i].childNodes[1].parentNode;
  while(matched.firstChild){
  matched.removeChild(matched.firstChild);
  }
  }
}

})();


