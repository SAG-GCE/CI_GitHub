<html>
	<head>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="-1">
		<title>Install External ID Types</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<base target="_self">
		<style>
			.listbox  { width: 100%; }
		</style>
		<script src="/WmRoot/webMethods.js.txt"></script>

	</head>

	<body onLoad="setNavigation('addEDIIDType.dsp', '', 'foo');">
		<table width=100% >
			<tr>
				<td class="menusection-Packages">Install External ID Types</td>
                  </tr>
			<tr></tr> 
			
			%ifvar EDIIDType%
				%invoke wm.b2b.editn:addEDIIDType%
				<TR><TD class="message">%value Status%</TD></TR>
				%onerror%
					<TR><TD class="message">
						<P><B>The following error occured while attempting to create the template:</B></P>
						<P><B>Service: </B>%value errorService%<br>
						<B>Error: </B>%value error% %value errorMessage%</P>
					</TD></TR>	
				%endinvoke%
			%else%
				<TR><TD class="evenrow-l">
                        <BR>Install External ID Types that correspond to EDI ID Qualifiers into webMethods Tranding Networks. 
				<BR><BR>
				</TD></TR>
			%endif%		

			
			<tr>
				<td>
					<table width="100%">
					<FORM name="addEDIIDType" METHOD="POST" ACTION="addEDIIDType.dsp" target="">
						<!-- title bar -->
						<tr>
							<td class="heading" colspan=2>ID Type</td>   
						</tr>

						<!-- table labels --->
                    			<tr>
							<td nowrap class="oddrow">External ID Type</td>
							<td nowrap class="oddcol-l">&nbsp; 
							<select NAME="EDIIDType"> 
								<option value="SCAC">SCAC
								<option value="FMC">FMC
								<option value="IATA">IATA
								<option value="GLN">GLN
								<option value="UCC ID">UCC ID
								<option value="GLN">GLN
								<option value="X.121">X.121
								<option value="DoD Code">DoD Code
								<option value="DEA">DEA
								<option value="Phone">Phone
								<option value="UCS Code">UCS Code
								<option value="DUNS Plus Suffix">DUNS Plus Suffix
								<option value="PAS Code">PAS Code
								<option value="EAN">EAN
								<option value="NRMA">NRMA
								<option value="DUNS+4">DUNS+4
								<option value="ABA Routing">ABA Routing
								<option value="INSEE SIRET">INSEE SIRET
								<option value="AIAG">AIAG
								<option value="EDICA ID">EDICA ID
								<option value="HIN">HIN
								<option value="IPEDS">IPEDS
								<option value="DIN">DIN
								<option value="NCES">NCES
								<option value="ATP">ATP
								<option value="4-Digit Code List of Postsecondary Institutions">4-Digit Code List of Postsecondary Institutions
								<option value="Stat of List of Postsecondary Institution">Stat of List of Postsecondary Institution
								<option value="Carrier ID by HCFA">Carrier ID by HCFA
								<option value="Fiscal Intermediary ID by HCFA">Fiscal Intermediary ID by HCFA
								<option value="Medicare Provider and Supplier ID by HCFA">Medicare Provider and Supplier ID by HCFA
								<option value="INSEE SIREN">INSEE SIREN
								<option value="ISO 6523">ISO 6523
								<option value="FEIN">FEIN
								<option value="BfA">BfA
								<option value="NSA">NSA
								<option value="Medicare Provider and Supplier ID by states">Medicare Provider and Supplier ID by states
								<option value="Stat College Student Info System Institution Codes">Stat College Student Info System Institution Codes
								<option value="Stat University Student Info System Institution Codes">Stat University Student Info System Institution Codes
								<option value="Society of Preperty Info Compilers and Analysts">Society of Preperty Info Compilers and Analysts
								<option value="6-Digit Code List of Secondary Institutions">6-Digit Code List of Secondary Institutions
								<option value="GEIS">GEIS
								<option value="BdDB">BdDB
								<option value="Bank ID">Bank ID
								<option value="seller agent">seller agent
								<option value="buyer agent">buyer agent
								<option value="AMECOP ID">AMECOP ID
								<option value="NRMA">NRMA
								<option value="ID by SAFER">ID by SAFER
								<option value="Standard Address Number">Standard Address Number
							</select>
							</td>
						</tr>

						<tr>
                  				<td class="action" colspan="2">
								<input type="submit" value="Add External ID Type to Trading Networks">
							</td>
						</tr>
					</form>
					</table>
				</td>
			</tr>
		
		</table>
	</body>
</html>
