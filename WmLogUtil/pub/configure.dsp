<HTML>
  <!-- Copyright (c) 2002-2007 webMethods Inc. -->
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
  <!-- This block of code conditionally executes the configure method(s)    -->
  <!-- based upon the input-parameter-labeled action.                       -->
  %ifvar action%
    %ifvar action -notempty%
      %switch action%
        %case 'setBatchSizeParameter'%
          %invoke wm.loggingUtility:setBatchSizeParameter%
            %include configure2.dsp%
          %onerror%
            <HR>
              <P><FONT COLOR="#FF0000">The Server could not process your request
              because the following error occurred.</FONT></P>
              <TABLE WIDTH="50%" BORDER="1">
                <TR><TD><B>Service</B></TD><TD>%value errorService%</TD></TR>
                <TR><TD><B>Error</B></TD><TD>%value error% &nbsp;
                %value errorMessage%</TD></TR>
              </TABLE>
            <HR>
            <a href="configure.dsp?editView=edit">Return to Change Settings</a>
          %endinvoke%
        %comment%
          ADD MORE CASES HERE AS APPROPRIATE
        %endcomment%
      %endswitch%
    %endifvar%
  %else%
    %include configure2.dsp%
  %endifvar%
  <!-- -------------------------------------------------------------------- -->
  <!-- -------------------------------------------------------------------- -->

</BODY>
</HTML>
