<HTML>
	<HEAD>
		<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
	</HEAD>

<script>
function launchHelp()
{

	if(parent.menu != null){
		if (parent.menu.document.forms["urlsaver"].helpURL.value != '')
			window.open(parent.menu.document.forms["urlsaver"].helpURL.value, 'help', "directories=no,location=yes,menubar=yes,scrollbars=yes,status=yes,toolbar=yes,resizable=yes", true);
	}
}
</script>

	<BODY  class="topbar" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
		<table border=0 cellspacing=0 cellpadding=0 height=100% width=100%>
			<tr>
				<td>
					<TABLE width=100% CELLSPACING=0 BORDER=0>
						<TR>
							<TD nowrap class="toptitle" width="100%">
								%value $host%
								::
								Integration Server
								::
								EDI Module
							</TD>
							<TD bgcolor="FFFFFF">
								<IMG src="/WmRoot/images/newlogo.gif" border=0>
							</TD>
						</TR>
					</TABLE>
				</td>
			</tr>
			<tr height=100%>
				<td>
					<TABLE width=100% height=100% CELLSPACING=0 BORDER=0>
						<TR>
							<TD nowrap width=100% class="topmenu">&nbsp;
							</TD>
							<TD nowrap valign="bottom" class="topmenu">
								<A target='main' href='about.dsp'>About</A>

								| <A target='body' onclick="launchHelp();return false;" href='#'>Help</A>&nbsp;
							</TD>


						</TR>
						<TR>
						</TR>
					</TABLE>
				</td>
			</tr>
		</table>
	</BODY>
</HTML>