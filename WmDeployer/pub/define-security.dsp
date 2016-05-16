<HTML><HEAD><TITLE>Define IS Admin</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<LINK href="xtree.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js"></SCRIPT>
<script src="xtree.js"></script>
<script src="xtreecheckbox.js"></script>
</HEAD>
<BODY>

<TABLE width="100%">
  <TBODY>
  <TR>
    <TD class=menusection-Deployer>%value bundleName% > Administration</TD>
  </TR>
  </TBODY>
</TABLE>

<SCRIPT>resetRows();</SCRIPT>
<TABLE width="100%" class="errorMessage">
  <TR>
    <TD colspan="2">
      <UL>
				<LI> <A onclick="return startProgressBar('Refreshing Administration assets');" href="define-security.dsp?projectName=%value projectName%&bundleName=%value bundleName%&regExp=%value regExp%">Refresh this Page</A></LI> 
       </UL>
    </TD>
  </TR>
</TABLE>

<TABLE class="tableView" width="100%">
	<TBODY>
  <TR>
    <TD class="heading"> Select Administration Assets</TD>
  </TR>

%comment%
	<FORM id="form" name="form" method="POST" action="under-construction.dsp">
%endcomment%
	<FORM id="form" name="form" method="POST" target="treeFrame" action="bundle-list.dsp">

	<!- Submit Button, placed at top for convenience ->
	<TR>
		<TD class="action">
			<INPUT onclick="return startProgressBar('Saving Administration assets');" align="center" type="submit" 
				VALUE="Save" name="submit"> </TD>
		<INPUT type="hidden" name="projectName" value='%value projectName%'>
		<INPUT type="hidden" name="bundleName" value='%value bundleName%'>
		<INPUT type="hidden" name="regExp" value='%value regExp%'>
		<INPUT type="hidden" name="action" value="updateSecurity">
	</TR>

	<TR>
		<script> writeTD("rowdata-l", "width='100%'");</script>

<script>
	%invoke wm.deployer.gui.UISettings:getSettings%
    %endinvoke%

	// Enumerate over entire list of configured sources
	%invoke wm.deployer.gui.UIBundle:getBundleSourceServers%
		%ifvar servers -notempty%
			var secTree = new WebFXTree("Administration");
			var filterCnt = 0;
			var matchCnt = 0;
		%loop servers%
			%rename serverAliasName serverAlias -copy%
			// Ping this Integration server before investing too much in it
			%ifvar ../optimisticNetwork equals('false')%
				%invoke wm.deployer.gui.server.IS:ping%
				%endinvoke%
			%endif%
			
			%ifvar ../optimisticNetwork equals('true')%
					var serverTree = new WebFXCheckBoxTreeItem("%value serverAliasName%", null, false, null, 
						webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
					%include shared-security-tree.dsp%
			%else%	
				%ifvar status equals('Success')%
					var serverTree = new WebFXCheckBoxTreeItem("%value serverAliasName%", null, false, null, 
							webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
						%include shared-security-tree.dsp%
				%else%
					var serverTree = new WebFXTreeItem("%value serverAlias% (Unavailable: %value message%)",
							null, null, webFXTreeConfig.serverIcon, webFXTreeConfig.serverIcon);
				%endif%
			%endif%
			
		secTree.add(serverTree);
		%endloop serverAliases%
		%else%
			var secTree = new WebFXTree("Administration (no Source Servers configured)", null, null, 
				webFXTreeConfig.ISIcon, webFXTreeConfig.ISIcon);
		%endif%

	%endinvoke%

// Write out the tree for the next section
w(secTree);
</script>
		</TD>
	</TR>

<!- If the regular expression is in force, let the user know>
	<TR>
		<script>
		writeTDspan("col-l","1");
%ifvar regExp -notempty%
		w("Regular Expression '%value regExp%' matched " + matchCnt + 
				" and filtered " + filterCnt + " assets.");
%else%
		w(matchCnt + " assets displayed.");
%endif%
		</script>
	</TR>

	<!- Submit Button, placed at bottom for convenience ->
	<TR>
		<TD class="action">
			<INPUT onclick="return startProgressBar('Saving Administration assets');" align="center" type="submit" 
				VALUE="Save" name="submit2"> </TD>
	</TR>

	</FORM>
	<TBODY>
</TABLE>

<script>
// This bit selects checkboxes from the current definition of the project ->

// getBundleScheduledServices: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleScheduledServices%
	%loop servers%
		%loop services%
			// Find the uniquely named Element and check it
			var p = document.getElementById("%value taskId%");
			if (p != null) webFXTreeHandler.all[p.parentNode.id].setChecked(true);
		%endloop%
	%endloop servers%
%endinvoke%

// getBundlePorts: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundlePorts%
	%loop servers%
		%loop ports%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$PORT$%value portKey -urlencode%$PORT$%value portType%$PORT$PORT_INCL");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
 				%ifvar noUnselect equals('true')%
 					var divEl = document.getElementById(webFXTreeHandler.all[p.item(0).parentNode.id].id);
 					var inputEl = divEl.getElementsByTagName("INPUT")[0];
 					inputEl.disabled = true;
 				%endif%
			}
		%endloop%
	%endloop servers%
%endinvoke%

// getBundleUsers: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleUsers%
	%loop servers%
		%loop users%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$%value userName -urlencode%$USER_INCL");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%
	%endloop servers%
%endinvoke%

// getBundleGroups: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleGroups%
	%loop servers%
		%loop groups%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$%value groupName -urlencode%$GROUP_INCL");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%
	%endloop servers%
%endinvoke%

// getBundleAcls: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleAcls%
	%loop servers%
		%loop acls%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$%value aclName%$ACL_INCL");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%
	%endloop servers%
%endinvoke%

// getBundleExtendedSettings: projectName*, bundleName*
%invoke wm.deployer.gui.UIBundle:getBundleExtendedSettings%
	%loop servers%
		%loop extended%
			// Find the uniquely named Element and check it
			var p = document.getElementsByName("%value ../serverAliasName -urlencode%$%value name%$EXTEND_INCL");
			if (p.length == 1) {
				webFXTreeHandler.all[p.item(0).parentNode.id].setChecked(true);
			}
		%endloop%
	%endloop servers%
%endinvoke%

stopProgressBar();

</script>

</BODY></HTML>
