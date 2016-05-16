<html>
	<head>
		<title>Create FA report</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
					
		<style>
			.listbox  { width: 100%; }
		</style>
		      
		<script src="/WmRoot/webMethods.js.txt"></script>
	
        
	</head>

	<body class="main" onLoad="">
	
		<table width=100% >
			<tr>
				<td class="menusection-Settings" colspan=2>List FA Reports &gt; FA delete </td>
			</tr>
				
			<tr><td>&nbsp;</td></tr>
		</table>
	
			
	<b>The checked files are deleted successfully. </b>
	
	
	%scope param(doDelete='yes')%
	
	%invoke wm.b2b.editn.FAReport:getCheckedFiles%
							%onerror%
							<table>
								<TR><TD class="message" colspan="2">
									<P><B>The following error occured while attempting to generate FA report:</B></P>
									<P><B>Service: </B>%value errorService%<br>
									<B>Error: </B>%value error%</P>
								</TD></TR>
							</table>
	%endinvoke%
					
	%end scope%			
	
		
	</body>
</html>