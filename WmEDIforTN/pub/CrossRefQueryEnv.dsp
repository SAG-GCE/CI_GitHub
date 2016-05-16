<html>

	<head>
	
		<title>Query Envelope IDs</title>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">
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

		if (isblank(document.SearchForm.searchID.value)) {
			alert("Invalid ID");
  			document.SearchForm.searchID.focus();
            return (false);
		}
		/*
		if (isblank(document.SearchForm.searchQual.value)) {
			alert("Invalid Qualifier");
  			document.SearchForm.searchQual.focus();
            return (false);
		}
		*/
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

	
	function setupData()
	{

		%ifvar search equals('true')%
			document.SearchForm.searchID.value = "%value searchID%";
			document.SearchForm.searchQual.value = "%value searchQual%";
			
			document.SearchForm.searchMaxResult.value	= "%value searchMaxResult%";
			
		
		%endif%
		
	}
/*	
	function appendURL(s, form)
	{
		var v;

		%ifvar search equals('true')%

			v =  s + "&search=true"
			       + "&searchID=" + escape(form.searchID.value)
			       + "&searchQual=" + escape(form.searchQual.value)
			       + "&searchMaxResult="+form.searchMaxResult.value;
		%else%
			v = s + "&search=false";
		%endif%
		return v;
		
	}
*/	
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

	

	</script>
	<SCRIPT src="/WmRoot/webMethods.js.txt"></SCRIPT>


	</head>

	<body onLoad="setupData(); setNavigation('CrossRefQueryEnv.dsp', '', 'foo');">
	

		<table width=100%>
			<tr>
				<td class="menusection-Packages" colspan=2>Query Envelope IDs%ifvar search equals('true')% &gt; Search%endif%</td>
			</tr>

		%ifvar message%
			<tr><td colspan="2">&nbsp;</td></tr>
			<TR><TD class="message" colspan="2">%value message%</TD></TR>
		%endif%
		
			<tr><td colspan="2">&nbsp;</td></tr>
			<!--- Search Criteria --->
			<tr>
				<td>
					<table width=100%>
						<tr>
							<td class="heading" colspan="4">Set search criteria</td>
						</tr>
					
					<form name="SearchForm"	method="post" action="CrossRefQueryEnv.dsp" onsubmit="return verify();">
						<input type="hidden" name="search" value="false">
						<input type="hidden" name="searchQueryID">
						<input type="hidden" name="searchPageNum">
						<!-- input type="hidden" name="searchTotalPages"-->

						<tr>
							<td class="oddrow">ID</td>
							<td class="oddrow-l"><input name="searchID"></td>
							<td class="oddrow">Qualifier</td>
							<td class="oddrow-l"><input name="searchQual"></td>
						</tr>
						
						<tr>
							<td class="evenrow">Sort By:</td>
							<td class="evenrow-l"> 
								<select	name="searchSortBy" size=1>
									<option value="SENDERID">Sender ID</option>
									<option value="SENDERQUAL">Sender Qualifier</option>
									<option value="RECEIVERID">Receiver ID</option>
									<option value="RECEIVERQUAL">Receiver Qualifier</option>
								</select>
							</td>
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

		%ifvar search equals('true')%			
			%invoke wm.b2b.editn.crossRef:envSearch%
			<tr>
				<table width="100%">
						<tr><td class="heading" colspan="5">Envelope Information</td></tr>
						<tr>
							<td class="oddcol">Sender ID</td>
							<td class="oddcol">Sender Qualifier</td>
							<td class="oddcol">Receiver ID</td>
							<td class="oddcol">Receiver Qualifier</td>
							<td class="oddcol">Interchange</td>

						</tr>
						
					%ifvar envInfos%
						<!--script>setupPageData('%value searchQueryID%', %value searchPageNum%, %value searchTotalPages%);</script-->
		
						<script>resetRows();</script>
						%loop envInfos%
						<tr>
							<script>writeTD('row-l');</script>%value senderID% &nbsp;</td>
							<script>writeTD('row-l');</script>%value senderQual% &nbsp;</td>
							<script>writeTD('row-l');</script>%value receiverID% &nbsp;</td>
							<script>writeTD('row-l');</script>%value receiverQual% &nbsp;</td>
							<script>writeTD('rowdata');</script><a class="imagelink" href="CrossRefEnvSearch.dsp?search=true&searchSenderID=%value -urlencode senderID%&searchSenderQual=%value -urlencode senderQual%&searchReceiverID=%value -urlencode receiverID%&searchReceiverQual=%value -urlencode receiverQual%"><IMG src="images/search.gif" alt="Envelope Info" border=0></A></TD>
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
					 	<TR><td class="evenrowdata-l" colspan="9">Not found</td>
				</TR>
					%endif envInfos%
		
					
				</table>			
			%onerror%
				<hr>
				<p><font color="red">The Server could not process your request because the following error occurred. Contact your server administrator.</font></p>
				<TABLE WIDTH="50%" BORDER="1"> <TR><TD><B>Service</B></TD><TD>%value errorService%</TD></TR>
					<TR><TD><B>Error</B></TD><TD>%value error% &nbsp; %value errorMessage%</TD></TR>
					<TR><TD><B>Error Inputs</B></TD><TD>%value errorInputs% &nbsp;  </TD></TR>
					<TR><TD><B>Error Outputs</B></TD><TD>%value errorOutputs% &nbsp; </TD></TR> 
				</TABLE>
			%end invoke envSearch%
		%endif search%
			</tr>
	</table>
	
	</body>
</html>
