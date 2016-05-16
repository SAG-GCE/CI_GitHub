<HTML>
	<HEAD>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">
		<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
		<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
		<SCRIPT SRC="CrossRefUtil.js.txt"></SCRIPT>
		<TITLE>Envelope Information -- Detail</TITLE>
	
		<SCRIPT Language="JavaScript">
	
		function writeThisEdit(mode, name, value)
		{

			if (mode == 'add') {
				writeEdit('edit', name, value);
			} else if  (mode == 'copy') {
				writeEdit('edit', name, value);
			} else { // edit
				if (name == 'senderID' || name == 'senderQual' || name == 'receiverID' || name == 'receiverQual')
				{
					if (value != "")
					{
						writeEdit('view', name, value);
					}
					w("<INPUT TYPE=\"HIDDEN\" NAME=\"" + name  +"\" VALUE=\"" + value +"\">");	
				}
				else
					writeEdit('edit', name, value);
			}
		}

		function setupData()
		{
			//alert( '%value mode%');
			document.properties.operation.value = "%value mode%";
			//%ifvar envelopeID%
			//	document.properties.envelopeID.value = "%value envelopeID%";
			//%endif%

			//alert("done setupData()");
			
			var ss;
			%ifvar search equals('true')%
				document.properties.search.value = "true";
				document.properties.searchSenderID.value = "%value searchSenderID%";
				document.properties.searchSenderQual.value = "%value searchSenderQual%";
				document.properties.searchReceiverID.value = "%value searchReceiverID%";
				document.properties.searchReceiverQual.value = "%value searchReceiverQual%";

		
				document.properties.searchMaxResult.value = "%value searchMaxResult%";
			%else%
				document.properties.search.value = "false";
			%endif%
			
		}


		function verify() {
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
				v =  s + "search=true"
				       + "&searchSenderID=" + escape(document.properties.searchSenderID.value)
				       + "&searchSenderQual=" + escape(document.properties.searchSenderQual.value)
				       + "&searchReceiverID=" + escape(document.properties.searchReceiverID.value)
				       + "&searchReceiverQual=" + escape(document.properties.searchReceiverQual.value);

				v += appendListURL(document.properties.searchProductionMode, "searchProductionMode") + 
				     appendListURL(document.properties.searchSortBy, "searchSortBy"); 
	
				v += "&searchMaxResult="+document.properties.searchMaxResult.value;
			} else {
				v = s + "search=false";
			}
