<HTML>
  <!-- Copyright (c) 1999-2007 webMethods Inc. -->
  <!-- Copyright (c) 2007-2014 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. -->
  <!-- Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. -->

  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="-1">
    <title>webMethods Logging Utility Administration Manage</title>
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <base target="_self">
    <style>
      .listbox { width: 100%; }
    </style>
    <script src="logger.js"></script>
  </head>


<BODY>
  <table width="100%">
  <tr>
    <td class="menusection-Settings" colspan=2>Administration &gt Manage</td>
  </tr>


<!-- -------------------------------------------------------------------- -->
<!-- -------------------------------------------------------------------- -->
<!-- This block of code conditionally executes the administration methods -->
<!-- based upon the input parameter labeled action.                       -->
  %ifvar action%
    %ifvar action -notempty%
      %switch action%
        %case 'Start'%
          %invoke wm.loggingUtility:start%
          %endinvoke%
        %case 'Stop'%
          %invoke wm.loggingUtility:stop%
          %endinvoke%
        %case 'Suspend'%
          %invoke wm.loggingUtility:suspend%
          %endinvoke%
        %case 'Resume'%
          %invoke wm.loggingUtility:resume%
          %endinvoke%
        %case 'DebugOn'%
          %invoke wm.loggingUtility:setDebug%
          %endinvoke%
        %case 'DebugOff'%
          %invoke wm.loggingUtility:setDebug%
          %endinvoke%
        %case 'Refresh'%
          %comment%
            Do nothing
          %end comment%
      %endswitch%
    %endifvar%
  %endifvar%
<!-- -------------------------------------------------------------------- -->
<!-- -------------------------------------------------------------------- -->


<!-- -------------------------------------------------------------------- -->
<!-- -------------------------------------------------------------------- -->
<!-- This block of code creates the Extractor Administration manager      -->
<!-- method invocations as links.  We also set an action parameter when   -->
<!-- the methods are invoked.                                             -->
  <tr>
    <td valign="top">
      <ul>
        %invoke wm.loggingUtility:status%
          %ifvar Status equals('Running')%
              <li>Start</li>
              <li><a id="astop" target='loggingUtilityBody' href="manage.dsp?action=Stop">Stop</a></li>
              <li><a id="asuspend" target='loggingUtilityBody' href="manage.dsp?action=Suspend">Suspend</a></li>
              <li>Resume</li>
              <li><a id="arefresh" target='loggingUtilityBody' href="manage.dsp?action=Refresh">Refresh Status</a></li>
          %endif%
          %ifvar Status equals('Stopped')%
              <li><a id="astart" target='loggingUtilityBody' href="manage.dsp?action=Start">Start</a></li>
              <li>Stop</li>
              <li>Suspend</li>
              <li>Resume</li>
              <li><a id="arefresh" target='loggingUtilityBody' href="manage.dsp?action=Refresh">Refresh Status</a></li>
          %endif%
          %ifvar Status equals('Stop Pending')%
              <li>Start</li>
              <li>Stop</li>
              <li>Suspend</li>
              <li>Resume</li>
              <li><a id="arefresh" target='loggingUtilityBody' href="manage.dsp?action=Refresh">Refresh Status</a></li>
          %endif%
          %ifvar Status equals('Suspended')%
              <li>Start</li>
              <li><a id="astop" target='loggingUtilityBody' href="manage.dsp?action=Stop">Stop</a></li>
              <li>Suspend</li>
              <li><a id="aresume" target='loggingUtilityBody' href="manage.dsp?action=Resume">Resume</a></li>
              <li><a id="arefresh" target='loggingUtilityBody' href="manage.dsp?action=Refresh">Refresh Status</a></li>
          %endif%
          %ifvar Status equals('Suspend Pending')%
              <li>Start</li>
              <li>Stop</li>
              <li>Suspend</li>
              <li>Resume</li>
              <li><a id="arefresh" target='loggingUtilityBody' href="manage.dsp?action=Refresh">Refresh Status</a></li>
          %endif%
          %ifvar Status equals('')%
              <li><a id="astart" target='loggingUtilityBody' href="manage.dsp?action=Start">Start</a></li>
              <li><a id="astop" target='loggingUtilityBody' href="manage.dsp?action=Stop">Stop</a></li>
              <li><a id="asuspend" target='loggingUtilityBody' href="manage.dsp?action=Suspend">Suspend</a></li>
              <li><a id="aresume" target='loggingUtilityBody' href="manage.dsp?action=Resume">Resume</a></li>
              <li><a id="arefresh" target='loggingUtilityBody' href="manage.dsp?action=Refresh">Refresh Status</a></li>
          %endif%
        %endinvoke%
      </ul>
    </td>
  </tr>
<!-- -------------------------------------------------------------------- -->
<!-- -------------------------------------------------------------------- -->


<!-- -------------------------------------------------------------------- -->
<!-- -------------------------------------------------------------------- -->
<!-- This block of code builds a table that contains a number of          -->
<!-- information items about the Extractor including the status.          -->
  <table width="100%">
    <tr>
      <td class="heading" colspan=6>Logging Utility</td>
    </tr>
    <tr>
      <td class="oddcol-l" width="55%">Status</td>
      <td class="oddcol" width="20%">Debug Trace</td>
      <td class="oddcol" width="25%">Version</td>
    </tr>
    <script>resetRows();</script>
    <tr>
      <script>writeTD('rowdata-l');</script>
      %invoke wm.loggingUtility:status%
        %value Status%
      %endinvoke%
      <script>writeEndTD(); writeTD('rowdata');</script>


      %invoke wm.loggingUtility:getDebug%
        %switch Debug%
          %case 'On'%
            <a id="adebugOn" target='loggingUtilityBody' href="manage.dsp?action=DebugOff&Debug=Off">On</a>
          %case 'Off'%
            <a id="adebugOff" target='loggingUtilityBody' href="manage.dsp?action=DebugOn&Debug=On">Off</a>
        %endswitch%
      %endinvoke%
      <script>writeEndTD(); writeTD('rowdata');</script>


      %invoke wm.loggingUtility:getVersion%
        %ifvar Version%
          %ifvar Version -notempty%
            %value Version%
          %else%
            -
          %endifvar%
        %else%
          -
        %endifvar%
      %endinvoke%
      <script>writeEndTD(); swapRows();</script>
    </tr>
  </table>
<!-- -------------------------------------------------------------------- -->
<!-- -------------------------------------------------------------------- -->
</BODY>
</HTML>
