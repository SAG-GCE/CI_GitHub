<html>
  <!-- Copyright (c) 1999-2007 webMethods Inc. -->
  <!-- Copyright (c) 2007-2014 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. -->
  <!-- Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. -->

  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="-1">
    <title>webMethods Logging Utility Administration Top</title>
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <base target="_self">
    <style>
      .listbox { width: 100%; }
      body { border-top: 1px solid solid black; }
    </style>
  </head>


  <body class="menu" leftMargin=0 topMargin=0 marginwidth="0" marginheight="0">

    <table border=0 cellspacing=0 cellpadding=0 height=100% width=100%>
      <tr>
	<td>
	  <table width=100% cellspacing=0 border=0>
            <tr>
              <td nowrap class="toptitle" width="100%">
               %value $host%
	       ::
	       Integration Server
               ::
	       Logging Utility
              </td>              
            </tr>
	  </table>
	</td>
      </tr>
      <tr height=100%>
	<td>
	  <table width=100% cellspacing=0 border=0>
            <tr>
              %ifvar message%
                <td colspan="2">
		  <FONT class="topmessage">
                    %value message%
		  </FONT>
              	</td>
              %else%
                <td></td>
              %endif%
            </tr>
            <tr>
              <td nowrap class="topmenu">
		  <A  href='javascript:window.parent.close();'>Close Window</A>
               	    <!-- MGN: Keep this in case you want to add help/about/info | <a target='loggingUtilityBody' href='about.dsp'>
		    About</a> -->
              </td>
            </tr>
            <tr></tr>
	  </table>
	</td>
      </tr>
    </table>

  </body>
</html>
