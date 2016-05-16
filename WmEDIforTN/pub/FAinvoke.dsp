<html>
	<head>
		<title>Create FA report</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			
		<style>
			.listbox  { width: 100%; }
		</style>
        
		<script src="webMethods.js.txt">
		</script>

	
	</head>

	<body class="main" onLoad="">
	
		<table width=100% >
				<tr>
					<td class="menusection-Settings" colspan=2>Create FA Report &nbsp;</td>
				</tr>
		
	
				<tr><td>&nbsp;</td></tr>
		</table>
		
			%ifvar reportName%
	
			%invoke wm.b2b.editn.FAReport:generateFAReport%
						%onerror%
						<table>
							<TR><TD class="message" colspan="2">
								<P><B>The following error occured while attempting to generate FA report:</B></P>
								<P><B>Service: </B>%value errorService%<br>
								<B>Error: </B>%value error%</P>
							</TD></TR>
						</table>
						
				
				
				%endinvoke%
				
				
				%ifvar errorMessage%
												
						<table>						
												
												
												
								<TR><TD class="message" colspan="2">
								
														
									<B>The error message: </B><b>%value errorMessage% <BR></b></P>
								</TD></TR>
								<TR><B>No report file is created, please check the input.
									<P>
									The following error occurred while attempting to create the report file:</B></P> 
								</TR>
													
						</table>
																		
																
														
														%else%
														
														<b>
															The FA report is generated under "\pub\FAReports\" directory in the WmEDIforTN package. 
															Do you like to review the current FA report list on your system? if so, please click <a href="FAOut.dsp?">here</a>.</b>
																			
																<FORM name="dirform" METHOD="GET" ACTION="FAOut.dap" target="" align="left">
																<input type="hidden" name="dir" value="dir">
										</FORM>
														
										%endif%
							
				%endif%
				
				
			
	
	</body>
</html>