<HTML>
<HEAD>

<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">


  <TITLE>WmEDI Format Settings</TITLE>
  <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
  <SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>

  <SCRIPT Language="JavaScript">
  function verify(f, action) {
    if (document.properties.settings.value == "")
    {
      alert("Please specify Format Settings");
      document.properties.settings.focus();
      return false;
    }
    return true;
			
  }
  </SCRIPT>

</HEAD>

<BODY onLoad="setNavigation('settings-format.dsp', 'doc/OnlineHelp/FormatConfig.html', 'foo');">


  <TABLE WIDTH="100%">
    <TR>
      <TD class="menusection-Server" colspan="4">Format Settings</TD>
    </TR>
    <TR>

%invoke wm.b2b.edi.util.GUI:format%
  %ifvar message%
      <tr><td colspan="4">&nbsp;</td></tr>
      <TR><TD class="message" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%value encode(xml) message%</TD></TR>
  %endif%
%endinvoke%


    <TR>
      <TD colspan=2>
        <UL>
        %ifvar mode equals('edit')%
          <LI><A HREF="settings-format.dsp">Return to Format Settings</A></LI>
        %else%
          <LI><A HREF="settings-format.dsp?mode=edit">Edit Format Settings</A></LI>
        %endif%
        </UL>
    </TR>
    <TR>
      <TD><IMG SRC="images/blank.gif" height=10 width=10 border=0></TD>
      <TD>
          <FORM name="properties" action="settings-format.dsp" method="POST" onSubmit="return verify();">
          <INPUT type="hidden" name="action" value="change">
          <INPUT type="hidden" name="oldSettings" value='%value settings%'>


        <TABLE class="tableForm" %ifvar mode equals('edit')%width="100%"%endif% >

          <TR>
            <TD class="heading">Format Settings</TD>
          </TR>

          <TR>
            <TD class="evenrow-l">
            %ifvar mode equals('edit')%
              <TEXTAREA style="width:100%" wrap="off" rows=15 cols=40 name="settings">%value settings%</TEXTAREA>
            %else%
              <TABLE width=100%>
                <TR>
            %ifvar error equals('true')%
                  <TD><PRE class="fixedwidth">%value encode(xml) oldSettings%
            %else%
                  <TD><PRE class="fixedwidth">%value encode(xml) settings%
            %endif%







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
            <TD class="oddrow-l">Format Settings are typically provided by webMethods Support</TD>
%else%
            <TD class="oddrow-l">Format Settings are typically provided by webMethods Support</TD>
%end if%
          </TR>


        </TABLE>
      </TD>
    </TR>
  </TABLE>
</BODY>
