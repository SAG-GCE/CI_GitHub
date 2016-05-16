<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


  <TITLE>WmEDI Properties Settings</TITLE>
  <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
  <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
</HEAD>

<BODY onLoad="setNavigation('settings-properties.dsp', 'doc/OnlineHelp/EDIproperties.html', 'foo');">

  <TABLE WIDTH="100%">
    <TR>
      <TD class="menusection-Server" colspan="4">Properties Settings</TD>
    </TR>
    <TR>

%invoke wm.b2b.edi.util.GUI:property%
  %ifvar message%
      <tr><td colspan="4">&nbsp;</td></tr>
      <TR><TD class="message" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value message%</TD></TR>
  %endif%
%endinvoke%


    <TR>
      <TD colspan=2>
        <UL>
        %ifvar mode equals('edit')%
          <LI><A HREF="settings-properties.dsp">Return to Properties Settings</A></LI>
        %else%
          <LI><A HREF="settings-properties.dsp?mode=edit">Edit Properties  Settings</A></LI>
        %endif%
        </UL>
    </TR>
    <TR>
      <TD><IMG SRC="images/blank.gif" height=10 width=10 border=0></TD>
      <TD>
          <FORM action="settings-properties.dsp" method="POST">
          <INPUT type="hidden" name="action" value="change">

        <TABLE class="tableForm" %ifvar mode equals('edit')%width="100%"%endif% >

          <TR>
            <TD class="heading">Properties Settings</TD>
          </TR>

          <TR>
            <TD class="oddcol-l">Key=Value</TD>
          </TR>

          <TR>
            <TD class="evenrow-l">
            %ifvar mode equals('edit')%
              <TEXTAREA style="width:100%" wrap="off" rows=15 cols=40 name="settings">%value settings%</TEXTAREA>
            %else%
              <TABLE width=100%>
                <TR>
                  <TD><PRE class="fixedwidth">%value settings%








</PRE>
                  </TD>
                </TR>
              </TABLE>
            %endif%
            </TD>
          </TR>
          %ifvar mode equals('edit')%
          <TR>
            <TD class="action">
              <INPUT type="submit" name="submit" value="Save Changes">
            </TD>
          </TR>
          %endif%
          </FORM>
          <TR>
%ifvar mode equals('edit')%
            <TD class="oddrow-l">Properties settings are typically provided by webMethods Support</TD>
%else%
            <TD class="oddrow-l">Properties settings are typically provided by webMethods Support</TD>
%end if%
          </TR>


        </TABLE>
      </TD>
    </TR>
  </TABLE>
</BODY>
