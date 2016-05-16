/*
 * Copyright (c) 1999-2007 webMethods Inc.
 * Copyright (c) 2007-2014 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.
 *
 * Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG.
 */

var row = "even";
var other = "odd";
var swap = "";

var path1 = "";
var menu1 = "";
var path1_class = "";


var normal = 1;
var error  = 2;
var serverkey = 4;


function w(text)
{
  document.write(text);
}


function pathInit(css_class)
{
  path1 = "";
  path1_class = css_class;
  
}

function pathAdd(text, url)
{
  path1 += text;
  path1 += " &gt; ";
}

function pathShow()
{
  w("<table width=100% >");
  w("<tr>");
  w("<td class=" + path1_class + ">");
  w(path1);
  w("</td></tr></table>");
}


function menuInit()
{
  menu1 = "";
  
}


function menuAdd(text, url, bonus_text)
{
  menu1 += "<li>";
  menu1 += "<a href=\"" + url + "\">" + text + "</a>";
  if (bonus_text)
  {
    menu1 += "<br>"
    menu1 += bonus_text;
  }
  menu1 += "</li>";

}


function menuShow()
{
  w("<table width=100% >");
  w("<tr>");
  w("<td>");  //class=\"submenu\"
  w("<ul>");
  w(menu1);
  w("</ul>");
  w("</td></tr></table>");

}



function messageInit()
{
  message1 = "";
  
}


function messageAdd(text, message_type)
{
  menu1 += text;

}


function messageShow()
{
  w("<table width=100% >");
  w("<tr>");
  w("<td class=\"message\">");
  w(menu1);
  w("</td>");
  w("</tr>");
  w("</table>");
}



function writeEditPass(mode, name, value)
{
  if(mode == 'edit')
  {
    w("<input type=\"pass\" name=\""+name+"\" value=\""+value+"\">");
  }
  else
  {
    if(value == "")
      value = "(unspecified)";
    w(value);
  }
}

function writeEdit(mode, name, value)
{
  if(mode == 'edit')
  {
    w("<input type=\"text\" name=\""+name+"\" value=\""+value+"\">");
  }
  else
  {
    if(value == "")
      value = "(unspecified)";
    w(value);
  }
}

function writeEditCheckbox(mode, name, checked)
{
  if(mode == 'edit') {
    var checkString = " checked ";
      if (checked != 'true') {
        checkString = "";
      }

    w("<input type=\"checkbox\" name=\"" + name + "\"" + checkString + ">");
  }
  else {
    // VAN: i18n work is required here for "yes" and "no"
    var checkString = "yes";
    if (checked != 'true' && checked != 'on') { // KNUT: also accept 'on' 
      checkString = "no";
    }
    w(checkString);
  }
}

/*** KNUT ***/
/*
 * SelectionBox
 * In edit mode additional arguments are used as selection options
 */
function writeEditSelectionBox(mode, name, selected)
{
  if (mode == 'edit') {
    if (arguments.length > 3) {
      var select = "<select name=\"name\" size=1>";
      for (i = 3; i < arguments.length; i++) {
  select += "<option";
  if (selected == arguments[i])
    select += " selected";

  select += " value=\"" + arguments[i] + "\">" + arguments[i] + "</option>";
      }
      w(select + "</select>");
    }
  } else
    w(selected);
}

function writeMessage(msg)
{
  w("<TR><TD class=\"message\" colspan=2>&nbsp;&nbsp;&nbsp;&nbsp;"+msg+"</TD></TR>");
}

function reloadTopFrame()
{
  parent.topmenu.location.replace("top.dsp");
}

function writeTD (c)
{
  w("<TD CLASS=\"");
  w(row);
  w(c);
  w("\">");
  return true;
}

function writeTDnowrap (c)
{
  w("<TD NOWRAP CLASS=\"");
  w(row);
  w(c);
  w("\">");
  return true;
}

function writeTDspan(c,span)
{
  w("<TD CLASS=\"");
  w(row);
  w(c);
  w("\" COLSPAN=");
  w(span);
  w(">");
}

function writeTDrowspan(c,span,valign)
{
  w("<TD CLASS=\"");
  w(row);
  w(c);
  w("\" ROWSPAN=\"");
  w(span);
  w("\" VALIGN=\"");
  w(valign);
  w("\">");
}

function writeEndTD()
{
  w("</TD>");
}

function swapRows()
{
  swap = row;
  row = other;
  other = swap;
}

function resetRows()
{
  row = "even";
  other = "odd";
  swap = "";
}



function verifyRequiredField(form, field)
{
  if (document.forms[form][field].value == "")
  {
    document.forms[form][field].focus();
    return false;
  }
  return true;
 }


function verifyRequiredFieldList(form, fieldList)
{
  for (index in fieldList)
  {
     if (!verifyRequiredField(form, fieldList[index]))
     {
      alert ("Error: The selected field requires valid data.");
      return false;
     }
  }
  return true;
 }

function verifyFieldsEqual(form, field1, field2)
{
  if (document.forms[form][field1].value != document.forms[form][field2].value)
  {
    alert("Error: Fields must have the same value.  Try typing them in again.");
    document.forms[form][field1].focus();
    return false;
  }
  return true;
}

function setNavigation(doc_url, help_url, is_doc)
{

  if(parent == null || parent.frames == null || parent.frames.menu == null || parent.frames.menu.document == null)
    return false;

  if(parent.frames.menu != null)
  {
    if(is_doc != null) parent.frames.menu.moveArrow(doc_url);
    else
    parent.frames.menu.moveArrow(doc_url+location.search);
  }

  if(parent.frames.menu.document.forms["urlsaver"] != null && parent.frames.menu.document.forms["urlsaver"].helpURL != null)
    parent.frames.menu.document.forms["urlsaver"].helpURL.value = help_url;
  
  return true;
}  


/*
 * Debugging
 */

var dwin = null; 

function debug(msg) { 
  if ((dwin == null) || (dwin.closed)) {  
    dwin = window.open("","debug_console","scrollbars=yes,resizable=yes,height=100,width=300"); 
    dwin.document.open("text/plain"); 
  } 
  dwin.document.writeln(msg); 
  dwin.scrollTo(0,10000); 
  // dwin.document.close();  // uncomment this to see only last message
}




var previousMenuImage = null;
var menuInitFlag = false;


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


  switch (target)
  {

    case "body":
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

  //if (target=="body")
    moveArrow(url);

}

function IE() {
  if (navigator.appName == "Microsoft Internet Explorer")
    return true;
  return false;

}

function menuMouseOver(object, id) {
  object.style.background='#FFFFFF';
  window.status= id;
}

function menuMouseOut(object) {
  object.style.background='#F0ECDA';
  window.status='';

}

function moveArrow(item)
{
  if(menuInitFlag == true)
  {
      if(previousMenuImage != null)
        previousMenuImage.src="images/blank.gif";

      var temp = previousMenuImage;
      previousMenuImage=document.images[item];

      if(previousMenuImage == null) 
        previousMenuImage = temp;

      previousMenuImage.src="images/selectedarrow.gif";
  }
}


function initMenu(firstImage)
{

  previousMenuImage = document.images[firstImage];
  previousMenuImage.src = "images/selectedarrow.gif";
  menuInitFlag = true;

  return true;
}
