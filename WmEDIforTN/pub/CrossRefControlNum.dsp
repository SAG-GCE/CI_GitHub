<HTML>
	<HEAD>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
		<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
		<SCRIPT SRC="CrossRefUtil.js.txt"></SCRIPT>
		<TITLE>Edit Control Number</TITLE>
	
		<SCRIPT Language="JavaScript">
		
	
		function writeThisEdit(mode, name, value)
		{

			if (mode == 'add') {
				if (name == "controlNumber") value = "1";
				if (name == "controlNumberCap") value = "999999999";
				if (name == 'controlNumberWindow') value = "100";
				if (name == 'controlNumberMin' ) value = "1";
				if (name == 'controlNumberInc' ) value = "1";
				writeEdit('edit', name, value);
				
			//} else if  (mode == 'copy') {
			//	writeEdit('edit', name, value);
			} else { // edit
				if (name == 'controlNumber' || name == 'controlNumberCap' ||
					name == 'controlNumberWindow' || name == 'controlNumberMin' ||
					name == 'controlNumberInc' )
					writeEdit('edit', name, value);
				else
					writeEdit('view', name, value);
			}
		}

		function setupData()
		{

			document.properties.operation.value = "%value mode%";
			%ifvar envelopeID%
				document.properties.envelopeID.value = "%value envelopeID%";
			%endif%

			%ifvar search equals('true')%
				document.properties.search.value = "true";
				document.properties.searchSenderID.value = "%value searchSenderID%";
				document.properties.searchSenderQual.value = "%value searchSenderQual%";
				document.properties.searchReceiverID.value = "%value searchReceiverID%";
				document.properties.searchReceiverQual.value = "%value searchReceiverQual%";

				
				document.properties.searchVersion.value = '%value encode(htmlattr) searchVersion%';
				
				document.properties.searchGroupTypeEnv.value = '%value searchGroupTypeEnv%';
				document.properties.searchGroupTypeGroups.value = '%value searchGroupTypeGroups%';
				document.properties.searchGroupTypeOthersText.value = '%value searchGroupTypeOthersText%';
				
				document.properties.searchMaxResult.value = '%value encode(htmlattr) searchMaxResult%';
			%else%
				document.properties.search.value = "false";
			%endif%
			
		}


	
		function verify(f, action) {
			if (!verifyRequiredNonNegNumber('properties', 'controlNumber')) {
				alert("Control Number must be a non negative number.");
				return false;
	        }
	        
   			if (!verifyRequiredNonNegNumber('properties', 'controlNumberCap')) {
				alert("Control Number Cap must be a non negative number.");
				return false;
	        }


			if(parseInt(document.properties.controlNumber.value) > parseInt(document.properties.controlNumberCap.value)) {
				alert("Control Number must be less than Control Number Cap");
				document.properties.controlNumber.focus();
				return false;
	        }

			%ifvar mode equals('edit')%
			%else%

				if (document.properties.senderID.value == "" || document.properties.senderID.value.length > 35)
				{
					//alert ("Please specify a Sender ID");
					alert ("Invalid Sender ID: valid length 1-35");
					document.properties.senderID.focus();
					return false;
				}

				if (document.properties.senderQual.value != "" && document.properties.senderQual.value.length > 25)
				{
					alert ("Invalid Sender Qualifier: valid length 1-25");
					document.properties.senderQual.focus();
					return false;
				}

				if (document.properties.receiverID.value == "" || document.properties.receiverID.value.length > 35)
				{
					alert ("Invalid Receiver ID: valid length 1-35");
					document.properties.receiverID.focus();
					return false;
				}

				if (document.properties.receiverQual.value != "" && document.properties.receiverQual.value.length > 25)
				{
					alert ("Invalid Receiver Qualifier: valid length 1-25");
					document.properties.receiverQual.focus();
					return false;
				}

				if (document.properties.version.value == "" || document.properties.version.value.length > 10)
				{
					alert ("Invalid Version: valid length 1-10");
					document.properties.version.focus();
					return false;
				}

				if (document.properties.isEnv[0].checked)
				{
					document.properties.groupType.value = "ENVELOPE"
				}
				else
				{
					if (document.properties.tmpGroupType.value == "" || document.properties.tmpGroupType.value.length > 10)
					{
						alert ("Invalid Group Type: valid length 1-10");
						document.properties.tmpGroupType.focus();
						return false;
					}
					document.properties.groupType.value = document.properties.tmpGroupType.value;
				}
			%endif%

			return true;
			
		}
		
		function appendListURL(f, name)
		{
			var s = "";
			if (f != undefined) {
		
				if (f.length == undefined) {
					s += "&" + name + "="+f.value;
				} else {
					for (var i=0; i<f.length; i++)
						s += "&" + name + "="+f[i].value;
				}
			}
			
			return s;	
			
		}
		
		function appendURL(s)
		{
			var v, i;

			if (document.properties.search.value == "true")
			{
	
				v =  s + "?search=true"
				       + "&searchSenderID=" + escape(document.properties.searchSenderID.value)
				       + "&searchSenderQual=" + escape(document.properties.searchSenderQual.value)
				       + "&searchReceiverID=" + escape(document.properties.searchReceiverID.value)
				       + "&searchReceiverQual=" + escape(document.properties.searchReceiverQual.value);

				v += appendListURL(document.properties.searchProductionMode, "searchProductionMode") + 
				     appendListURL(document.properties.searchSortBy, "searchSortBy") + 
				     appendListURL(document.properties.searchStandard, "searchStandard");
							       
				v += "&searchVersion=" + escape(document.properties.searchVersion.value)
				     + "&searchGroupTypeEnv=" + escape(document.properties.searchGroupTypeEnv.value)
				     + "&searchGroupTypeGroups=" + escape(document.properties.searchGroupTypeGroups.value)			       				       				       
				     + "&searchGroupTypeOthersText=" + escape(document.properties.searchGroupTypeOthersText.value)
				     + "&searchMaxResult="+document.properties.searchMaxResult.value;
			} else {
				v = s + "?search=false";
			}		
	
			return v;
			
		}
		</SCRIPT>
	
	</HEAD>
	
	<body onLoad="setupData();">
	
	<TABLE width="100%">
		<TR>
			<TD class="menusection-Adapters" colspan=2>
				Control Number &gt;
					%ifvar mode equals('edit')%Edit
					%else%
						%ifvar mode equals('add')%Add
						%else%
							%ifvar mode equals('copy')%Copy
							%endif%
						%endif%
					%endif%
			
			</TD>
		</TR>
		<TR>
			<TD colspan="2">
				<UL>
					<LI><A href="CrossRefControlNumSearch.dsp">Return to Control Number</A></LI>
					%ifvar search equals('true')%
					<LI><A href="" onClick="this.href=appendURL('CrossRefControlNumSearch.dsp')">Return to Control Number &gt; Search</A></LI>
					%endif%
				</UL>
			</TD>
		</TR>	
		<TR>
			<TD>
				<TABLE class="tableForm" width=100%> 
				<form name="properties" method="post" action= "CrossRefControlNumSearch.dsp" onSubmit="return verify();">

					<input type="hidden" name="operation">
					<input type="hidden" name="envelopeID">
					

					<!-- saved search options -->
					<input type="hidden" name="search">
					<input type="hidden" name="searchSenderID">
					<input type="hidden" name="searchSenderQual">
					<input type="hidden" name="searchReceiverID">
					<input type="hidden" name="searchReceiverQual">
					
			%ifvar searchProductionModeList%
				%loop searchProductionModeList%
					<input type="hidden" name="searchProductionMode" value="%value searchProductionModeList%">
				%endloop%
			%endif%	
			%ifvar searchStandardList%
				%loop searchStandardList%
					<input type="hidden" name="searchStandard" value="%value searchStandardList%">
				%endloop%
			%endif%	

			%ifvar searchSortByList%
				%loop searchSortByList%
					<input type="hidden" name="searchSortBy" value="%value searchSortByList%">
				%endloop%
			%endif%	

			%ifvar mode equals('edit')%
				<input type="hidden" name="senderID" value="%value senderID%">
				<input type="hidden" name="senderQual" value="%value senderQual%">
				<input type="hidden" name="receiverID" value="%value receiverID%">
				<input type="hidden" name="receiverQual" value="%value receiverQual%">
				<input type="hidden" name="productionMode" value="%value productionMode%">
				<input type="hidden" name="standard" value="%value standard%">
				<input type="hidden" name="version" value="%value version%">
				<input type="hidden" name="groupType" value="%value groupType%">
			%endif%


					<input type="hidden" name="searchVersion">
					<input type="hidden" name="searchGroupTypeEnv">
					<input type="hidden" name="searchGroupTypeGroups">
					<input type="hidden" name="searchGroupTypeOthersText">
					<input type="hidden" name="searchMaxResult">


					<tr><td class="heading" colspan=4>ID Pair Information</td></tr>
					<tr>
						<td class="oddrow">Sender ID</td>
						<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
						<script>writeThisEdit('%value encode(htmlattr) mode%', 'senderID', '%value -code senderID%');</script></td>

						<td class="oddrow">Sender Qualifier</td>
						<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
						%ifvar senderQual equals('NULL')%%else%<script>writeThisEdit('%value encode(htmlattr) mode%', 'senderQual', '%value -code senderQual%');</script>%endif%&nbsp;</td>
					</tr>
					<tr>
						<td class="evenrow">Receiver ID</td>
						<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
						<script>writeThisEdit('%value encode(htmlattr) mode%', 'receiverID', '%value -code receiverID%');</script></td>

						<td class="evenrow">Receiver Qualifier</td>
						<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
						%ifvar receiverQual equals('NULL')%%else%<script>writeThisEdit('%value encode(htmlattr) mode%', 'receiverQual', '%value -code receiverQual%');</script>%endif%&nbsp;</td>
					</tr>

					<tr><td class="space" colspan="4">&nbsp;</td></tr>
					<tr><td class="heading" colspan=4>Control Number Information</td></tr>
					<tr>
						<td class="oddrow">Production Mode</td>
						<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
							%ifvar mode equals('edit')%
								<script>writeModeFromInt(%value productionMode%);</script>
							%else%
							<select name="productionMode">
								%ifvar productionMode equals('Production')% 
									<option	value="1003" selected>Production</option>
								%else%
									<option	value="1003">Production</option>
								%endif%	
								%ifvar productionMode equals('Testing')% 
									<option	value="1004" selected>Testing</option>
								%else%
									<option	value="1004">Testing</option>
								%endif%	
								%ifvar productionMode equals('Custom')% 
									<option	value="1005" selected>Custom</option>
								%else%
									<option	value="1005">Custom</option>
								%endif%	
							</select>
							%endif%
						</td>
						<td class="oddrow">Standard</td>
						<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
							%ifvar mode equals('edit')%
								%value standard%
							%else%
							<select name="standard">
								%ifvar standard equals('X12')% 
									<option	value="X12" selected>X12</option>
								%else%
									<option	value="X12">X12</option>
								%endif%	
								%ifvar standard equals('UNEDIFACT')% 
									<option	value="UNEDIFACT" selected>UNEDIFACT</option>
								%else%
									<option	value="UNEDIFACT">UNEDIFACT</option>
								%endif%	
								%ifvar standard equals('EANCOM')% 
									<option	value="EANCOM" selected>EANCOM</option>
								%else%
									<option	value="EANCOM">EANCOM</option>
								%endif%	
								%ifvar standard equals('UCS')% 
									<option	value="UCS" selected>UCS</option>
								%else%
									<option	value="UCS">UCS</option>
								%endif%	
								%ifvar standard equals('VICS')% 
									<option	value="VICS" selected>VICS</option>
								%else%
									<option	value="VICS">VICS</option>
								%endif%
								%ifvar standard equals('ODETTE')% 
									<option	value="ODETTE" selected>ODETTE</option>
								%else%
									<option	value="ODETTE">ODETTE</option>
								%endif%	
								%ifvar standard equals('TRADACOMS')% 
									<option	value="TRADACOMS" selected>TRADACOMS</option>
								%else%
									<option	value="TRADACOMS">TRADACOMS</option>
								%endif%	
							</select>
							%endif%
						</td>
					</tr>

					<tr>
						<td class="evenrow">Version</td>
						<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
						<script>writeThisEdit('%value encode(htmlattr) mode%', 'version', '%value version encode(xml)%');</script></td>
						
						<td class="evenrow">Group Type</td>
						<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
						%ifvar mode equals('edit')%
							%ifvar groupType equals('ENVELOPE')%
								Envelope
							%else%
								%value -code groupType encode(xml)%
							%endif%
						%else%
							<input type="radio" name="isEnv" value="envelope">Envelope<BR>
							<input type="radio" name="isEnv" value="group" CHECKED>Group&nbsp;<input type="text" name="tmpGroupType">
							<input type="hidden" name="groupType">
						%endif%
						
						</td>
					</tr>
						
					<tr>
						<td class="oddrow">Control Number</td>
						<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
						<script>writeThisEdit('%value encode(htmlattr) mode%', 'controlNumber', '%value -code controlNumber encode(xml)%');</script></td>
						
						<td class="oddrow">Control Number Cap</td>
						<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
						<script>writeThisEdit('%value encode(htmlattr) mode%', 'controlNumberCap', '%value -code controlNumberCap encode(xml)%');</script></td>
					</tr>

					<tr>
						<td class="evenrow">Control Number Minimum</td>
						<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
						<script>writeThisEdit('%value encode(htmlattr) mode%', 'controlNumberMin', '%value -code controlNumberMin encode(xml)%');</script></td>
						
						<td class="evenrow">Control Number Increment</td>
						<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
						<script>writeThisEdit('%value encode(htmlattr) mode%', 'controlNumberInc', '%value -code controlNumberInc encode(xml)%');</script></td>
					</tr>

					<tr>
						<td class="oddrow">Control Number Window</td>
						<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
						<script>writeThisEdit('%value encode(htmlattr) mode%', 'controlNumberWindow', '%value -code controlNumberWindow encode(xml)%');</script></td>
						
						<td class="oddrow" colspan="2">&nbsp;</td>
					</tr>
					
					<tr>
						<td colspan="4" class="action">
							<input type="submit" value="Save Changes">
						</td>
					</tr>

				</form>
				</table>
			</td>
		</tr>


		</table>
%endinvoke%
  </body>
</html>
