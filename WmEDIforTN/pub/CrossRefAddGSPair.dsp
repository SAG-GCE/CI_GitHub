<html>

	<head>
		<title>Interchange Information - Add GS Pair</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type'	content='text/html; charset=UTF-8'>

	<script Language="JavaScript">

	function verify() {
		if (isblank(document.properties.newSenderID.value)) {
			alert("Invalid Sender ID");
  			document.properties.newSenderID.focus();
            return (false);
		}
		
		if (isblank(document.properties.newReceiverID.value)) {
			alert("Invalid Receiver ID");
  			document.properties.newSenderID.focus();
            return (false);
		}
        return (true);
	
	}
	
	function setupData()
	{
		//alert( '%value search%' + "," + '%value searchProductionMode%');
		
		var ss;
		%ifvar search equals('true')%
			document.properties.search.value = "true";
			document.properties.searchSenderID.value = "%value searchSenderID%";
			document.properties.searchSenderID.value = "%value searchSenderID%";
			document.properties.searchSenderQual.value = "%value searchSenderQual%";
			document.properties.searchReceiverID.value = "%value searchReceiverID%";
			document.properties.searchReceiverQual.value = "%value searchReceiverQual%";
			
			%ifvar searchProductionModeList%
				ss = "";
				%loop searchProductionModeList%
					if (ss.length == 0)
						ss += '%value searchProductionModeList%'
					else
						ss += "&searchProductionMode=" + '%value searchProductionModeList%'
				%endloop%
				document.properties.searchProductionMode.value = ss;
			%endif%
			
			%ifvar searchSortByList%
				ss = "";
				%loop searchSortByList%
					if (ss.length == 0)
						ss += '%value searchSortByList%'
					else
						ss += "&searchSortBy=" + '%value searchSortByList%'
				%endloop%
				document.properties.searchSortBy.value = ss;
			%endif%
			
			document.properties.searchMaxResult.value	= "%value searchMaxResult%";
		%endif%
		
		//alert("done setupData()");
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
			       //+ "&searchProductionMode="+form.searchProductionMode.value
				   %ifvar searchProductionModeList%
				       + "&searchProductionMode="+form.searchProductionMode.value
				   %endif%
				   %ifvar searchSortBy%
			       + "&searchSortBy="+form.searchSortBy.value
				   %endif%
				   %ifvar searchMaxResult%
			       + "&searchMaxResult="+form.searchMaxResult.value;
				   %endif%
		%else%
			v = s + "&search=false";
		%endif%
//alert(v + '   %value search%');		
		return v;
		
	}
	

	</script>
	<SCRIPT src="/WmRoot/webMethods.js.txt"></SCRIPT>


	</head>

	<body onLoad="setupData();">
	

		<table width=100%>
			<tr>
				<td class="menusection-Packages" colspan=2>Interchange Information &gt; Add GS Pair</td>
			</tr>

			<tr><td>&nbsp;</td></tr>
			<tr>
				<TD colspan="2">
          			<UL>
            			<LI><A HREF="" onClick="this.href=appendURL('CrossRefGSPairs.dsp?senderID=%value -urlencode senderID%&senderQual=%value -urlencode senderQual%&receiverID=%value -urlencode receiverID%&receiverQual=%value -urlencode receiverQual%&',document.properties)">Return to Interchange Information &gt; GS Pairs</A></LI>
					</UL>
				</TD>
			</tr>

			<!--- properties --->
			<tr>
				<td>
					<table width=100%>
						<tr>
							<td class="heading" colspan="4">Add GS Pair</td>
						</tr>
					
					<form name="properties"	method="post" action="CrossRefGSPairs.dsp" onsubmit="return verify();">
						<input type="hidden" name="operation" value="addGSPair">
						<!--
						<input type="hidden" name="envelopeID" value="%value envelopeID%">
						-->
						<input type="hidden" name="senderID" value="%value senderID%">
						<input type="hidden" name="senderQual" value="%value senderQual%">
						<input type="hidden" name="receiverID" value="%value receiverID%">
						<input type="hidden" name="receiverQual" value="%value receiverQual%">
						<input type="hidden" name="envelopeID" value="%value envelopeID%">
						<input type="hidden" name="search">
						<input type="hidden" name="searchSenderID">
						<input type="hidden" name="searchSenderQual">
						<input type="hidden" name="searchReceiverID">
						<input type="hidden" name="searchReceiverQual">
						%ifvar searchProductionMode%
							<input type="hidden" name="searchProductionMode">
						%endif%
						%ifvar searchSortBy%
						<input type="hidden" name="searchSortBy">
						%endif%
						%ifvar searchMaxResult%
						<input type="hidden" name="searchMaxResult">
						%endif%
						
						<tr>
							<td class="oddrow">Sender ID</td>
							<td class="oddrow-l">&nbsp; <input name="newSenderID"></td>
							
							<td class="oddrow">Sender Qualifier</td>
							<td class="oddrow-l">&nbsp; <input name="newSenderQual"></td>
						</tr>
						<tr>
							<td class="evenrow">Receiver ID</td>
							<td class="evenrow-l">&nbsp; <input name="newReceiverID"></td>
							
							<td class="evenrow">Receiver Qualifier</td>
							<td class="evenrow-l">&nbsp; <input name="newReceiverQual"></td>
						</tr>
				

						<tr>
							<td colspan=4 class="action" align="center" width="100%"><input	type="submit" value="Save Changes"></td>
						</tr>
					</table>
						
					</form>
				</td>
			</tr>
			
		</table>
	
	</body>
</html>
