<html>
  <!-- Copyright (c) 1999-2007 webMethods Inc. -->
  <!-- Copyright (c) 2007-2014 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. -->
  <!-- Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. -->

  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="-1">
    <title>webMethods Logging Utility Administration Menu</title>
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <base target="_self">
    <style>
      .listbox { width: 100%; }
      body { border-top: 1px solid #97A6CB; }
    </style>
    <script src="logger.js"></script>
  </head>


  <body class="menu" onload="initMenu('manage.dsp');setNavigation('menu.dsp', 'help.dsp');">
    <table width="100%" cellspacing=0 cellpadding=1 border=0>


<!-- ----------------------------------------------------------- -->
<!-- ----------------------------------------------------------- -->
<!-- The below section adds the Administration menu section.     -->
     <tr>
        <td class="menusection-Server">
          <img src="images/blank.gif" width="4" height="1" border="0">Administration
        </td>
      </tr>

      <tr>
        <td id="imanage.dsp"
          class="menuitem"
          onmouseover="menuMouseOver(this, 'manage.dsp');"
          onmouseout="menuMouseOut(this);"
          onclick="document.all['amanage.dsp'].click();"
          <nobr>
            <img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
            <img valign="middle" id="manage.dsp" name="manage.dsp" src="images/blank.gif"
              height="8" width="8" border="0">
            <a id="amanage.dsp" target='loggingUtilityBody' href="manage.dsp?action=none"
               onclick="return menuClick('manage.dsp', 'loggingUtilityBody')"><span class="menuitemspan">Manage</span></a>
          </nobr>
        </td>
      </tr>

      <tr>
        <td class="menuseparator"><img src="images/blank.gif" width="3" height="3" border="0"></td>
      </tr>
<!-- ----------------------------------------------------------- -->
<!-- ----------------------------------------------------------- -->



<!-- ----------------------------------------------------------- -->
<!-- ----------------------------------------------------------- -->
<!-- The below section adds the Settings menu section.           -->
      <tr>
        <td class="menusection-Settings">
          <img src="images/blank.gif" width="4" height="1" border="0">Settings
        </td>
      </tr>

      <tr>
        <td id="configure.dsp"
          class="menuitem"
          onmouseover="menuMouseOver(this, 'configure.dsp');"
          onmouseout="menuMouseOut(this);"
          onclick="document.all['aconfigure.dsp'].click();"
          <nobr>
            <img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
            <img valign="middle" id="configure.dsp" name="configure.dsp" src="images/blank.gif"
              height="8" width="8" border="0">
            <a id="aconfigure.dsp" target='loggingUtilityBody' href="configure.dsp?action=none"
               onclick="return menuClick('configure.dsp', 'loggingUtilityBody')"><span class="menuitemspan">Configure</span></a>
          </nobr>
        </td>
      </tr>

      <tr>
        <td class="menuseparator"><img src="images/blank.gif" width="3" height="3" border="0"></td>
      </tr>
    </table>
  </body>
</html>
