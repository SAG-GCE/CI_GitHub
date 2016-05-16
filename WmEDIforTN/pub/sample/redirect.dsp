<HTML>
	<HEAD>
		<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
		<SCRIPT>
			%invoke wm.b2b.editn.sample.util:getPID%
			%ifvar pid%
				location="/WmMonitor/queryProcessStatus.dsp?processID=%value pid%"
			%endif%
			%endinvoke%
		</SCRIPT>

	</HEAD>
	<BODY>
		This process has not yet been created <a href="redirect.dsp?cid=%value cid encode(url)%">check again</a>.
	</BODY>
</HTML>