//	alert(v );		
			return v;
			
		}
		</SCRIPT>
	
	</HEAD>
	
	<body onLoad="setupData();">
	
	<TABLE width="100%">

		<TR>
			<TD class="menusection-Packages" colspan=2>
				Interchange Information Detail &gt;
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
					<LI><A href="CrossRefEnvSearch.dsp">Return to Interchange Information</A></LI>
					%ifvar search equals('true')%
					<LI><A href="" onClick="this.href=appendURL('CrossRefEnvSearch.dsp?')">Return to Interchange Information &gt; Search</A></LI>
					%endif%
				</UL>
			</TD>
		</TR>	
		<TR>
			<TD>
				<TABLE class="tableForm" width=100%> 
				<form name="properties" method="post" action="CrossRefEnvSearch.dsp" onsubmit="return verify();">

					<input type="hidden" name="operation">
					<!--input type="hidden" name="envelopeID" -->
					

					
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
			%ifvar searchSortByList%
				%loop searchSortByList%
					<input type="hidden" name="searchSortBy" value="%value searchSortByList%">
				%endloop%
			%endif%	
					<input type="hidden" name="searchMaxResult">

			%ifvar mode equals('add')%
			%else%
				%invoke wm.b2b.editn.crossRef:getEnvInfo%
				%endinvoke%
			%endif%

			%invoke wm.b2b.editn.crossRef:getProfileList%
			%endinvoke%

					<tr>
						<td valign=top>
						<!-- mode: add, edit, copy -->
							<!-- LEFT TABLE -->
							<table class="tableForm" width="100%">
		
								<tr><td class="heading" colspan=2>ID Qualifiers</td></tr>
								<tr>
									<td class="oddrow">Sender ID</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'senderID', '%value -code senderID%');</script></td>
								</tr>
								<tr>
									<td class="evenrow">Sender Qualifier</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
									%ifvar senderQual equals('NULL')%
										<script>writeThisEdit('%value encode(htmlattr) mode%', 'senderQual', '');</script></td>
									%else%
										<script>writeThisEdit('%value encode(htmlattr) mode%', 'senderQual', '%value -code senderQual%');</script></td>
									%endif%
								</tr>
								<tr>
									<td class="oddrow">Receiver ID</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'receiverID', '%value -code receiverID%');</script></td>
								</tr>
								<tr>
									<td class="evenrow">Receiver Qualifier</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
									%ifvar receiverQual equals('NULL')%
										<script>writeThisEdit('%value encode(htmlattr) mode%', 'receiverQual', '');</script></td>
									%else%
										<script>writeThisEdit('%value encode(htmlattr) mode%', 'receiverQual', '%value -code receiverQual%');</script></td>
									%endif%
								</tr>
	
								<tr><td class="space" colspan="2">&nbsp;</td></tr>
								<tr><td class="heading" colspan=2>Envelope Information</td></tr>
								<tr>
									<td class="oddrow">Production Mode</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
										%ifvar mode equals('edit')%
											<script>writeModeFromInt(%value productionMode%);</script>
											<INPUT TYPE="HIDDEN" NAME="productionMode" VALUE="%value productionMode%">
										%else%
										<select name="productionMode">
											%ifvar productionMode equals('1003')% 
												<option	value="1003" selected>Production</option>
											%else%
												<option	value="1003">Production</option>
											%endif%	
											%ifvar productionMode equals('1004')% 
												<option	value="1004" selected>Testing</option>
											%else%
												<option	value="1004">Testing</option>
											%endif%	
											%ifvar productionMode equals('1005')% 
												<option	value="1005" selected>Custom</option>
											%else%
												<option	value="1005">Custom</option>
											%endif%	

										</select>
										%endif%
									</td>
								</tr>

								<tr><td class="space" colspan="2">&nbsp;</td></tr>
								<tr><td class="heading" colspan=2>Inbound Information</td></tr>
								<tr>
									<td class="oddrow">Create Doc</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
										%ifvar /envInfo/inboundInfo/createDoc equals('yes')%
											<input type="radio" value="yes" name="createDoc" CHECKED>Yes
											<input type="radio" name="createDoc" value="no">No
										%else%
											<input type="radio" value="yes" name="createDoc">Yes
											<input type="radio" name="createDoc" value="no" CHECKED>No
										%endif%
									</td>
								</tr>
								<tr>
									<td class="evenrow">Group Sender Qualifier</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrow-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'GSSenderQual', '%value -code /envInfo/inboundInfo/GSSenderQual%');</script></td>
								</tr>
								<tr>
									<td class="oddrow">Group Receiver Qualifier</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'GSReceiverQual', '%value -code /envInfo/inboundInfo/GSReceiverQual%');</script></td>
								</tr>	
								<tr><td class="space" colspan="2">&nbsp;</td></tr>
								<tr><td class="heading" colspan="2">Inbound Information - Control Number Validation</td></tr>
								<tr>
									<td class="oddrow">Validate inbound envelope control numbers</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">

										%ifvar /envInfo/inboundInfo/verifyCtrl equals('yes')%
											<input type="radio" value="yes" name="verifyCtrl" CHECKED>Yes
											<input type="radio" name="verifyCtrl" value="no">No
										%else%
											<input type="radio" value="yes" name="verifyCtrl">Yes
											<input type="radio" name="verifyCtrl" value="no" CHECKED>No
										%endif%

									</td>
								</tr>
								<tr>
									<td class="evenrow">Duplicate control number action</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
										<select name="duplicateControlNumberAction">
											<option value="ProcessNormally" %ifvar /envInfo/inboundInfo/ControlNumberManagement/duplicateControlNumberAction equals('ProcessNormally')% SELECTED%endif%>Process Normally</option>
											<option value="Reject" %ifvar /envInfo/inboundInfo/ControlNumberManagement/duplicateControlNumberAction equals('Reject')% SELECTED%endif%>Reject</option>
											<option value="Error & Continue" %ifvar /envInfo/inboundInfo/ControlNumberManagement/duplicateControlNumberAction equals('Error & Continue')% SELECTED%endif%>Error &amp; continue</option>
										</select>
									</td>
								</tr>
								<tr>
									<td class="oddrow">Out of sequence control number action</td>
									</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
										<select name="outOfSequenceControlNumberAction">
											<option value="ProcessNormally" %ifvar /envInfo/inboundInfo/ControlNumberManagement/outOfSequenceControlNumberAction equals('ProcessNormally')% selected%endif%>Process Normally</option>
											<option value="Reject" %ifvar /envInfo/inboundInfo/ControlNumberManagement/outOfSequenceControlNumberAction equals('Reject')% selected%endif%>Reject</option>
											<option value="Error & Continue"%ifvar /envInfo/inboundInfo/ControlNumberManagement/outOfSequenceControlNumberAction equals('Error & Continue')% selected%endif%>Error &amp; continue</option>
										</select>
									</td>
								</tr>
								<tr><td class="space" colspan="2">&nbsp;</td></tr>
								<tr><td class="heading" colspan="2">Inbound Information - FA Generation</td></tr>
								<tr>
									<td class="oddrow">Auto Generate FA</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
										%ifvar /envInfo/inboundInfo/FAGeneration/autoGenerateFA equals('On')%
											<input type="radio" value="On" name="autoGenerateFA" CHECKED>On
											<input type="radio" value="Per Document" name="autoGenerateFA">Per Document
											<input type="radio" value="Off" name="autoGenerateFA">Off
										%else%
											%ifvar /envInfo/inboundInfo/FAGeneration/autoGenerateFA equals('Per Document')%
												<input type="radio" value="On" name="autoGenerateFA">On
												<input type="radio" value="Per Document" name="autoGenerateFA" CHECKED>Per Document
												<input type="radio" value="Off" name="autoGenerateFA">Off
											%else%
												<input type="radio" value="On" name="autoGenerateFA">On
												<input type="radio" value="Per Document" name="autoGenerateFA">Per Document
												<input type="radio" value="Off" name="autoGenerateFA" CHECKED>Off
											%endif%
										%endif%
									</td>
								</tr>
								<tr>
									<td class="evenrow">FA Level</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
										<select name="FALevel">
											<option value="Default" %ifvar /envInfo/inboundInfo/FAGeneration/FALevel equals('Default')% SELECTED%endif%>Default</option>
											<option value="TransactionSet" %ifvar /envInfo/inboundInfo/FAGeneration/FALevel equals('TransactionSet')% SELECTED%endif%>Transaction Set</option>
											<option value="Segment" %ifvar /envInfo/inboundInfo/FAGeneration/FALevel equals('Segment')% SELECTED%endif%>Segment</option>
											<option value="Element" %ifvar /envInfo/inboundInfo/FAGeneration/FALevel equals('Element')% SELECTED%endif%>Element</option>
										</select>
									</td>
								</tr>
								<tr>
									<td class="oddrow">Process Document</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
										<select name="processDocument">
											<option value="All" %ifvar /envInfo/inboundInfo/FAGeneration/processDocument equals('All')% selected%endif%>All</option>
											<option value="Only Accepted" %ifvar /envInfo/inboundInfo/FAGeneration/processDocument equals('Only Accepted')% selected%endif%>Only Accepted</option>
											<option value="Not Rejected" %ifvar /envInfo/inboundInfo/FAGeneration/processDocument equals('Not Rejected')% selected%endif%>Not Rejected</option>
										</select>
									</td>
								</tr>
								<tr>
									<td class="evenrow">Generate Control Number</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
										<select name="generateControlNumber">
											<option value="FromInboundDocument" %ifvar /envInfo/inboundInfo/FAGeneration/generateControlNumber equals('FromInboundDocument')% selected%endif%>From Inbound Document</option>
											<option value="Random" %ifvar /envInfo/inboundInfo/FAGeneration/generateControlNumber equals('Random')% selected%endif%>Random</option>
											<option value="FromControlNumberTable" %ifvar /envInfo/inboundInfo/FAGeneration/generateControlNumber equals('FromControlNumberTable')% selected%endif%>From Control Number Table</option>
										</select>
									</td>
								</tr>

								<tr>
									<td class="oddrowdata-l" colspan="2">Rejection Rules</td>
								</tr>
								<tr>
									<td class="evenrow">Syntax Error Status</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
										<select name="syntaxErrorStatus">
											<option value="Rejected" %ifvar /envInfo/inboundInfo/FAGeneration/RejectionRules/syntaxErrorStatus equals('Rejected')% selected%endif%>Rejected</option>
											<option value="Accepted" %ifvar /envInfo/inboundInfo/FAGeneration/RejectionRules/syntaxErrorStatus equals('Accepted')% selected%endif%>Accepted</option>
											<option value="Accepted, But Errors Were Noted" %ifvar /envInfo/inboundInfo/FAGeneration/RejectionRules/syntaxErrorStatus equals('Accepted, But Errors Were Noted')% selected%endif%>Accepted, But Errors Were Noted</option>
										</select>
									</td>
								</tr>
								<tr>
									<td class="oddrow">Logical Error Status</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
										<select name="logicalErrorStatus">
											<option value="Rejected" %ifvar /envInfo/inboundInfo/FAGeneration/RejectionRules/logicalErrorStatus equals('Rejected')% selected%endif%>Rejected</option>
											<option value="Accepted" %ifvar /envInfo/inboundInfo/FAGeneration/RejectionRules/logicalErrorStatus equals('Accepted')% selected%endif%>Accepted</option>
											<option value="Accepted, But Errors Were Noted" %ifvar /envInfo/inboundInfo/FAGeneration/RejectionRules/logicalErrorStatus equals('Accepted, But Errors Were Noted')% selected%endif%>Accepted, But Errors Were Noted</option>
										</select>
									</td>
								</tr>
								<tr>
									<td class="evenrow">Child Transaction Rejected Status</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
										<select name="childTransactionRejectedStatus">
											<option value="Rejected" %ifvar /envInfo/inboundInfo/FAGeneration/RejectionRules/childTransactionRejectedStatus equals('Rejected')% selected%endif%>Rejected</option>
											<!-- option value="Accepted" %ifvar /envInfo/inboundInfo/FAGeneration/RejectionRules/childTransactionRejectedStatus equals('Accepted')% selected%endif%>Accepted</option -->
											<option value="Accepted, But Errors Were Noted" %ifvar /envInfo/inboundInfo/FAGeneration/RejectionRules/childTransactionRejectedStatus equals('Accepted, But Errors Were Noted')% selected%endif%>Accepted, But Errors Were Noted</option>
											<option value="Partially Accepted" %ifvar /envInfo/inboundInfo/FAGeneration/RejectionRules/childTransactionRejectedStatus equals('Partially Accepted')% selected%endif%>Partially Accepted</option>
										</select>
									</td>
								</tr>
								<tr><td class="space" colspan="2">&nbsp;</td></tr>
								<tr><td class="heading" colspan="2">Outbound Information - FA Generation</td></tr>
								<tr>
									<td class="oddrow">Sender</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
										<select name="FASender">
											%loop /profileList%
											<option value="%value ProfileID%" %ifvar /envInfo/outboundInfo/FAGeneration/FASender vequals(ProfileID)% SELECTED%endif%>%value CorporationName%</option>
											%endloop%
										</select>
									</td>
								</tr>
								<tr>
									<td class="evenrow">Receiver</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
										<select name="FAReceiver">
											%loop /profileList%
											<option value="%value ProfileID%" %ifvar /envInfo/outboundInfo/FAGeneration/FAReceiver vequals(ProfileID)% SELECTED%endif%>%value CorporationName%</option>
											%endloop%
										</select>
									</td>
								</tr>


								<tr>
									<td class="oddrow">Add Group</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">

										%ifvar /envInfo/outboundInfo/FAGeneration/addGroup equals('yes')%
											<input type="radio" value="yes" name="addGroup" CHECKED>Yes
											<input type="radio" name="addGroup" value="no">No
										%else%
											<input type="radio" value="yes" name="addGroup">Yes
											<input type="radio" name="addGroup" value="no" CHECKED>No
										%endif%

									</td>
								</tr>

								<tr>
									<td class="oddrow">Control Number With Leading Zero</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">

										%ifvar /envInfo/outboundInfo/FAGeneration/ctlNumberWleadingZero equals('yes')%
											<input type="radio" value="yes" name="ctlNumberWleadingZero" CHECKED>Yes
											<input type="radio" name="ctlNumberWleadingZero" value="no">No
										%else%
											<input type="radio" value="yes" name="ctlNumberWleadingZero">Yes
											<input type="radio" name="ctlNumberWleadingZero" value="no" CHECKED>No
										%endif%

									</td>
								</tr>
							</table>
						</td>

					<!-- END OF LEFT TABLE -->

					<!-- RIGHT TABLE -->

						<td valign=top>
							<table class="tableForm" width=100% >
								<tr><td class="heading" colspan=3>Outbound Information - Delimiters</td></tr>
								<tr>
									<td class="oddrow" colspan="2">Segment</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'segment', '%value -code /envInfo/outboundInfo/segment%');</script></td>
								</tr>
								<tr>
									<td class="evenrow" colspan="2">Field</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'field', '%value -code /envInfo/outboundInfo/field%');</script></td>
								</tr>
								<tr>
									<td class="oddrow" colspan="2">Subfield</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'subfield', '%value -code /envInfo/outboundInfo/subfield%');</script></td>
								</tr>
								<tr>
									<td class="evenrow" colspan="2">Release</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'release', '%value -code /envInfo/outboundInfo/release%');</script></td>
								</tr>
								<tr>
									<td class="oddrow" colspan="2">Decimal</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'decimal', '%value -code /envInfo/outboundInfo/decimal%');</script></td>
								</tr>

								<tr><td class="space" colspan="3">&nbsp;</td></tr>

								<tr><td class="heading" colspan=3>Outound Information - Envelope Infomation</td></tr>
					
								<tr>
									<td class="oddrow" nowrap rowspan=7>ISA</td>
									<td class="oddrow">ISA01</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'isa01', '%value -code /envInfo/outboundInfo/isa01%');</script></td>
								</tr>
								<tr>
									<td class="evenrow">ISA02</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'isa02', '%value -code /envInfo/outboundInfo/isa02%');</script></td>
								</tr>
								<tr>
									<td class="oddrow">ISA03</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'isa03', '%value -code /envInfo/outboundInfo/isa03%');</script></td>
								<tr>
									<td class="evenrow">ISA04</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'isa04', '%value -code /envInfo/outboundInfo/isa04%');</script></td>
								</tr>
								<tr>
									<td class="oddrow">ISA11</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'isa11', '%value -code /envInfo/outboundInfo/isa11%');</script></td>
								</tr>
								<tr>
									<td class="evenrow">ISA12</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%evenrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'isa12', '%value -code /envInfo/outboundInfo/isa12%');</script></td>
								</tr>
								<tr>
									<td class="oddrow">ISA14</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%oddrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'isa14', '%value -code /envInfo/outboundInfo/isa14%');</script></td>
								</tr>
							<!-- /tr -->
			
								<tr>
									<td class="oddrow" nowrap rowspan=7>UNB</td>
									<td class="evenrow">UNB01</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'unb01', '%value -code /envInfo/outboundInfo/unb01%');</script></td>
								</tr>
								<tr>
									<td class="oddrow">UNB06</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'unb06', '%value -code /envInfo/outboundInfo/unb06%');</script></td>
								</tr>
								<tr>
									<td class="evenrow">UNB07</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'unb07', '%value -code /envInfo/outboundInfo/unb07%');</script></td>
								</tr>
								<tr>
									<td class="oddrow">UNB08</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'unb08', '%value -code /envInfo/outboundInfo/unb08%');</script></td>
								</tr>
								<tr>
									<td class="evenrow">UNB09</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'unb09', '%value -code /envInfo/outboundInfo/unb09%');</script></td>
								</tr>
								<tr>
									<td class="oddrow">UNB10</td>
									<td class="%ifvar ../mode equals('edit')%oddrow-l%else%oddrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'unb10', '%value -code /envInfo/outboundInfo/unb10%');</script></td>
								</tr>
								<tr>
									<td class="evenrow">UNB11</td>
									<td class="%ifvar ../mode equals('edit')%evenrow-l%else%evenrowdata-l%endif%">
									<script>writeThisEdit('%value encode(htmlattr) mode%', 'unb011', '%value -code /envInfo/outboundInfo/unb011%');</script></td>
								</tr>

							</table>

						<tr>
							<td colspan="2" class="action">
								<input type="submit" value="Save Changes">
							</td>
						</tr>

			
				</form>
				</table>
			</td>
		</tr>


		</table>
  </body>
</html>

