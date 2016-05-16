<html>

	<head>
		<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
		<SCRIPT src="/WmRoot/webMethods.js.txt"></SCRIPT>

		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<title>Welcome</title>

		<!-- <base target="contents"> -->
	</head>
	<BODY onLoad="setNavigation('index.dsp', '', 'foo');">
		%comment%
		<DIV class="position">
			<TABLE WIDTH="100%">
				<TR>
					<TD class="title" colspan="2"> Title </TD>
				</TR>
				<TR>
					<TD class="message" colspan="2"> Message </TD>
				</TR>
				<TR>
					<TD class="action" colspan="2"> Action </TD>
				</TR>
				<TR>
					<TD class="heading" colspan="2"> Heading </TD>
				</TR>
				<TR>
					<TD class="subheading" colspan="2"> Sub Heading </TD>
				</TR>
				<TR>
					<script>writeTD("rowdata-l");</script> Odd Row</TD>
					<script>writeTD("rowdata");swapRows();</script> Odd Row data</TD>
				</TR>
				<TR>
					<script>writeTD("rowdata-l");</script> Even Row</TD>
					<script>writeTD("rowdata");swapRows();</script> Odd Row data</TD>
				</TR>
				<TR>
					<script>writeTD("rowdata-l");</script> Odd Row</TD>
					<script>writeTD("rowdata");swapRows();</script> Odd Row data</TD>
				</TR>
			</TABLE>
		</DIV>
		%endcomment%

		<DIV class="position">
			<TABLE WIDTH="100%">
				<TR>
					<TD class="menusection-Server" colspan="2"> Migrate Templates</TD>
				</TR>
				<tr></tr>
				<TR>
					<TD class="evenrow-l">
						<br>
						This allows you to migrate EDI templates from 4.x to 6.1 Flat File Schema.
						<p>
						Click <a href="migrate.dsp">here</a> to begin the migration.  Please be patient, the
						page may take a moment to load.
						<br><br>
					</TD>
				</TR>
			</TABLE>
		</DIV>
	</body>
</html>
