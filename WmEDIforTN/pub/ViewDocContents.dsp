<html>

<head>
	<title>Transaction Analysis Document Contents</title>
	<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
	<style>
		.pagebutton
		{
			font-size: 70%
			letter-spacing: 2px;
			font-weight: bold;
			background-color:#E0E0C0;
			color:#000000;
			width:7%
		}

		.smallbutton
		{
			font-size: 30%
			letter-spacing: 1px;
			background-color:#E0E0C0;
			color:#000000;
			width:15%
		}
	</style>
	%invoke wm.b2b.editn.FAReport:getContentPartBytes%
	<script>
		function setNext()
		{
			var d = document.changeForm.displaySize.value - 0;
			var e = document.changeForm.endIndex.value - 0;
			document.changeForm.startIndex.value = e + 1;
			document.changeForm.endIndex.value = e + d;
			document.changeForm.startCount.value = e + 2;
			document.changeForm.endCount.value = e + d + 1;
			document.changeForm.direction.value = "next";
			document.changeForm.submit();
		}

		function setPrevious()
		{
			var d = document.changeForm.displaySize.value - 0;
			var s = document.changeForm.startIndex.value - 0;
			document.changeForm.startIndex.value = s - d;
			document.changeForm.endIndex.value = s - 1;
			document.changeForm.startCount.value = s - d - 1;
			document.changeForm.endCount.value = s;
			document.changeForm.direction.value = "previous";
			document.changeForm.submit();
		}
		function setPageSize()
		{
			var l = prompt( "Current page size %value displaySize% bytes. \nEnter new page size in bytes.", "" );
			document.changeForm.displaySize.value = l;
			document.changeForm.startIndex.value = 0;
			document.changeForm.endIndex.value = l-1;
			document.changeForm.direction.value = 'next';
			document.changeForm.submit();
		}
	</script>
</head>

<body>
	<table width="100%" >
		<tr width="100%">
			<td class="menusection-Settings" colspan=2>Analysis &gt; 
																						Transactions &gt; 
																						Document Details &gt;
																						Document Part Contents&nbsp;</td>
		</tr>

		<tr>
			<td valign="top">
				<ul>
					<li><a href="viewTNDoc.dsp?docID=%value docId%">Return to Document Details</a></li>
				</ul>
			</td>
		</tr>


		<tr>
			<td>
				<table width="100%">
					<tr><td class="heading">Part: %value partName% (%value startCount% - %value endCount% bytes of %value contentLength% bytes)</td></tr>
					<tr>
						<td class="evencol">

							<form name="contentForm">
								<textarea cols="80" name="Content" rows="18">%value contentString%
								</textarea>
							</form>
							<form name="changeForm" action="ViewDocContents.dsp" method="post">
								<input type="hidden" name="docId" value=%value docId%>
								<input type="hidden" name="partName" value=%value partName%>
								<input type="hidden" name="direction" value="">
								<input type="hidden" name="startIndex" value=%value startIndex%>
								<input type="hidden" name="endIndex" value=%value endIndex%>
								<input type="hidden" name="displaySize" value=%value displaySize%>
								%ifvar hasPrevious equals('true')%
									<input onclick="javascript:setPrevious();" type="submit" value="&lt;--" name="pButton" class="pagebutton">
								%endif hasPrevious%
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								%ifvar hasNext equals('true')%
									<input onclick="javascript:setNext();" type="submit" value="--&gt;" name="nButton" class="pagebutton">
								%endif hasNext%
								<br><br><br><input onclick="javascript:setPageSize();" type="submit" value="Set page size" name="sizeButton" class="smallbutton">
							</form>
							<br><br>

						</td>
					</tr>
				</table>
			</td>
		</tr>
						
	</table>
	%onerror%
		%loop -struct%
			%value $key% %value% <BR>
		%endloop%
	%endinvoke%
</body>
</html>
