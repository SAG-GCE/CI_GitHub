<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="-1">
		<title>EDIINT Configuration</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<base target="_self">
		<style>
			.listbox  { width: 100%; }
		</style>
		<script src="webMethods.js.txt"></script>

	</head>

<script Language="JavaScript">
function varify(form){

	if (form.submitPayloadCB.checked)
		form.submitPayload.value = 'true';
	else
		form.submitPayload.value = 'false';

	if (form.EDIINTIDMatchCB.checked)
		form.EDIINTIDMatch.value = 'true';
	else
		form.EDIINTIDMatch.value = 'false';

	return true;
}
</script>

	<body class="main" onLoad="">
		<table width=100% >
			<tr>
				<td class="menusection-Server" colspan=2>Configuration</td>
			</tr>
			%invoke wm.EDIINT.util:EDIINTProperty%
			
				%ifvar action equals('set')%
					<TR><TD class="message" colspan="2">Properties changed successfully</TD></TR>
      			%endif%
			%endinvoke%



			<tr><td>&nbsp;</td><tr>

			
		<tr>
			<td>
				<table width="100%">
					<FORM name="EDIINTProperty" METHOD="POST" ACTION="Configuration.dsp" onSubmit="return varify(this)" target="">
					<input type="hidden" name="action" value="set">
					<!-- title bar -->
					<tr>
						<td class="heading" colspan=2>EDIINT Properties</td>
					</tr>

					<!-- table labels --->
					<tr>
						<td nowrap class="oddcol">Key</td>
						<td nowrap class="oddcol">Value</td>
					</tr>

					<!-- mailhost row -->
					<tr>
						<td nowrap class="evenrow">
							SMTP Server:port (port is optional)
						</td>
						<td nowrap class="evencol-l">&nbsp;
							<input type="text" name="mailhost" size="30" 
							%ifvar mailhost%
								value="%value mailhost%">
							%else%
								value="">
							%endif%
						</td>
					</tr>

					<!-- submit payload row -->
					<tr>
						<td nowrap class="oddrow">
							Submit payload to TN
						</td>
						<td nowrap class="oddcol-l">&nbsp;
							<input type="checkbox" name="submitPayloadCB" 
							%ifvar submitPayload equals('true')%
								checked = true
							%endif%
							>	
						</td>
					</tr>

					<!-- userProcessPayloadService row -->
					<tr>
						<td nowrap class="evenrow">
							User Process Payload Service
						</td>
						<td nowrap class="evencol-l">&nbsp;
							<input type="text" name="userProcessPayloadService" size="30" 
							%ifvar userProcessPayloadService%
								value="%value userProcessPayloadService%">
							%else%
								value="">
							%endif%
						</td>
					</tr>

					<!-- EDIINT ID Match row -->
					<tr>
						<td nowrap class="oddrow">
							EDIINT ID Match
						</td>
						<td nowrap class="oddcol-l">&nbsp;
							<input type="checkbox" name="EDIINTIDMatchCB" 
							%ifvar EDIINTIDMatch equals('true')%
								checked = true
							%endif%
							>	
						</td>

					</tr>

					<input type="hidden" name="submitPayload" value="">
					<input type="hidden" name="EDIINTIDMatch" value="">

                    <tr>
                      <td class="action" colspan="2">
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
