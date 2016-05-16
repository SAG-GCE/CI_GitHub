<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="-1">
		<title>Install TN Document Types</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<base target="_self">
        <style>
			.listbox  { width: 100%; }
		</style>
		<script src="/WmRoot/webMethods.js.txt"></script>
		<script src="/WmEDIforTN/selStdVer.js.txt"></script>

	</head>

	<body onLoad="setNavigation('InstallDocType.dsp', '', 'foo');">
		<table width=100% >
			<tr>
				<td class="menusection-Logs" colspan=2>Install TN Document Types</td>
			</tr>
			<tr></tr>
			%ifvar standard%
				%invoke wm.b2b.editn:installEDITypes%
				<TR><TD class="message" colspan="2">%value Message%</TD></TR>
				%onerror%
					<TR><TD class="message" colspan="2">
						<P><B>The following error occurred while attempting to create the template:</B></P> 
						<P><B>Service: </B>%value errorService%<br>
						<B>Error: </B>%value error%</P>
					</TD></TR>	
				%endinvoke%
			%else%
				<TR><TD class="evenrow-l" colspan="2">
					<BR>
					Install TN document types for EDI document into webMethods Trading Networks.
					<BR><BR>
				</TD></TR>  
			%endif%		

			
			<tr>
				<td>
					<table width="100%">
						<FORM name="EDIDocType" METHOD="POST" ACTION="InstallDocType.dsp" target="">
						<!-- title bar -->
						<tr>
							<td class="heading" colspan=2>Document Type</td>      
						</tr>

						<!-- table labels --->
						<tr>
							<td nowrap class="oddrow">Standard</td>
							<td nowrap class="oddcol-l">&nbsp;     
							<select NAME="standard" onChange="javascript:doSelectStandard(this.form);">
								<option value="error">-- EDI standard --
								%invoke wm.b2b.editn.util.VersionSupport:getInstallableStandards%
								%loop standards%
								<option value="%value%">%value%
								%endloop%
								%endinvoke%
							</select>
							</td>
						</tr>

						<!-- mailhost row -->
						<tr>
							<td nowrap class="evenrow">Version</td>
							<td nowrap class="evencol-l">&nbsp;
							<select name="version" onChange="javascript:doSelectVersion(this.form);">    
							</select>
							</td>
						</tr>

						<!-- submit payload row -->
						<tr>
							<td nowrap class="oddrow">Transaction Set</td>    
							<td nowrap class="oddcol-l">&nbsp; 
							<select name="transactionSet">    
							</select>
							</td>
						</tr>

						<tr>
							<td class="action" colspan="2">
							<input type="submit" value="Add Document Type Definition to Trading Network">
							</td>
						</tr>
						</form>
					</table>
				</td>
			</tr>
		</table>
	</body>
</html>
