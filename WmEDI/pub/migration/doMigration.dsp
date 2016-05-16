<html>

  <head>
    <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
    <SCRIPT src="/WmRoot/webMethods.js.txt"></SCRIPT>

    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <title>Welcome</title>
    <!-- <base target="contents"> -->
	</head>

	<body>
		<table width="100%">
		<TR> <TD class="menusection-Server" colspan="4">Migration Results</TD></TR>
		%invoke wm.b2b.edi.migration:doMigration%
			%ifvar packageResults -notempty%
				<TR> 
					<TD class="heading">Package</TD>
					<TD class="heading">Schema</TD>
					<TD class="heading">Warnings</TD>
					<TD class="heading">Result</TD>
				</TR>
				<script>resetRows();</script>
				%loop packageResults%
					%loop templateResults%
						<TR>
						<script>writeTD("rowdata");</script>%value package%</TD>
						<script>writeTD("rowdata");</script>%value name%</TD>
						<script>writeTD("rowdata");</script>
							%ifvar warnings%
								%loop warnings%
									%value %
								%loopsep '<BR>'%
								%endloop%
							%else%
								No Warnings
							%endif%
							</TD>
						<script>writeTD("rowdata");</script> %value result%</TD>
						</TR>
                    <script>swapRows();</script>
					%endloop%
				%endloop%
			%else%
				<TR><TD class="message" colspan="4"> No Schema migrated </TD> </TR> 
			%endif%
		%endinvoke%
	</body>

</html>
