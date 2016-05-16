<HTML>
  <!-- Copyright (c) 1999-2007 webMethods Inc. -->
  <!-- Copyright (c) 2007-2014 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors. -->
  <!-- Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG. -->

  <head>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv="Expires" content="-1">
    <title>webMethods Logging Utility Administration Configure</title>
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <base target="_self">
    <style>
      .listbox { width: 100%; }
    </style>
  </head>


<BODY>

  <!-- -------------------------------------------------------------------- -->
  <!-- -------------------------------------------------------------------- -->
  <!-- This block of code creates the section heading.                      -->
  <table width="100%">
  <tr>
    <td class="menusection-Settings" colspan=2>
      Settings &gt Configure
      %ifvar editView equals('edit')%
        &gt; Change Settings
      %else%
        &gt; Display Settings
      %endifvar%
    </td>
  </tr>
  <!-- -------------------------------------------------------------------- -->
  <!-- -------------------------------------------------------------------- -->


  <!-- -------------------------------------------------------------------- -->
  <!-- -------------------------------------------------------------------- -->
  <!-- This block of code creates the link at the top of the page.          -->
  %ifvar editView equals('edit')%
    <tr>
      <td colspan="2">
        <ul>
          <li><a href="configure.dsp">Return to Display Settings</a></li>
        </ul>
      </td>
    </tr>
  %else%
    <tr>
      <td colspan="2">
        <ul>
          <li><a href="configure.dsp?editView=edit">Change Settings</a></li>
        </ul>
      </td>
    </tr>
  %endif%
  <tr><td><img src="images/blank.gif" height=10 width=10></td></tr>
  <!-- -------------------------------------------------------------------- -->
  <!-- -------------------------------------------------------------------- -->


  <!-- -------------------------------------------------------------------- -->
  <!-- -------------------------------------------------------------------- -->
  <!-- This block of code creates the table that holds the parameters.      -->
  <tr>
    <td>
      <table>
        %ifvar editView equals('edit')%
          <form action="configure.dsp">
          <input type="hidden" name="action" value="setBatchSizeParameter">
        %endifvar%

        <tr><td class="heading" colspan=2>Batch Size</td></tr>
        <tr>
          <td class="oddrow">Size</td>
          <td class="oddrowdata-l" valign="top">
            <nobr>

              %ifvar editView equals('edit')%
                <INPUT TYPE="TEXT" NAME="Value">
              %else%
                %invoke wm.loggingUtility:getBatchSizeParameter%
                  %value Value%
                %endinvoke%
              %endifvar%
            </nobr>
          </td>
        </tr>

        %ifvar editView equals('edit')%
          <tr>
            <td colspan="2" class="action">
              <input type="submit" name="submit" value="Save Changes">
            </td>
          </tr>
          </form>
        %endif%
      </table>
    </td>
  </tr>
  <!-- -------------------------------------------------------------------- -->
  <!-- -------------------------------------------------------------------- -->

</BODY>
</HTML>
