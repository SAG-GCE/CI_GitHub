<html>
	<head>
		<title>EDIINT Contents</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<script src="/WmRoot/menu.js.txt"></script>
        <style>
			body { border-top: 1px solid #97A6CB; }
		</style>
		%invoke wm.b2b.edi.util.GUI:getEnabled% 
		
		<SCRIPT Language="JavaScript">
		
			var enableDeprecateText = '<nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="Deprecate.dsp" name="Deprecate.dsp" src="images/blank.gif" height="8" width="8" border="0"><a id="aFAreport.dsp" href="#" onclick="javascript:doIt();"><span class="menuitemspan">Enable Deprecated Pages</span></a></nobr>';
			var disableDeprecateText = '<nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="Deprecate.dsp" name="Deprecate.dsp" src="images/blank.gif" height="8" width="8" border="0"><a id="aFAreport.dsp" href="#" onclick="javascript:doIt();"><span class="menuitemspan">Disable Deprecated Pages</span></a></nobr>';
		
			//Configure Properties
			var propertiesEnabledText = '<td id="isettings-properties.dsp" class="menuitem" onmouseover="menuMouseOver(this, \'settings-properties.dsp\');" onmouseout="menuMouseOut(this);" onclick="document.all[\'asettings-properties.dsp\'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="settings-properties.dsp" name="settings-properties.dsp" src="images/blank.gif" height="8" width="8" border="0"><A id="asettings-properties.dsp" href="settings-properties.dsp" onclick="menuMove(\'settings-properties.dsp\', \'body\'); return true;" target="main"><span class="menuitemspan">Configure Properties</span></a></nobr></td>'
			//var propertiesDisabledText = '<td id="isettings-properties.dsp" class="menuitem" onmouseover="menuMouseOver(this, \'settings-properties.dsp\');" onmouseout="menuMouseOut(this);" onclick="document.all[\'asettings-properties.dsp\'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="settings-properties.dsp" name="settings-properties.dsp" src="images/blank.gif" height="8" width="8" border="0"><A id="asettings-properties.dsp"><span class="menuitemspan">Configure Properties</span></a></nobr></td>'
			var propertiesDisabledText = '<td id="isettings-properties.dsp"><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="settings-properties.dsp" name="settings-properties.dsp" src="images/blank.gif" height="8" width="8" border="0">Configure Properties</td>'
			
			
			//Configure Field Formats
			var formatPropertiesEnabledText = '<td id="isettings-format.dsp" class="menuitem" onmouseover="menuMouseOver(this, \'settings-format.dsp\');" onmouseout="menuMouseOut(this);" onclick="document.all[\'asettings-format.dsp\'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="settings-format.dsp" name="settings-format.dsp" src="images/blank.gif" height="8" width="8" border="0"><A id="asettings-format.dsp" href="settings-format.dsp" onclick="menuMove(\'settings-format.dsp\', \'body\'); return true;" target="main"><span class="menuitemspan">Configure Field Formats</span></a></nobr></td>'
			var formatPropertiesDisabledText = '<td id="isettings-format.dsp"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="settings-format.dsp" name="settings-format.dsp" src="images/blank.gif" height="8" width="8" border="0">Configure Field Formats</td>'
			
			
			//Install TN Doc Types
			var installTNDocTypeEnabledText = '<td id="iInstallDocType.dsp" class="menuitem" onmouseover="menuMouseOver(this, \'InstallDocType.dsp\');" onmouseout="menuMouseOut(this);" onclick="document.all[\'aInstallDocType.dsp\'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="InstallDocType.dsp" name="InstallDocType.dsp" src="images/blank.gif" height="8" width="8" border="0"><A id="aInstallDocType.dsp" href="/WmEDIforTN/InstallDocType.dsp" onclick="menuMove(\'InstallDocType.dsp\', \'body\'); return true;" target="main"><span class="menuitemspan">Install TN Document Types</span></a></nobr></td>'
			var installTNDocTypeDisabledText = '<td id="iInstallDocType.dsp"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="InstallDocType.dsp" name="InstallDocType.dsp" src="images/blank.gif" height="8" width="8" border="0">Install TN Document Types</td>'
			
			//Submit EDI Data
			var submitEDIDataEnabledText = '<td id="isubmitEDI.html" class="menuitem" onmouseover="menuMouseOver(this, \'submitEDI.html\');" onmouseout="menuMouseOut(this);" onclick="document.all[\'asubmitEDI.html\'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="submitEDI.html" name="submitEDI.html" src="images/blank.gif" height="8" width="8" border="0"><A id="asubmitEDI.html" href="/WmEDIforTN/submitEDI.html" onclick="menuMove(\'submitEDI.html\', \'body\'); return true;" target="main"><span class="menuitemspan">Submit Test EDI Data</span></a></nobr></td>'
			var submitEDIDataDisabledText = '<td id="isubmitEDI.html"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="submitEDI.html" name="submitEDI.html" src="images/blank.gif" height="8" width="8" border="0">Submit Test EDI Data</td>'
			
			//Add ExternalID
			var addExternalIDEnabledText = '<td id="iaddEDIIDType.dsp" class="menuitem" onmouseover="menuMouseOver(this, \'addEDIIDType.dsp\');" onmouseout="menuMouseOut(this);" onclick="document.all[\'aaddEDIIDType.dsp\'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="addEDIIDType.dsp" name="addEDIIDType.dsp" src="images/blank.gif" height="8" width="8" border="0"><A id="aaddEDIIDType.dsp" href="/WmEDIforTN/addEDIIDType.dsp" onclick="menuMove(\'addEDIIDType.dsp\', \'body\'); return true;" target="main"><span class="menuitemspan">Add External ID Types</span></a></nobr></td>'
			var addExternalIDDisabledText = '<td id="iaddEDIIDType.dsp"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="addEDIIDType.dsp" name="addEDIIDType.dsp" src="images/blank.gif" height="8" width="8" border="0">Add External ID Types</td>'
			
			//Manage Interchange Info
			var manageInterchangeInfoEnabledText = '<td id="iCrossRefEnvSearch.dsp" class="menuitem" onmouseover="menuMouseOver(this, \'CrossRefEnvSearch.dsp\');" onmouseout="menuMouseOut(this);" onclick="document.all[\'aCrossRefEnvSearch.dsp\'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="CrossRefEnvSearch.dsp" name="CrossRefEnvSearch.dsp" src="images/blank.gif" height="8" width="8" border="0"><A id="aCrossRefEnvSearch.dsp" href="/WmEDIforTN/CrossRefEnvSearch.dsp" onclick="menuMove(\'CrossRefEnvSearch.dsp\', \'body\'); return true;" target="main"><span class="menuitemspan">Manage Interchange Info</span></a></nobr></td>'
			
			//Query Envelope Ids
			var queryEnvelopeIdsEnabledText = '<td id="iCrossRefQueryEnv.dsp" class="menuitem" onmouseover="menuMouseOver(this, \'CrossRefQueryEnv.dsp\');" onmouseout="menuMouseOut(this);" onclick="document.all[\'aCrossRefQueryEnv.dsp\'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="CrossRefQueryEnv.dsp" name="CrossRefQueryEnv.dsp" src="images/blank.gif" height="8" width="8" border="0"><A id="aCrossRefQueryEnv.dsp" href="/WmEDIforTN/CrossRefQueryEnv.dsp" onclick="menuMove(\'CrossRefQueryEnv.dsp\', \'body\'); return true;" target="main"><span class="menuitemspan">Query Envelope IDs</span></a></nobr></td>'
			
			//Define instanceId Queries
			var defineInstanceIdQueriesEnabledText = '<td id="iEditInstance.dsp" class="menuitem" onmouseover="menuMouseOver(this, \'EditInstance.dsp\');" onmouseout="menuMouseOut(this);" onclick="document.all[\'aEditInstance.dsp\'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="EditInstance.dsp" name="EditInstance.dsp" src="images/blank.gif" height="8" width="8" border="0"><A id="aEditInstance.dsp" href="/WmEDIforTN/EditInstance.dsp" onclick="menuMove(\'EditInstance.dsp\', \'body\'); return true;" target="main"><span class="menuitemspan">Define Instance ID Queries</span></a></nobr></td>'
			
			//Manage ControlNumber
			var manageControlNumbersEnabledText = '<td id="iCrossRefControlNumSearch.dsp" class="menuitem" onmouseover="menuMouseOver(this, \'CrossRefControlNumSearch.dsp\');" onmouseout="menuMouseOut(this);" onclick="document.all[\'aCrossRefControlNumSearch.dsp\'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="CrossRefControlNumSearch.dsp" name="CrossRefControlNumSearch.dsp" src="images/blank.gif" height="8" width="8" border="0"><A id="aCrossRefControlNumSearch.dsp" href="/WmEDIforTN/CrossRefControlNumSearch.dsp" onclick="menuMove(\'CrossRefControlNumSearch.dsp\', \'body\'); return true;" target="main"><span class="menuitemspan">Manage Control Numbers</span></a></nobr></td>'
			var manageControlNumbersDisabledText = '<td id="iCrossRefControlNumSearch.dsp"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="CrossRefControlNumSearch.dsp" name="CrossRefControlNumSearch.dsp" src="images/blank.gif" height="8" width="8" border="0">Manage Control Numbers</td>'
			
			//Create FA Report
			var createFAReportEnabledText = '<td id="iFAreport.dsp" class="menuitem" onmouseover="menuMouseOver(this, \'FAreport.dsp\');" onmouseout="menuMouseOut(this);" onclick="document.all[\'aFAreport.dsp\'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="FAreport.dsp" name="FAreport.dsp" src="images/blank.gif" height="8" width="8" border="0"><A id="aFAreport.dsp" href="/WmEDIforTN/FAreport.dsp" onclick="menuMove(\'FAreport.dsp\', \'body\'); return true;" target="main"><span class="menuitemspan">Create FA Reports</span></a></nobr></td>'
			var createFAReportDisabledText = '<td id="iFAreport.dsp"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="FAreport.dsp" name="FAreport.dsp" src="images/blank.gif" height="8" width="8" border="0">Create FA Reports</td>'
			
			
			//List FA Report
			var listFAReportEnabledText = '<td id="iFAOut.dsp" class="menuitem" onmouseover="menuMouseOver(this, \'FAOut.dsp\');" onmouseout="menuMouseOut(this);" onclick="document.all[\'aFAOut.dsp\'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="FAOut.dsp" name="FAOut.dsp" src="images/blank.gif" height="8" width="8" border="0"><A id="aFAOut.dsp" href="/WmEDIforTN/FAOut.dsp" onclick="menuMove(\'FAOut.dsp\', \'body\'); return true;" target="main"><span class="menuitemspan">List FA Reports</span></a></nobr></td>'
			var listFAReportDisabledText = '<td id="iFAOut.dsp"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="FAOut.dsp" name="FAOut.dsp" src="images/blank.gif" height="8" width="8" border="0">List FA Reports</td>'
			
		
			function initializeLinks() {

				document.getElementById('isettings-properties.dsp').innerHTML = propertiesDisabledText;
				document.getElementById('isettings-format.dsp').innerHTML = formatPropertiesDisabledText;

				//if WmEDIForTN loaded
				%ifvar WmEDIforTN equals('true')%
					document.getElementById('iInstallDocType.dsp').innerHTML = installTNDocTypeDisabledText;
					document.getElementById('isubmitEDI.html').innerHTML = submitEDIDataDisabledText;
					document.getElementById('iaddEDIIDType.dsp').innerHTML = addExternalIDDisabledText;
					document.getElementById('iCrossRefControlNumSearch.dsp').innerHTML = manageControlNumbersDisabledText;
					document.getElementById('iFAreport.dsp').innerHTML = createFAReportDisabledText;
					document.getElementById('iFAOut.dsp').innerHTML = listFAReportDisabledText;
					document.getElementById('iCrossRefQueryEnv.dsp').innerHTML = queryEnvelopeIdsEnabledText;
					document.getElementById('iCrossRefEnvSearch.dsp').innerHTML = manageInterchangeInfoEnabledText;
					document.getElementById('iEditInstance.dsp').innerHTML = defineInstanceIdQueriesEnabledText;
					window.open("/WmEDIforTN/CrossRefEnvSearch.dsp" ,"main");
					return true;
				%endif%
			}
			
			function doIt() {
				var text = document.getElementById('iDeprecate.dsp').innerHTML;		
				if (text.indexOf ('Enable Deprecated Pages') != -1) {
					document.getElementById('iDeprecate.dsp').innerHTML = disableDeprecateText;
					document.getElementById('isettings-properties.dsp').innerHTML = propertiesEnabledText;
					document.getElementById('isettings-format.dsp').innerHTML = formatPropertiesEnabledText;
				
					//if WmEDIForTN loaded
					%ifvar WmEDIforTN equals('true')%
						document.getElementById('iInstallDocType.dsp').innerHTML = installTNDocTypeEnabledText;
						document.getElementById('isubmitEDI.html').innerHTML = submitEDIDataEnabledText;
						document.getElementById('iaddEDIIDType.dsp').innerHTML = addExternalIDEnabledText;
						document.getElementById('iCrossRefControlNumSearch.dsp').innerHTML = manageControlNumbersEnabledText;
						document.getElementById('iFAreport.dsp').innerHTML = createFAReportEnabledText;
						document.getElementById('iFAOut.dsp').innerHTML = listFAReportEnabledText;
					%endif%
				} else {
					document.getElementById('iDeprecate.dsp').innerHTML = enableDeprecateText;
					document.getElementById('isettings-properties.dsp').innerHTML = propertiesDisabledText;
					document.getElementById('isettings-format.dsp').innerHTML = formatPropertiesDisabledText;
					
					//if WmEDIForTN loaded
					%ifvar WmEDIforTN equals('true')%
						document.getElementById('iInstallDocType.dsp').innerHTML = installTNDocTypeDisabledText;
						document.getElementById('isubmitEDI.html').innerHTML = submitEDIDataDisabledText;
						document.getElementById('iaddEDIIDType.dsp').innerHTML = addExternalIDDisabledText;
						document.getElementById('iCrossRefControlNumSearch.dsp').innerHTML = manageControlNumbersDisabledText;
						document.getElementById('iFAreport.dsp').innerHTML = createFAReportDisabledText;
						document.getElementById('iFAOut.dsp').innerHTML = listFAReportDisabledText;
						window.open("/WmEDIforTN/CrossRefEnvSearch.dsp" ,"main");
					%endif%	
					//if WmEDIForTN not loaded
					%ifvar WmEDIforTN equals('false')%
						window.open("doc.dsp" ,"main");
					%endif%	
				}
				
			}
		</SCRIPT>
		
		
	</head>
	
	
	<body class="menu" onload="initializeLinks();">
	
		<P>
		<table WIDTH="100%" cellspacing=0 cellpadding=1 border=0 id = 't'>

			<!-- Subtitle: Configuration -->
			<tr>
				<td class="menusection-Server"><img src="images/blank.gif" width="4" height="1" border="0">
					Configuration
				</td>
			</tr>

			<A id="adoc.dsp" href="doc.dsp" onclick="menuMove('doc.dsp', 'body'); return true;" target="main"></a>

			<tr>
				<td id="isettings-properties.dsp" class="menuitem" onmouseover="menuMouseOver(this, 'settings-properties.dsp');" onmouseout="menuMouseOut(this);"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="settings-properties.dsp" name="settings-properties.dsp" src="images/blank.gif" height="8" width="8" border="0">
					<A id="asettings-properties.dsp" href="settings-properties.dsp" onclick="menuMove('settings-properties.dsp', 'body'); return true;" target="main"><span class="menuitemspan">Configure Properties</span></a></nobr>
				</td>
			</tr>
			
			<tr>
				<td id="isettings-format.dsp" class="menuitem" onmouseover="menuMouseOver(this, 'settings-format.dsp');" onmouseout="menuMouseOut(this);"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="settings-format.dsp" name="settings-format.dsp" src="images/blank.gif" height="8" width="8" border="0">
					<A id="asettings-format.dsp" href="settings-format.dsp" onclick="menuMove('settings-format.dsp', 'body'); return true;" target="main"><span class="menuitemspan">Configure Field Formats</span></a></nobr>
				</td>
			</tr>

			
			<tr>
				<td class="menuseparator"><img height="3" src="images/blank.gif" width="3" border="0"></td>
			</tr>

			%ifvar WmEDIforTN equals('true')%

			<!-- Subtitle: EDI Document Exchange-->
			<tr>
				<td class="menusection-Logs"><img src="images/blank.gif" width="4" height="1" border="0">
					Doc Exchange
				</td>
			</tr>
			<tr>
				<td id="iInstallDocType.dsp" class="menuitem" onmouseover="menuMouseOver(this, 'InstallDocType.dsp');" onmouseout="menuMouseOut(this);"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="InstallDocType.dsp" name="InstallDocType.dsp" src="images/blank.gif" height="8" width="8" border="0">
					<A id="aInstallDocType.dsp" href="/WmEDIforTN/InstallDocType.dsp" onclick="menuMove('InstallDocType.dsp', 'body'); return true;" target="main"><span class="menuitemspan">Install TN Document Types</span></a></nobr>
				</td>
			</tr>
			<tr>
				<td id="isubmitEDI.html" class="menuitem" onmouseover="menuMouseOver(this, 'submitEDI.html');" onmouseout="menuMouseOut(this);""><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="submitEDI.html" name="submitEDI.html" src="images/blank.gif" height="8" width="8" border="0">
					<A id="asubmitEDI.html" href="/WmEDIforTN/submitEDI.html" onclick="menuMove('submitEDI.html', 'body'); return true;" target="main"><span class="menuitemspan">Submit Test EDI Data</span></a></nobr>
				</td>
			</tr>
			<tr>
				<td class="menuseparator"><img height="3" src="images/blank.gif" width="3" border="0"></td>
			</tr>

			<!-- Subtitle: Partner Set Up-->
			<tr>
				<td class="menusection-Packages"><img src="images/blank.gif" width="4" height="1" border="0">
					Partner Set Up
				</td>
			</tr>
			
			<tr>
				<td id="iaddEDIIDType.dsp" class="menuitem" onmouseover="menuMouseOver(this, 'addEDIIDType.dsp');" onmouseout="menuMouseOut(this);"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="addEDIIDType.dsp" name="addEDIIDType.dsp" src="images/blank.gif" height="8" width="8" border="0">
					<A id="aaddEDIIDType.dsp" href="/WmEDIforTN/addEDIIDType.dsp" onclick="menuMove('addEDIIDType.dsp', 'body'); return true;" target="main"><span class="menuitemspan">Add External ID Types</span></a></nobr>
				</td>
			</tr>
   			<tr>
				<td id="iCrossRefEnvSearch.dsp" class="menuitem" onmouseover="menuMouseOver(this, 'CrossRefEnvSearch.dsp');" onmouseout="menuMouseOut(this);" onclick="document.all['aCrossRefEnvSearch.dsp'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="CrossRefEnvSearch.dsp" name="CrossRefEnvSearch.dsp" src="images/blank.gif" height="8" width="8" border="0">
					<A id="aCrossRefEnvSearch.dsp" href="/WmEDIforTN/CrossRefEnvSearch.dsp" onclick="menuMove('CrossRefEnvSearch.dsp', 'body'); return true;" target="main"><span class="menuitemspan">Manage Interchange Info</span></a></nobr>
				</td>
			</tr>
			
			<tr>
				<td id="iCrossRefQueryEnv.dsp" class="menuitem" onmouseover="menuMouseOver(this, 'CrossRefQueryEnv.dsp');" onmouseout="menuMouseOut(this);" onclick="document.all['aCrossRefQueryEnv.dsp'].click();"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="CrossRefQueryEnv.dsp" name="CrossRefQueryEnv.dsp" src="images/blank.gif" height="8" width="8" border="0">
					<A id="aCrossRefQueryEnv.dsp" href="/WmEDIforTN/CrossRefQueryEnv.dsp" onclick="menuMove('CrossRefQueryEnv.dsp', 'body'); return true;" target="main"><span class="menuitemspan">Query Envelope IDs</span></a></nobr>
				</td>
			</tr>
			<tr>
				<td class="menuseparator"><img height="3" src="images/blank.gif" width="3" border="0"></td>
			</tr>

			<!-- Subtitle: EDI business Processes -->
			<tr>
				<td class="menusection-Solutions"><img src="images/blank.gif" width="4" height="1" border="0">
					EDI Processes
				</td>
			</tr>
			<tr>
				<td id="iEditInstance.dsp" class="menuitem" onmouseover="menuMouseOver(this, 'EditInstance.dsp');" onmouseout="menuMouseOut(this);"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="EditInstance.dsp" name="EditInstance.dsp" src="images/blank.gif" height="8" width="8" border="0">
					<A id="aEditInstance.dsp" href="/WmEDIforTN/EditInstance.dsp" onclick="menuMove('EditInstance.dsp', 'body'); return true;" target="main"><span class="menuitemspan">Define Instance ID Queries</span></a></nobr>
				</td>
			</tr>
			<tr>
				<td class="menuseparator"><img height="3" src="images/blank.gif" width="3" border="0"></td>
			</tr>

			<!-- Subtitle: Control Numbers -->
			<tr>
				<td class="menusection-Adapters"><img src="images/blank.gif" width="4" height="1" border="0">
					Control Numbers
				</td>
			</tr>
			<tr>
				<td id="iCrossRefControlNumSearch.dsp" class="menuitem" onmouseover="menuMouseOver(this, 'CrossRefControlNumSearch.dsp');" onmouseout="menuMouseOut(this);"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="CrossRefControlNumSearch.dsp" name="CrossRefControlNumSearch.dsp" src="images/blank.gif" height="8" width="8" border="0">
					<A id="aCrossRefControlNumSearch.dsp" href="/WmEDIforTN/CrossRefControlNumSearch.dsp" onclick="menuMove('CrossRefControlNumSearch.dsp', 'body'); return true;" target="main"><span class="menuitemspan">Manage Control Numbers</span></a></nobr>
				</td>
			</tr>
			<tr>
				<td class="menuseparator"><img height="3" src="images/blank.gif" width="3" border="0"></td>
			</tr>

			<!-- Subtitle: Functional Acknowledgements -->
			<tr>
				<td class="menusection-Settings"><img src="images/blank.gif" width="4" height="1" border="0">
					FA
				</td>
			</tr>
			<tr>
				<td id="iFAreport.dsp" class="menuitem" onmouseover="menuMouseOver(this, 'FAreport.dsp');" onmouseout="menuMouseOut(this);">
				</td>

			</tr>
			<tr>
				<td id="iFAOut.dsp" class="menuitem" onmouseover="menuMouseOver(this, 'FAOut.dsp');" onmouseout="menuMouseOut(this);"><nobr><img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><image valign="middle" id="FAOut.dsp" name="FAOut.dsp" src="images/blank.gif" height="8" width="8" border="0">
					<A id="aFAOut.dsp" href="/WmEDIforTN/FAOut.dsp" onclick="menuMove('FAOut.dsp', 'body'); return true;" target="main"><span class="menuitemspan">List FA Reports</span></a></nobr>
				</td>
			</tr>
			<tr>
				<td class="menuseparator"><img height="3" src="images/blank.gif" width="3" border="0"></td>
			</tr>

			%endif%	
			<tr>
				<td height="100"></td>
			</tr>
			<!--<tr>
				<td class="menusection-Security" background-color="black"><img src="images/blank.gif" width="4" height="1" border="0">
					Home Page Setting
				</td>
			</tr>-->
			<tr>
				<td id="iDeprecate.dsp" class="menuitem" onmouseover="menuMouseOver(this, 'Deprecate.dsp');" onmouseout="menuMouseOut(this);">
					<nobr>
						<img valign="middle" src="images/blank.gif" width="4" height="1" border="0">
							<image valign="middle" id="Deprecate.dsp" name="Deprecate.dsp" src="images/blank.gif" height="8" width="8" border="0">
							<a id="aFAreport.dsp" href="#" onclick="javascript:doIt();">
								<span class="menuitemspan">Enable Deprecated Pages</span>
							</a>
					</nobr>
				</td>
			</tr>
			
		</table>
	%endinvoke%
		<div style="height=0; width=0">
		<form name="urlsaver">
		<input type="hidden" name="helpURL" value="doc/OnlineHelp/EDIproperties.html">
		</form>
		</div>
	</body>
</html>
