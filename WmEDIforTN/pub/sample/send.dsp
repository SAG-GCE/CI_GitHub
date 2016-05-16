<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="-1">
		<title>Send Order</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<base target="_self">
        <style>
			.listbox  { width: 100%; }
		</style>
	</head>

	<body class="main" onLoad="">

		<table width=100% >
			<tr>
				<td class="menusection-Solutions">Send Order</td>
			</tr>
		
		</table>
		<TABLE CELLSPACING="0" CELLPADDING="0" BORDER="0" width="100%">
		<TR>
			<TD VALIGN="top" width="100%"> <br>
			%invoke wm.b2b.editn.sample.util:checkSetup%    
              <p>%ifvar setupProperly equals('true')%
					<P>
						The group control number and purchase order number must be specified in order to start a conversation.  Please enter this information and press &quot;send&quot; to start the example.
					</P>
					<FORM NAME="SEND" ACTION="dosend.dsp" METHOD="POST">
					<TABLE width="100%">
						<TR>
							<TH COLSPAN="2" CLASS="heading">SEND MESSAGE</TH>
						</TR>
						<TR>
							<TD CLASS="oddrow">Sender</TD>
							<TD CLASS="oddrow-l">Company: 'SENDER' DUNS:112223333</TD>
							<INPUT TYPE="HIDDEN" NAME="SenderID" VALUE="112223333">
						</TR>
						<TR>
							<TD CLASS="evenrow">Receiver</TD>
							<TD CLASS="evenrow-l">Company: 'RECEIVER' DUNS:445556666</TD>
							<INPUT TYPE="HIDDEN" NAME="ReceiverID" VALUE="445556666">
						</TR>
						<TR>
							<TD CLASS="oddrow">Group Control Number</TD>
							<TD CLASS="oddrow-l"><INPUT TYPE="text" NAME="ControlNumber"></TD>
						</TR>
						<TR>
							<TD CLASS="evenrow">Purchase Order Number</TD>
							<TD CLASS="evenrow-l"><INPUT TYPE="TEXT" NAME="DocumentID"></TD>
						</TR>
						<TR>
							<TD CLASS="action" COLSPAN="2"><INPUT TYPE="SUBMIT" VALUE="Send"></TD>
						</TR>
						<TR>
							<TD COLSPAN="2"></TD>
						</TR>
						<TR>
							<TD COLSPAN="2">Return to <A HREF="index.dsp">introduction</A></TD>
						</TR>
					</TABLE>
					</FORM>
			%else%
				<P>
				Your sample is not setup correctly				
				</P>
              %ifvar scriptsOkay equals('false')%   
					<P> Please use Business Integrator to import the process models contained in the directory:  
                    <EM>ServerDirectory\packages\WmEDIforTN\config\Models</EM>.  After doing so, use  
                    webMethods Business Integrator to generate the business  
                    processes.  See the <i>Business Integrator User's Guide</i>  
                    and the <i>Trading Networks Implementation System Guide</i> for 
                    help with these procedures.</P> 
					<P> Reload this page after generating the business processes using webMethods Business Integrator. </P>
              %endif% %ifvar docsOkay equals('false')%   
					<P> Please run the setup <A HREF="setup.dsp">again</A>.  </P>
				%else% %ifvar profilesOkay equals('false')%   
						<P> Please run the setup <A HREF="setup.dsp">again</A>.</P>
              %endif% %endif% %endinvoke%   

	</body>
