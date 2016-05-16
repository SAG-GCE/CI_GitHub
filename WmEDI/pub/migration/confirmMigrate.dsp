<html>

	<head>
		<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
		<SCRIPT src="/WmRoot/webMethods.js.txt"></SCRIPT>

		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<title>Welcome</title>
		<!-- <base target="contents"> -->
		<SCRIPT>
		</SCRIPT>
	</head>
	<body>

	%invoke wm.b2b.edi.migration:translateUIInfo%
		<table width="100%">
		<tr> <td class="menusection-Server" colspan="5"> Confirm Migration </td> </tr>
		%ifvar Packages -notnull%
			<script>resetRows();</script>
			<tr>
				<td class="Heading">Package</td>
				<td class="Heading">Standard</td>
				<td class="Heading">Version</td>
				<td class="Heading">Template</td>
			</td>
			%loop Packages%
				%loop Templates%
					<tr>
						<script>writeTD("rowdata");</script> %value PackageName% </td>
						<script>writeTD("rowdata");</script> %value Standard% </td>
						<script>writeTD("rowdata");</script> %value Version% </td>
						<script>writeTD("rowdata");</script> %value % </td>
					</tr>
                    <script>swapRows();</script>
				%endloop%
			%endloop%
			<TR>
			<td colspan="5">
			<form name="DataForm" method="POST" action="doMigration.dsp">
				<input type="submit" value="Continue">
				%loop toMigrate -struct%
					<input type="hidden" name="%value $key%" value="%value%"><BR>
				%endloop%
			</form>
			</td>
			</tr>
		%else%
			<tr><td class="rowdata" colspan="5">No templates to migrate</td></tr>
		%endif%
		</table>
	%onerror%
			-- Error<BR>
			%value error% <BR>
			%value errorMessage% <BR>

	%endinvoke%
	</body>
</html>


