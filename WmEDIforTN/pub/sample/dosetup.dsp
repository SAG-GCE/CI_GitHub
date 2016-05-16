<html>

	<head>
		<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<title>Sample Setup</title>
		<!-- <base target="contents"> -->
	</head>

	<body>
		<DIV class="position">
			<TABLE WIDTH="100%">
				<TR>
					<TD class="menusection-Solutions" colspan=2> Sample Setup </TD>
				</TR>

				<tr>
					<td>
                    <br>
					%invoke wm.b2b.editn.sample.setup:setupSample% 
							%invoke wm.b2b.editn.sample.util:checkSetup% 
								%ifvar setupProperly equals('true')% 
				<P>The profiles and document types needed for the sample have been installed.</P>

				<P>
				You must still import four process models into the webMethods Modeler.  The models are located in the directory 
                <em>ServerDirectory\packages\WmEDIforTN\config\Models</em>.  After importing these models, use the webMethods 
				Modeler to generate process models.  See the <i>webMethods Modeler User's Guide</i> for help with these procedures.
				</P>
								%else%

									%ifvar scriptsOkay equals('false')%  
										<P> Please use Business Integrator (BI) to import the process models contained in the
                                        Integration Server directory under <font face="Courier">/packages/WmEDIforTN/config/Models</font>.  After doing so, use BI to generate the
                                        business process.  See the <i>Business Integrator User's Guide</i> for details.</P>
									%endif%  
									%ifvar docsOkay equals('false')%  
										<P> Please run the setup <A HREF="setup.dsp">again</A>.  </P>
									%else%  
										%ifvar profilesOkay equals('false')%  
											<P> Please run the setup <A HREF="setup.dsp">again</A>.</P>
										%endif%  
									%endif%  
								%endif%  
							%endinvoke%  
						%onerror%  
							An error occured during setup:<BR>  
							%value error%<BR>  
							%value errorMessage% %endinvoke%  

					</td>
				</tr>
			</table>
			<P>
							<A HREF="setup.dsp">Back</A> to Setup | <A HREF="send.dsp">Run</A> the example
						</P>
		</div>
	</body>

</html>
