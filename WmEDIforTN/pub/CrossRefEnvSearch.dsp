<html>

	<head>
	
		<title>Interchange Info Search</title>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		<SCRIPT SRC="CrossRefUtil.js.txt"></SCRIPT>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
        <style>
			.pagebutton
			{
				background-color: #758EBD;
				text-align: center; 
				letter-spacing: 2px;
				padding-top: 2px;	
				padding-bottom: 2px;	
			  	border-right: 1px solid #95AACD; 
			  	border-left: 1px solid #5C7CB2; 
			  	border-bottom: 1px solid #95AACD; 
			  	border-top: 1px solid #5C7CB2;
	
			}
		</style>
	<script Language="JavaScript">

	function verify() {
		// check maxResult
		if (document.SearchForm.searchMaxResult.value != "") {
			if (!verifyRequiredNonNegNumber('SearchForm', 'searchMaxResult')) {
				alert("Maximun Result must be a non negative number.");
				return false;
	        }
	    }
        document.SearchForm.search.value = "true";
        
        document.SearchForm.searchQueryID.value	= "";
		document.SearchForm.searchPageNum.value	= "";
		//document.SearchForm.searchTotalPages.value	= "";
		
        return true;
	
	}
	
	function getPage(id, currentPNum, newPNum, totalPNum)
	{
		if (newPNum < 1) newPNum = 1;
		if (newPNum > totalPNum) newPNum = totalPNum;
		
		if (currentPNum == newPNum)
			return;
		
		document.SearchForm.searchQueryID.value  = id;
		document.SearchForm.searchPageNum.value  = newPNum;
		document.SearchForm.search.value = "true";
		document.SearchForm.submit();
	}


	function confirmDelete(url, ref, sid, squal, rid, rqual, prodMode)
	{
		var msg="Delete envelope Sender ID: " + sid;
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
		msg = msg + ", Production Mode: " + getModeFromInt (prodMode);
		if (confirm(msg))
		{
			ref.href = url;
			return true;
		}
		return false;
	}
	
	function setupData()
	{
		

		%ifvar search equals('true')%
			document.SearchForm.searchSenderID.value = "%value searchSenderID%";
			document.SearchForm.searchSenderID.value = "%value searchSenderID%";
			document.SearchForm.searchSenderQual.value = "%value searchSenderQual%";
			document.SearchForm.searchReceiverID.value = "%value searchReceiverID%";
			document.SearchForm.searchReceiverQual.value = "%value searchReceiverQual%";
			
			var i;
	 		for (i=0; i < document.SearchForm.searchProductionMode.options.length; i++) {				    
					if (document.SearchForm.searchProductionMode.options[i].value == '1003')
						document.SearchForm.searchProductionMode.options[i].selected = true;
					if (document.SearchForm.searchProductionMode.options[i].value == '1004')
						document.SearchForm.searchProductionMode.options[i].selected = true;
					if (document.SearchForm.searchProductionMode.options[i].value == '1005')
						document.SearchForm.searchProductionMode.options[i].selected = true;		
			}
			
			%loop searchSortByList%
				for (i=0; i < document.SearchForm.searchSortBy.options.length; i++) {
					if (document.SearchForm.searchSortBy.options[i].value == '%value searchSortByList%')
						document.SearchForm.searchSortBy.options[i].selected = true;
				}
			%endloop%

			
			document.SearchForm.searchMaxResult.value	= "%value searchMaxResult%";
		%endif%
		
		//alert("done setupData()");
	}
	
	function appendURL(s, form)
	{
		var v, v1, v2, i;

		%ifvar search equals('true')%

			v1 = "";
			for (i=0; i < form.searchProductionMode.options.length; i++) {
				if (form.searchProductionMode.options[i].selected)
					 v1 += "&searchProductionMode="+form.searchProductionMode.options[i].value;
			}

			v2 = "";
			for (i=0; i < form.searchSortBy.options.length; i++) {
				if (form.searchSortBy.options[i].selected)
					 v2 += "&searchSortBy="+form.searchSortBy.options[i].value;
			}
			

			v =  s + "&search=true"
			       + "&searchSenderID=" + escape(form.searchSenderID.value)
			       + "&searchSenderQual=" + escape(form.searchSenderQual.value)
			       + "&searchReceiverID=" + escape(form.searchReceiverID.value)
			       + "&searchReceiverQual=" + escape(form.searchReceiverQual.value)
			       //+ "&searchProductionMode="+form.searchProductionMode.value
			       + v1 + v2
			       + "&searchMaxResult="+form.searchMaxResult.value;
		%else%
			v = s + "&search=false";
		%endif%
			
		return v;
		
	}

	</script>
	<SCRIPT src="/WmRoot/webMethods.js.txt"></SCRIPT>


	</head>

	<body onLoad="setupData(); setNavigation('CrossRefEnvSearch.dsp', '', 'foo');">

		<table width=100%>
			<tr>
				<td class="menusection-Packages" colspan=2>Interchange Information%ifvar search equals('true')% &gt; Search%endif%</td>
			</tr>

			%invoke wm.b2b.editn.crossRef:envOperation%
	
				%ifvar message%
				<tr><td colspan="2">&nbsp;</td></tr>
				<TR><TD class="message" colspan="2">%value message%</TD></TR>
				%endif%
			%onerror%
				<TR><TD class="message" colspan="2">
					%value errorMessage%
		        </TD></TR>

			%endinvoke%
	
			<tr>
				<TD colspan="2">
          			<UL>
            			<LI><A href="" onClick="this.href=appendURL('CrossRefEnvInfo.dsp?mode=add', document.SearchForm)">Add Interchange Information</A></LI>

					</UL>
				</TD>
			</tr>

			<!--- Search Criteria --->
			<tr>
				<td>
					<table width=100%>
						<tr>
							<td class="heading" colspan="4">Set search criteria</td>
						</tr>
					
					<form name="SearchForm"	method="get" action="CrossRefEnvSearch.dsp" onsubmit="return verify();">
						<input type="hidden" name="search" value="false">
						<input type="hidden" name="searchQueryID">
						<input type="hidden" name="searchPageNum">
												
						<tr>
							<td class="oddrow">Sender ID</td>
							<td class="oddrow-l"><input name="searchSenderID"></td>
							<td class="oddrow">Sender Qualifier</td>
							<td class="oddrow-l"><input name="searchSenderQual"></td>
						</tr>
						<tr>
							<td class="evenrow">Receiver ID</td>
							<td class="evenrow-l"><input name="searchReceiverID"></td>
							<td class="evenrow">Receiver Qualifier</td>
							<td class="evenrow-l"><input name="searchReceiverQual"></td>
						</tr>
						
						<tr>
							<td class="oddrow">Production Mode</td>
							<td class="oddrow-l"> 
								<select	name="searchProductionMode" multiple size=3>
									<option value="1003">Production</option>
									<option value="1004">Testing</option>
									<option value="1005">Custom</option>
								</select>
								<BR>
							</td>
							<td class="oddrow">Sort By:</td>
							<td class="oddrow-l"> 
								<select	name="searchSortBy" size=1>
									<option value="SENDERID">Sender ID</option>
									<option value="SENDERQUAL">Sender Qualifier</option>
									<option value="RECEIVERID">Receiver ID</option>
									<option value="RECEIVERQUAL">Receiver Qualifier</option>
									<option value="PRODUCTIONMODE">Production Mode</option>
								</select>
							</td>
						</tr>
						<tr>
							<td class="evenrow">Maximum Results</td>
							<td class="evenrow-l"><input name="searchMaxResult" size="5" %ifvar searchMaxResult%value="%value searchMaxResult%"%else%value="20"%endif%></td>
						</tr>

						<tr>
							<td colspan=4 class="action" align="center" width="100%"><input	type="submit" value="Search"></td>
						</tr>
					</table>
						
					</form>
				</td>
			</tr>
			<tr><td>&nbsp;</td></tr>
			<!--- results --->

				
			
			%invoke wm.b2b.editn.crossRef:referenceSearch%
			<tr>
				<table width="100%">
						<tr><td class="heading" colspan="9">Interchange Information</td></tr>
						<tr>
							<td class="oddcol">Sender ID</td>
							<td class="oddcol">Sender Qualifier</td>
							<td class="oddcol">Receiver ID</td>
							<td class="oddcol">Receiver Qualifier</td>
							<td class="oddcol">Production Mode</td>
							<td class="oddcol">Edit</td>
							<td class="oddcol">Delete</td>
							<td class="oddcol">Copy</td>
							<td class="oddcol">GS</td>
						</tr>
						
						%ifvar envInfos%
		
						<script>resetRows();</script>
						%loop envInfos%
						<tr>
							<script>writeTD('row-l');</script>%value senderID% &nbsp;</td>
							<script>writeTD('row-l');</script>%ifvar senderQual equals('NULL')%%else%%value senderQual%%endif% &nbsp;</td>
							<script>writeTD('row-l');</script>%value receiverID% &nbsp;</td>
							<script>writeTD('row-l');</script>%ifvar receiverQual equals('NULL')%%else%%value receiverQual%%endif% &nbsp;</td>
							<script>writeTD('row-l');writeModeFromInt(%value productionMode%);</script>&nbsp;</td>
							
							<script>writeTD('rowdata');</script><a class="imagelink" href="" onClick="this.href=appendURL('CrossRefEnvInfo.dsp?mode=edit&senderID=%value -urlencode senderID%&senderQual=%value -urlencode senderQual%&receiverID=%value -urlencode receiverID%&receiverQual=%value -urlencode receiverQual%&productionMode=%value -urlencode productionMode%',document.SearchForm)"><IMG src="images/edit.gif" alt="Edit this Envelope Info" border=0></A></TD>
							<script>writeTD('rowdata');</script><a class="imagelink" href="" onClick="return confirmDelete(appendURL('CrossRefEnvSearch.dsp?operation=delete&senderID=%value -urlencode senderID%&senderQual=%value -urlencode senderQual%&receiverID=%value -urlencode receiverID%&receiverQual=%value -urlencode receiverQual%&productionMode=%value -urlencode productionMode%',document.SearchForm), this, '%value senderID%', '%value senderQual%', '%value receiverID%', '%value receiverQual%', %value productionMode%);"><IMG src="images/delete.gif" alt="Delete this Envelope Info" border="0"></A></TD>
							<script>writeTD('rowdata');</script><a class="imagelink" href="" onClick="this.href=appendURL('CrossRefEnvInfo.dsp?&mode=copy&senderID=%value -urlencode senderID%&senderQual=%value -urlencode senderQual%&receiverID=%value -urlencode receiverID%&receiverQual=%value -urlencode receiverQual%&productionMode=%value -urlencode productionMode%',document.SearchForm)"><IMG src="images/copy.gif" alt="Create new Envelope Info like this" border=0></A></TD>
		
		             		<script>writeTD('rowdata');</script><a class="imagelink" href="" onClick="this.href=appendURL('CrossRefGSPairs.dsp?senderID=%value -urlencode senderID%&senderQual=%value -urlencode senderQual%&receiverID=%value -urlencode receiverID%&receiverQual=%value -urlencode receiverQual%&productionMode=%value -urlencode productionMode%',document.SearchForm)"><IMG src="images/gspair.gif" alt="Edit GS Pairs" border="0"></A></TD>
						
						</tr>
						<script>swapRows();</script>
						%endloop envInfos%
						
					%ifvar searchTotalPages equals('1')%
					%else%
						%ifvar -notempty searchQueryID%	
						<tr colspan=4>
							<table width=100% class="pagebutton">
								<tr>
							<td width="20%"></td>
							<td>
								<input onclick="javascript:getPage('%value searchQueryID%', %value searchPageNum%, 1, %value searchTotalPages%);" type="submit" value="&lt;&lt;" name="pButton">
								<input onclick="javascript:getPage('%value searchQueryID%', %value searchPageNum%, %value searchPageNum% -1, %value searchTotalPages%);" type="submit" value="&lt;" name="pButton">
								<input onclick="javascript:getPage('%value searchQueryID%', %value searchPageNum%, %value searchPageNum% +1, %value searchTotalPages%);" type="submit" value="&gt;" name="pButton">
								<input onclick="javascript:getPage('%value searchQueryID%', %value searchPageNum%, %value searchTotalPages%, %value searchTotalPages%);" type="submit" value="&gt;&gt;" name="pButton">
								
							</td>
							<td width="20%" align=right>Page %value searchPageNum% of %value searchTotalPages%</td>
							</tr>
							</table>
						</tr>
						%endif searchQueryID%
					%endif searchTotalPages%
												
					%else%
						
						%ifvar resultMessage%
						 	<TR><td class="evenrowdata-l" colspan="9">%value resultMessage%</td> </TR>
						%else%
						 	<TR><td class="evenrowdata-l" colspan="9">Not found</td> </TR>
						%endif%
					%endif crossRefs%
		
					<tr><td></td></tr>
				</table>			
			%onerror%
				<hr>
				<p><font color="red">The Server could not process your request because the following error occurred. Contact your server administrator.</font></p>
				<TABLE WIDTH="50%" BORDER="1"> <TR><TD><B>Service</B></TD><TD>%value errorService%</TD></TR>
					<TR><TD><B>Error</B></TD><TD>%value error% &nbsp; %value errorMessage%</TD></TR>
					<TR><TD><B>Error Inputs</B></TD><TD>%value errorInputs% &nbsp;  </TD></TR>
					<TR><TD><B>Error Outputs</B></TD><TD>%value errorOutputs% &nbsp; </TD></TR> 
				</TABLE>
			%end invoke searchPageSearch%
		
			</tr>
	</table>
	
	</body>
</html>
