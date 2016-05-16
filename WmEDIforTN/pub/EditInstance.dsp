<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="-1">
		<title>Define Instance ID Queries</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<base target="_self">
		<style>
			.listbox  { width: 100%; }
		</style>
		<script src="/WmRoot/webMethods.js.txt"></script>

<script>
		<!--
			var data = new Array();
			//var msg = "";
/*			%ifvar ACTION equals('SAVE')%
				%invoke wm.b2b.editn.doc:saveQuery%
					msg = "Document %value DocumentName% Saved";
				%onerror%
					msg = "Error occured while saving doc type: %value DocumentName%";
				%endinvoke%
			%endif%	
*/
			function init () 
			{
				var i = 0;
			
				%invoke wm.b2b.editn.doc:listTransactionTypes%
					document.EDIT.DocumentName.options[i] = new Option ("<SELECT DOC TYPE>", "<SELECT DOC TYPE>");
					data["<SELECT DOC TYPE>"] = new Array ('', '');
					i++;
					%loop DocTypes%
						data["%value Name%"] = '%value Query%';
						document.EDIT.DocumentName.options[i] = new Option ("%value Name%", "%value Name%");
						i++
					%endloop%
				%onerror%
				%endinvoke%
				//if (msg != "")
				//{
				//	alert (msg);
				//}
			}

			function set () 
			{
				var index = document.EDIT.DocumentName.selectedIndex;
				var name = document.EDIT.DocumentName.options[index].value;
				document.EDIT.Query.value = data[name];
			}

			function validate (x)
			{
				var index = document.EDIT.DocumentName.selectedIndex;
				if (index == 0) 
				{
					alert ("Please select a Document Type");
					return false;
				}
				return true;
			}
			-->

		</script>


	</head>

	<body class="main"  ONLOAD="init(); setNavigation('EditInstance.dsp', '', 'foo');">
		<table width=100% >
			<tr>
				<td class="menusection-Solutions" colspan=2>Enter and Edit EDI Instance ID Queries***</td>
			</tr>
			%ifvar ACTION equals('SAVE')%  
				%invoke wm.b2b.editn.doc:saveQuery%  
					<TR><TD class="message" colspan="2">Document %value DocumentName% Saved</TD></TR>  
				%onerror%
					<TR><TD class="message" colspan="2">Error occurred while saving doc type: %value DocumentName%</TD></TR>
				%endinvoke%
			%endif%		 
			<TR></TR>
			<tr>
				<td class="evenrow-l">
				<br>
				You must install the TN document type for an EDI document before 
				you can define an instance ID query for the TN document type.  
				<br><br>
				</td>
			</tr>
			<tr>
				<td>
					<table width="100%">
					<FORM ACTION="EditInstance.dsp" METHOD="POST" NAME="EDIT" onSubmit="return validate(this.form)" target="">
						<INPUT TYPE="HIDDEN" NAME="ACTION" VALUE="SAVE">
						<tr>
							<td class="heading" colspan=2>Query Properties</td>   
						</tr>

						<!-- table labels --->
						<tr>
							<td nowrap class="oddrow">Select Document Type</td>
							<td nowrap class="oddcol-l">&nbsp; 
								<SELECT NAME="DocumentName" ONCHANGE="javascript:set();">
								</SELECT>
							</td>
						</tr>

						<!-- mailhost row -->
						<tr>
							<td nowrap class="evenrow">Enter Instance Id Query</td>
							<td nowrap class="evencol-l">&nbsp; 
							<INPUT TYPE="TEXT" NAME="Query" SIZE="50">
							</td>
						</tr>
						<tr>
							<td class="action" colspan="2">
							<INPUT TYPE="SUBMIT" VALUE="Save">
							</td>
						</tr>
					</form>
					</table>
				</td>
			</tr>
		
		</table>
	</body>
</html>
