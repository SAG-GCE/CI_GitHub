<HTML>
	<HEAD>
		<title>View Document</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<script src="/WmRoot/menu.js.txt"></script>
		<style>
			body { border-top: 1px solid #97A6CB; }
		</style>
	</HEAD>
	<BODY>
		<TABLE WIDTH="80%" CELLSPACING=0 CELLPADDING=1 BORDER=0>
			<tr width="100%">
				<td class="menusection-Settings" colspan=2>Document Details&nbsp;</td>
			</tr>

				<tr><td>

				<li><a href="ViewDocActivities.dsp?internalId=%value /docID%">View Document Activity Log</a></li>
				%invoke wm.b2b.editn.FAReport:viewDocument%
					%ifvar relatedDocs%
						%loop relatedDocs%
							%ifvar from vequals(/docID)%
								<li><a href="viewTNDoc.dsp?docID=%value to%">View Related Document (%value relationship%)</a></li>
							%endif from%
							%ifvar to vequals(/docID)%
								<li><a href="viewTNDoc.dsp?docID=%value from%">View Related Document (%value relationship%)</a></li>
							%endif to%
						%endloop relatedDocs%
					%endif%
						</td></td>
		<tr>
			<td>
				<table width="100%">
					<tr><td class="heading" colspan="2">Document Attributes</td></tr>
					<tr>
						<td class="evenrow">Date</td>
						<td class="evenrow-l">%value date%&nbsp;</td>
					</tr>
					<tr>
						<td class="evenrow">Document Type</td>
						<td class="evenrow-l">%value doctype% &nbsp;</td>
					</tr>
					<tr>
						<td class="evenrow">Sender</td>
						<td class="evenrow-l">%value senderName% &nbsp;</td>
					</tr>
					<tr>
						<td class="evenrow">Receiver</td>
						<td class="evenrow-l">%value receiverName% &nbsp;</td>
					</tr>
					<tr>
						<td class="evenrow">Document ID</td>
						<td class="evenrow-l">%value documentID% &nbsp;</td>
					</tr>
					<tr>
						<td class="evenrow">Processing Status</td>
						<td class="evenrow-l">%value processingStatus% &nbsp;</td>
					</tr>
					<tr>
						<td class="evenrow">User Status</td>
						<td class="evenrow-l">%value userStatus% &nbsp;</td>
					</tr>

					%ifvar attributes%
						%loop attributes%
						<tr>
							<td class="evenrow">%value name% &nbsp;</td>
							<td class="evenrow-l">%value value% &nbsp;</td>
						</tr>
						%endloop%
					%endif% 
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table width="100%">
					<tr><td class="heading" colspan="5">Content Parts (%value partsLength% total)</td></tr>
					<tr>
						<td class="oddcol">Name</td>
						<td class="oddcol">Length</td>
						<td class="oddcol">Type</td>
						<td class="oddcol">Storage Type</td>
						<td class="oddcol">Storage Reference</td>
					</tr>
					%loop contentParts%
					<tr>
						%ifvar type equals('application/x-wmidatabin')%
						<td class="evencol-l">%value PartName%</td>
						%else%
						<td class="evencol-l"><a href="ViewDocContents.dsp?docId=%value /docID%&partName=%value PartName%">%value PartName%</a> &nbsp;</td>
						%endif%
						<td class="evencol-l">%value Length%&nbsp;</td>
						<td class="evencol-l">%value MimeType%&nbsp;</td>
						<td class="evencol-l">%value StorageType%&nbsp;</td>
						<td class="evencol-l">%value StorageRef%&nbsp;</td>
					</tr>
					%endloop%
				</table>
			</td>
		</tr>
				%onerror%
					%value errorMessage%
				%endinvoke%
		</TABLE>
	</BODY>
</HTML>
