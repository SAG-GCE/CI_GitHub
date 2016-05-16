/*
 * Copyright (c) 2000, webMethods Inc.  All Rights Reserved.
 */

var previousMenuImage;

function adapterMenuClick(url, help){
  moveArrow(url);
  document.forms["urlsaver"].helpURL.value = help;
  return false;
}

function tdClick(thisTD, id)
{
  alert(thisTD.all);
  thisTD.all[id].click();
}

function menuClick(url, target) {


  switch (target) {
    case "rightFrame":
  	  parent[target].window.location.href= url;
	  break;
    default:   
          window.open(url, target, "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes");
	  break;
  }

  menuMove(url, target);

  return false;
}


function menuMove(url, target) {

  if (target=="rightFrame")
  	moveArrow(url);

}

function IE() {
	if (navigator.appName == "Microsoft Internet Explorer")
		return true;
	return false;

}

function menuMouseOver(object, id) {
	menuext.mouseOver(object, id, selected);
}

function menuMouseOut(object, id) {
	menuext.mouseOut(object, id, selected);
}


function setMenuItem(rootid, bgcolor, color) {
    /* the td element */
    var tdobj = document.getElementById( rootid);
    tdobj.style.backgroundColor = bgcolor;

    /* the a element within the td element above */
    var aobj = document.getElementById(rootid);
    aobj.style.color = color;
}

function defaultSelectedColor() {
	document.getElementById("Projects").style.backgroundColor = "#8cceee";
	selected = "Projects";
}

(function(exports) {
	  exports.select = function(object, id, selected) {
	    if (selected != null) {
	        setMenuItem(selected, "#fff", "#2e5e83");
	    }
	    setMenuItem(id, "#8cceee", "#fff");
	    window.status = id;
	    return id;
	  };

	  exports.mouseOver = function(object, id, selected) {
		  if (id != selected) {
	        setMenuItem(id, "#cde7f6", "#333");
	    }
	    window.status = id;
	  };

	  exports.mouseOut = function(object, id, selected) {
	    if (id != selected) {
	        setMenuItem(id, "#fff", "#2e5e83");
	    }
	    window.status = "";
	  };
	})(this.menuext = {});

/*function moveArrow(item)
{
  if(previousMenuImage != null) previousMenuImage.src="images/blank.gif";
  var temp = previousMenuImage;
  previousMenuImage=document.images[item];
  if(previousMenuImage == null) previousMenuImage = temp;
  previousMenuImage.src="images/selectedarrow.gif";
}*/


function initMenu(firstImage)
{
	previousMenuImage = document.images[firstImage];
	previousMenuImage.src="images/selectedarrow.gif";
	return true;
}
