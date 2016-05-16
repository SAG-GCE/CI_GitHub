<html>

	<head>
		<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<title>Sample Monitor</title>
		<!-- <base target="contents"> -->
	</head>

	<body>
		<DIV class="position">
			<TABLE WIDTH="100%">
				<TR>
					<TD class="menusection-Solutions" colspan=2> Sample Monitor </TD>
				</TR>

				<tr>
					<td>
        <br>
	%invoke wm.b2b.editn.sample.sender:start%  
		The sample has been started.  Use the webMethods Monitor to track the conversations.  
		<P>
		It may take a few moments for all of the conversations to be created.  Please be patient.
		</P>
		<P> <A HREF="send.dsp">Run</A> the example again | <A HREF="../">Return</A> to WmEDIforTN Homepage </P> 
        %endinvoke%

        
        
					</td>
				</tr>
			</table>
		</div>
	</body>

</html>
