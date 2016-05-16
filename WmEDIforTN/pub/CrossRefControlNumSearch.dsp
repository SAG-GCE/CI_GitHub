<html>

	<head>
	
		<title>Control Number Search</title>
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

	var checkedItem = "";

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


	function setupData()
	{

		%ifvar search equals('true')%
			document.SearchForm.searchSenderID.value = "%value searchSenderID%";
			document.SearchForm.searchSenderID.value = "%value searchSenderID%";
			document.SearchForm.searchSenderQual.value = "%value searchSenderQual%";
			document.SearchForm.searchReceiverID.value = "%value searchReceiverID%";
			document.SearchForm.searchReceiverQual.value = "%value searchReceiverQual%";
			document.SearchForm.searchVersion.value = "%value searchVersion%";


			var i;
			%loop searchStandardList%
				for (i=0; i < document.SearchForm.searchStandard.options.length; i++) {
					if (document.SearchForm.searchStandard.options[i].value == '%value searchStandardList%')
						document.SearchForm.searchStandard.options[i].selected = true;
				}
			%endloop%
			%loop searchProductionModeList%
				for (i=0; i < document.SearchForm.searchProductionMode.options.length; i++) {
					if (document.SearchForm.searchProductionMode.options[i].value == '%value searchProductionModeList%')
						document.SearchForm.searchProductionMode.options[i].selected = true;
				}
			%endloop%
			%loop searchSortByList%
				for (i=0; i < document.SearchForm.searchSortBy.options.length; i++) {
					if (document.SearchForm.searchSortBy.options[i].value == '%value searchSortByList%')
						document.SearchForm.searchSortBy.options[i].selected = true;
				}
			%endloop%

						
			document.SearchForm.searchMaxResult.value	= "%value searchMaxResult%";
			%ifvar searchGroupTypeGroups equals('OTHERS')%
				document.SearchForm.searchGroupTypeOthersText.value	= "%value searchGroupTypeOthersText%";
				checkedItem = "OTHERS";
			%else%
				%ifvar searchGroupTypeGroups equals('ALL')%
					checkedItem = "ALL";
				%endif%
			%endif%
		%endif%
		
	}
	
	
	function getSelectionAppendURL(s)
	{
		var url = "";
			
		for (var i=0; i < s.options.length; i++) {
			if (s.options[i].selected)
				 url += "&" + s.name + "="+s.options[i].value;
		}	
		return url;
		
	}

	function appendURL(s, form)
	{
		var v;
		%ifvar search equals('true')%
						
			v =  s + "&search=true"
			       + "&searchSenderID=" + escape(form.searchSenderID.value)
			       + "&searchSenderQual=" + escape(form.searchSenderQual.value)
			       + "&searchReceiverID=" + escape(form.searchReceiverID.value)
			       + "&searchReceiverQual=" + escape(form.searchReceiverQual.value)
			       + getSelectionAppendURL(form.searchProductionMode)
			       + getSelectionAppendURL(form.searchStandard)
			       + "&searchVersion="+form.searchVersion.value
			       + getSelectionAppendURL(form.searchSortBy);
			       
			if (form.searchGroupTypeEnv.checked)
				v += "&searchGroupTypeEnv=on";
			if (form.searchGroupTypeGroups[0].checked)
				v += "&searchGroupTypeGroups=ALL";	
			if (form.searchGroupTypeGroups[1].checked)
				v += "&searchGroupTypeGroups=OTHERS" + 	"&searchGroupTypeOthersText="  + escape(form.searchGroupTypeOthersText.value);
			 	       
			       
			v += "&searchMaxResult="+form.searchMaxResult.value;
		%else%
			v = s + "&search=false";
		%endif%
		return v;
		
	}

	function enableUserGroupType(flag)
	{
/*
		if (true)
			document.SearchForm.searchGroupTypeOthersText.type = "INPUT";
		else
			document.SearchForm.searchGroupTypeOthersText.type = "HIDDEN";
*/
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

	function unselectRadio(f)
	{
		if (f.checked && f.value == checkedItem ) {
			f.checked = false;
			checkedItem = "";
		} else {
			checkedItem = f.value;
		}
	}

	</script>
	<SCRIPT src="/WmRoot/webMethods.js.txt"></SCRIPT>


	</head>

	<body onLoad="setupData(); setNavigation('CrossRefControlNumSearch.dsp', '', 'foo');">

	

		<table width=100%>
			<tr>
				<td class="menusection-Adapters" colspan=2>Control Number &gt; Search</td>
			</tr>

	%ifvar operation%
	%invoke wm.b2b.editn.crossRef:controlNumOps%
		<tr><td colspan="2">&nbsp;</td></tr>
		<TR><TD class="message" colspan="2">%value message%</TD></TR>
	%onerror%
		<tr><td colspan="2">&nbsp;</td></tr>
		<TR><TD class="message" colspan="2">%value errorMessage%</TD></TR>
	%endinvoke%
	%endif%
	
			<tr>
				<TD colspan="2">
          			<UL>
            			<LI><A href="" onClick="this.href=appendURL('CrossRefControlNum.dsp?mode=add', document.SearchForm)">Add Control Number</A></LI>

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
					
					<form name="SearchForm"	method="post" action="CrossRefControlNumSearch.dsp" onsubmit="return verify();">
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
							<td class="oddrow">Standard</td>
							<td class="oddrow-l"> 
								<select	name="searchStandard" multiple size = 3>
									<option value="X12">X12</option>
									<option value="UNEDIFACT">UNEDIFACT</option>
									<option value="EANCOM">EANCOM</option>
									<option value="UCS">UCS</option>
									<option value="VICS">VICS</option>
									<option value="ODETTE">ODETTE</option>
									<option value="TRADACOMS">TRADACOMS</option>
								</select>
							</td>
							<td class="oddrow">Production Mode</td>
							<td class="oddrow-l"> 
								<select	name="searchProductionMode" multiple size=3>
									<option value="1003">Production</option>
									<option value="1004">Testing</option>
									<option value="1005">Custom</option>
								</select>
							</td>							
						</tr>
						</tr>
							<td class="evenrow">Version</td>
							<td class="evenrow-l"><input name="searchVersion"></td>
								
							<td class="evenrow">Sort By</td>
							<td class="evenrow-l">
								<select	name="searchSortBy" size=1>
									<option value="SENDERID">Sender ID</option>
									<option value="SENDERQUAL">Sender Qualifier</option>
									<option value="RECEIVERID">Receiver ID</option>
									<option value="RECEIVERQUAL">Receiver Qualifier</option>
									<option value="PRODUCTIONMODE">Production Mode</option>
									<option value="STANDARD">Standard</option>
									<option value="VERSION">Version</option>
									<option value="GROUPTYPE">Group Type</option>
								</select>
							</td>
						</tr>

						<tr>
							<td class="oddrow">Group Type</td>
							<td class="oddrow-l">
								<INPUT TYPE="checkbox" NAME="searchGroupTypeEnv" %ifvar searchGroupTypeEnv equals('on')%CHECKED%endif%>Envelope
								<br><INPUT TYPE="Radio" onClick="unselectRadio(this)" NAME="searchGroupTypeGroups" value="ALL"  %ifvar searchGroupTypeGroups equals('ALL')%CHECKED%endif%>All Groups</br>
								<INPUT TYPE="Radio" onClick="unselectRadio(this)" NAME="searchGroupTypeGroups" value="OTHERS" %ifvar searchGroupTypeGroups equals('OTHERS')%CHECKED%endif%>Other Group<input name="searchGroupTypeOthersText">
							</td>						
						
							<td class="oddrow">Maximum Results</td>
							<td class="oddrow-l"><input name="searchMaxResult" size="5" %ifvar searchMaxResult%value="%value searchMaxResult%"%else%value="20"%endif%></td>
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
			%invoke wm.b2b.editn.crossRef:controlNumSearch%
				<table width="100%">
						<tr><td class="heading" colspan="9">Control Number Information</td></tr>
						<tr>
							<td class="oddcol">Sender ID</td>
							<td class="oddcol">Sender Qualifier</td>
							<td class="oddcol">Receiver ID</td>
							<td class="oddcol">Receiver Qualifier</td>
							<td class="oddcol">Production Mode</td>
							<td class="oddcol">Standard</td>
							<td class="oddcol">Version</td>
							<td class="oddcol">Group Type</td>
							<td class="oddcol">Edit</td>
							<!--td class="oddcol">Delete</td>
							<td class="oddcol">Copy</td>
							<td class="oddcol">GS</td-->
						</tr>
						
						%ifvar controlNumInfos%

						<script>resetRows();</script>
						%loop controlNumInfos%
						<tr>
							<script>writeTD('row-l');</script>%value senderID encode(xml)% &nbsp;</td>
							<script>writeTD('row-l');</script>%ifvar senderQual equals('NULL')%%else%%value senderQual encode(xml)%%endif% &nbsp;</td>
							<script>writeTD('row-l');</script>%value receiverID encode(xml)% &nbsp;</td>
							<script>writeTD('row-l');</script>%ifvar receiverQual equals('NULL')%%else%%value receiverQual encode(xml)%%endif% &nbsp;</td>
							<script>writeTD('row-l');writeModeFromInt(%value productionMode encode(xml)%);</script>&nbsp;</td>
							<script>writeTD('row-l');</script>%value standard encode(xml)% &nbsp;</td>
							<script>writeTD('row-l');</script>%ifvar version equals('NULL')%%else%%value version encode(xml)%%endif% &nbsp;</td>
							<script>writeTD('row-l');</script>%ifvar groupType equals('ENVELOPE')%Envelope%else%%value groupType encode(xml)%%endif% &nbsp;</td>
							
							<!-- script>writeTD('rowdata');</script><a class="imagelink" href="" onClick="this.href=appendURL('CrossRefControlNum.dsp?mode=edit&senderID=%value senderID%&senderQual=%value senderQual%&receiverID=%value receiverID%&receiverQual=%value receiverQual%&productionMode=%value productionMode%&standard=%value standard%&version=%value version%&groupType=%value groupType%&controlNumber=%value controlNumber%&controlNumberCap=%value controlNumberCap%&controlNumberMin=%value controlNumberMin%&controlNumberInc=%value controlNumberInc%&controlNumberWindow=%value controlNumberWindow%',document.SearchForm)"><IMG src="images/edit.gif" alt="Edit this Envelope Info" border=0></A></TD -->
                     				<script>writeTD('rowdata');</script><a class="imagelink" href="" onClick="this.href=appendURL('CrossRefControlNum.dsp?mode=edit&senderID=%value -urlencode senderID%&senderQual=%value -urlencode senderQual%&receiverID=%value -urlencode receiverID%&receiverQual=%value -urlencode receiverQual%&productionMode=%value -urlencode productionMode%&standard=%value -urlencode standard%&version=%ifvar version equals('NULL')%%else%%value -urlencode version%%endif%&groupType=%value -urlencode groupType%&controlNumber=%value -urlencode controlNumber%&controlNumberCap=%value -urlencode controlNumberCap%&controlNumberMin=%value -urlencode controlNumberMin%&controlNumberInc=%value -urlencode controlNumberInc%&controlNumberWindow=%value -urlencode controlNumberWindow%',document.SearchForm)"><IMG src="images/edit.gif" alt="Edit this Envelope Info" border=0></A></TD>

                     		<!--script>writeTD('rowdata');</script><a class="imagelink" href="" onClick="this.href=appendURL('CrossRefControlNumSearch.dsp?envelopeID=%value envelopeID%&operation=deleteRef',document.SearchForm)" onclick="return confirmDelete();"><IMG src="images/delete.gif" alt="Delete this Envelope Info" border="0"></A></TD -->
							<!--script>writeTD('rowdata');</script><a class="imagelink" href="" onClick="this.href=appendURL('CrossRefControlNum.dsp?envelopeID=%value envelopeID%&mode=copy&senderID=%value senderID%&senderQual=%value senderQual%&receiverID=%value receiverID%&receiverQual=%value receiverQual%&productionMode=%value productionMode%',document.SearchForm)"><IMG src="images/copy.gif" alt="Create new Envelope Info like this" border=0></A></TD-->
                     		<!--script>writeTD('rowdata');</script><a class="imagelink" href="" onClick="this.href=appendURL('CrossRefGSPairs.dsp?envelopeID=%value envelopeID%&senderID=%value senderID%&senderQual=%value senderQual%&receiverID=%value receiverID%&receiverQual=%value receiverQual%&productionMode=%value productionMode%',document.SearchForm)"><IMG src="images/gspair.gif" alt="Edit GS Pairs" border="0"></A></TD-->

						</tr>
						<script>swapRows();</script>
						%endloop controlNumInfos%
						
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
					%endif controlNumInfos%

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
			%endinvoke%
		%endif search%
			
	</table>
	
	</body>
</html>
