<html>
	<head>
		<title>Create FA report
		</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
				
		<style>
			.listbox  { width: 100%; }
		</style>
		<script src="/WmRoot/webMethods.js.txt">
		</script>

	</head>

	<body class="main" onLoad="">

		<table width=100% >
			<tr>
				<td class="menusection-Settings" colspan=2>List FA Reports  &gt;  Delete confirmation</td>
			</tr>
				
			<tr><td>&nbsp;</td></tr>
		</table>
	
		
		%ifvar out -notempty%
	
		<b>The following FA reports will be deleted:</b>
	
		%scope param(doDelete='no')%
	
		%invoke wm.b2b.editn.FAReport:getCheckedFiles%
	
		<form name="DataForm" method="POST" action="doDelete.dsp">
		
		<table width=100% >
			<tr>
				<th class="heading" colspan="2">Checked Report list:<p>
				</th>
			</tr>
			
			<script>resetRows();</script>
						
			%loop deleteFileList%
												
			<tr>
				<th class="evenrow-l" nowrap>
							
		 		%value deleteFileList% <p>
							
		 		</th>
			</tr>
<input type="hidden" name="deleteFile" value="%value deleteFileList%">
			
			%endloop%
		</table>
					
		<input type="hidden" name="out" value="%value out%">
			
			
		<input type="submit" value="Continue"  >
					
		</form>
		
		%endinvoke%
		
		%end scope %	
		
		%else%
		
		<table>	
			<tr>
				<td class="rowdata" colspan="5"><b>No file to delete</b>
				</td>
			</tr>
	
		</table>
			%onerror%
				
				%value error% <BR>
				%value errorMessage% <BR>
	
	
		%endif%
	
						
	</body>
</html>
