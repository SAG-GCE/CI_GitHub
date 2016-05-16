<HTML>
	<HEAD>
	
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
		<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
		<TITLE>Interchange Information  -- GS Pairs</TITLE>


		<SCRIPT Language="JavaScript">

		var searchURL;
		
	function confirmDelete(url, ref, sid, squal, rid, rqual)
	{
		var msg="Delete Group Pair Sender ID: " + sid;
		if (squal == "NULL")
		{
		}
		else
		{
			msg = msg + ", Sender Qualifier: " + squal;
		}
		msg = msg + ", Receiver ID: " + rid;
		if (rqual == "NULL")
		{
		}
		else
		{
			msg = msg + ", Receiver Qualifier: " + rqual;
		}
		if (confirm(msg))
		{
			ref.href = url;
			return true;
		}
		return false;
	}
		
		function appendURL(s)
		{
		
	//alert(s+ searchURL);		
			return s+ searchURL;
			
		}
		
		function setupData()
		{
	
			%ifvar search equals('true')%
				searchURL = "search=true"
						       + "&searchSenderID="+'%value -urlencode searchSenderID%'
						       + "&searchSenderQual="+'%value -urlencode searchSenderQual%'
						       + "&searchReceiverID="+'%value -urlencode searchReceiverID%'
						       + "&searchReceiverQual="+'%value -urlencode searchReceiverQual%';

				
				%ifvar searchProductionModeList%
					%loop searchProductionModeList%
						searchURL += "&searchProductionMode=" + '%value -urlencode searchProductionModeList%';
					%endloop%
				%endif%
				
				%ifvar searchSortByList%
					%loop searchSortByList%
						searchURL += "&searchSortBy=" + '%value -urlencode searchSortByList%';
					%endloop%
				%endif%
									       
				searchURL += "&searchMaxResult="+'%value -urlencode searchMaxResult%';
			%else%
				searchURL = "search=false";
				
			%endif%	
//alert("searchURL=[" + searchURL+ " ]");						
		}

		</SCRIPT>

	</HEAD>
		
	<body onLoad="setupData();">

	<TABLE width="100%">
		<tr><td class="menusection-Packages" colspan=2>Interchange Information &gt; GS Pairs</td></tr>

	%invoke wm.b2b.editn.crossRef:crossRefOp%


			%ifvar operation equals('addGSPair')%
		<tr><td colspan="2">&nbsp;</td></tr>
        <TR><TD class="message" colspan="2">
				GS Pair Added
		</TD></TR>
			%endif%
			%ifvar operation equals('deleteGSPair')%
		<tr><td colspan="2">&nbsp;</td></tr>
        <TR><TD class="message" colspan="2">
				GS Pair Deleted
		</TD></TR>
			%endif%
	%onerror%
		<TR><TD class="message" colspan="2"> %value errorMessage% </TD></TR>
	%endinvoke%

		<TR>
			<TD colspan="2">
				<UL>
					<LI><A href="CrossRefEnvSearch.dsp">Return to Interchange Information</A></LI>
					<LI><A HREF="" onClick="this.href=appendURL('CrossRefEnvSearch.dsp?')">Return to Interchange Information &gt; Search</A></LI>
					<LI><A HREF="" onClick="this.href=appendURL('CrossRefAddGSPair.dsp?senderID=%value -urlencode senderID%&senderQual=%value -urlencode senderQual%&receiverID=%value -urlencode receiverID%&receiverQual=%value -urlencode receiverQual%&')">Add GS Pair</A></LI>
				</UL>
			</TD>
		</TR>

		<TR>
			<TD>
				<table width=100%>
		
					<tr>
						<td>

							<table width=100%>
								<tr>
									<td class="heading" colspan="4">Interchange Information</td>
								</tr>
								<tr>
									<td class="oddrow">Sender ID</td>
									<td class="oddrowdata-l">%value senderID%</td>
									<td class="oddrow">Sender Qualifier</td>
									<td class="oddrowdata-l">%ifvar senderQual equals('NULL')%%else%&nbsp;%value senderQual%%endif%</td>
								</tr>
								<tr>
									<td class="evenrow">Receiver ID</td>
									<td class="evenrowdata-l">%value receiverID%</td>
									<td class="evenrow">Receiver Qualifier</td>
									<td class="evenrowdata-l">%ifvar receiverQual equals('NULL')%%else%&nbsp;%value receiverQual%%endif%</td>
								</tr>
								
							</table>

						</td>
					</tr>
					<tr><td>&nbsp;</td></tr>

					
				</table>
	
			</td>
		</tr>


		<TR>
			<TD>
			
			%invoke wm.b2b.editn.crossRef:getGSPairs%

				 <table width="100%">
					<tr><td>&nbsp;</td></tr>
		
					<tr><td class="heading" colspan="5">GS Pairs</td></tr>
					<tr>
						<td class="oddcol">Sender ID</td>
						<td class="oddcol">Sender Qualifier</td>
						<td class="oddcol">Receiver ID</td>
						<td class="oddcol">Receiver Qualifier</td>
						<td class="oddcol">Delete</td>
					</tr>
		
				%ifvar GSPairs%

					<script>resetRows();</script>
					%loop GSPairs%
					<tr>
						<script>writeTD('row-l');</script>%value senderID% &nbsp;</td>
						<script>writeTD('row-l');</script>%ifvar senderQual equals('NULL')%&nbsp;%else%%value senderQual%%endif% &nbsp;</td>
						<script>writeTD('row-l');</script>%value receiverID% &nbsp;</td>
						<script>writeTD('row-l');</script>%ifvar receiverQual equals('NULL')%&nbsp;%else%%value receiverQual%%endif% &nbsp;</td>
						<script>writeTD('rowdata');</script>
						<a class="imagelink" href="" onClick="return confirmDelete(appendURL('CrossRefGSPairs.dsp?senderID=%value -urlencode /senderID%&senderQual=%value -urlencode /senderQual%&receiverID=%value -urlencode /receiverID%&receiverQual=%value -urlencode /receiverQual%&deleteSenderID=%value -urlencode senderID%&deleteSenderQual=%value -urlencode senderQual%&deleteReceiverID=%value -urlencode receiverID%&deleteReceiverQual=%value -urlencode receiverQual%&operation=deleteGSPair&'), this, '%value senderID%', '%value senderQual%', '%value receiverID%', '%value receiverQual%');"><IMG src="images/delete.gif" alt="Delete this GS Pair" border="0"></A></TD>

					</tr>
					<script>swapRows();</script>
					%endloop crossRefs%
				%else%
					<TR><td class="evenrowdata-l" colspan="9">Not found</td></TR>
				%endif crossRefs%

					<tr><td></td></tr>
				</table>
			%onerror%
				<hr>
				<p><font color="red">Can not retreive GS Pairs.</font></p>
				<TABLE WIDTH="50%" BORDER="1">
				    <TR><TD><B>Service</B></TD><TD>%value errorService%</TD></TR>
					<TR><TD><B>Error</B></TD><TD>%value error% &nbsp; %value errorMessage%</TD></TR>
					<TR><TD><B>Error Inputs</B></TD><TD>%value errorInputs% &nbsp;  </TD></TR>
					<TR><TD><B>Error Outputs</B></TD><TD>%value errorOutputs% &nbsp; </TD></TR>
				</TABLE>
			%endinvoke%

			</td>
		</tr>
	</table>
	</body>
</html>
