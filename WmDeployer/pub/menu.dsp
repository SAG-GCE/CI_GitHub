<html>
  <!-- Copyright (c) 2003, webMethods Inc.  All Rights Reserved. -->
<head>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<link rel="stylesheet" type="text/css" href="webMethods.css">
<SCRIPT src="menu.js"></SCRIPT>
<SCRIPT language=JavaScript>

var selected = null;
function menuSelect(object, id) {
	selected = menuext.select(object, id, selected);
}
</SCRIPT>
<style>
	body { border-top: 1px solid #97A6CB; }
	#stk {position:absolute; visibility:hidden;}
</style>
</head>

<SCRIPT language=JavaScript>
var ie5 = (document.getElementById && document.all);
var ns6 = (document.getElementById && !document.all);

var rightPos = 1;  // how much pixel before left
var bottomPos = 1; // how much pixel before bottom 

function statik(){
    	if(ie5){
        	pageYOffset = document.body.scrollTop;
		innerWidth = document.body.offsetWidth;
		innerHeight = document.body.offsetHeight;
	}
	if(ie5 || ns6){
        	statikLayer = document.getElementById('stk');
		statikLayer.style.left = 0 + rightPos;
		statikLayer.style.visibility = 'visible';
		statikLayer.style.top = (innerHeight - statikLayer.offsetHeight - bottomPos) + pageYOffset;
		setTimeout ('statik()', 10);
	}
}

var progressEnd = 7;						// set to number of progress <span>'s.
var progressColor = '#800080'; 	// set to progress bar color
var progressInterval = 500;			// set to time between updates (milli-seconds)

var progressAt = progressEnd;
var progressTimer;

function _progress_clear() {
	for (var i = 1; i <= progressEnd; i++) top.menu.document.getElementById('progress'+i).style.backgroundColor = 'transparent';
	progressAt = 0;
}

function _progress_start() {
	progressAt++;
	if (progressAt > progressEnd) _progress_clear();
	else document.getElementById('progress'+progressAt).style.backgroundColor = progressColor;
	progressTimer = setTimeout('_progress_start()',progressInterval);
}

function _startProgressBar() {
	//_stopProgressBar();
	//top.menu.document.all["progressBar"].style.display  = "inline";
	//_progress_start();
}

function _stopProgressBar() {
	//clearTimeout(progressTimer);
	//_progress_clear();
	//top.menu.document.all["progressBar"].style.display  = "none";
}
</script>

<body class="menu" onload="statik();defaultSelectedColor();">

	<table class="menuTable" width="100%" cellspacing="0" cellpadding="0" border="0">
		<tr>
			<td class="menusection-Deployer menusection menusection-expanded">
				Deployer
			</td>
		</tr>

		%scope param(itemName='Projects')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this, '%value itemName%');"
				onclick="menuSelect(this, '%value itemName%'); document.all['a%value itemName%'].click();"
				<nobr>
				<a id="a%value itemName%" target="body" href="project-manager.dsp">
				<span class="menuitemspan">%value itemName%</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%
		
		<tr>
			<td id="Repository" class="menuitem"
				onmouseover="menuMouseOver(this, 'Repository');"
				onmouseout="menuMouseOut(this, 'Repository');"
				onclick="menuSelect(this, 'Repository'); document.all['aRepository'].click();"
				<nobr>
				<a id="aRepository" target="body" href="remote-repository-manager.dsp"
					onclick="_startProgressBar();">
				<span class="menuitemspan">Repository</span></a>
				</nobr>
			</td>
		</tr>

		%scope param(itemName='Settings')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this, '%value itemName%');"
				onclick="menuSelect(this, '%value itemName%'); document.all['a%value itemName%'].click();"
				<nobr>
				<a id="a%value itemName%" target="body" href="settings-manager.dsp">
				<span class="menuitemspan">%value itemName%</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%
		
		%scope param(itemName='PasswordStore')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this, '%value itemName%');"
				onclick="menuSelect(this, '%value itemName%'); document.all['a%value itemName%'].click();"
				<nobr>
				<a id="a%value itemName%" target="body" href="passstore-manager.dsp">
				<span class="menuitemspan">Password Store</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%

		<tr>
			<td class="menusection menusection-expanded">
				Servers
			</td>
		</tr>



		%scope param(itemName='Servers')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this, '%value itemName%');"
				onclick="menuSelect(this, '%value itemName%'); document.all['a%value itemName%'].click();"
				<nobr>
				<a id="a%value itemName%" target="body" href="remote-server-manager.dsp"
					onclick="_startProgressBar();" >
				<span class="menuitemspan">IS & TN</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%




%invoke wm.deployer.gui.UIPlugin:listPlugins%
	%loop plugins%
		<tr>
			<td nowrap id="%value pluginType%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value pluginType%');"
				onmouseout="menuMouseOut(this, '%value pluginType%');"
				onclick="menuSelect(this, '%value pluginType%'); document.all['a%value pluginType%'].click();"
				<nobr>
				<a id="a%value pluginType%" target="body" href="plugin-server-manager.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%"
					onclick="_startProgressBar();">
				<span class="menuitemspan">%value pluginLabel%</span></a>
				</nobr>
			</td>
		</tr>
	%endloop%
%endinvoke%
		<tr>
			<td class="menusection-Server menusection menusection-expanded">
				Target Groups
			</td>
		</tr>

%scope param(itemName='TargetGroup')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this, '%value itemName%');"
				onclick="menuSelect(this, '%value itemName%'); document.all['a%value itemName%'].click();"
				<nobr>
				<a id="a%value itemName%" target="body" href="targetIS-group-manager.dsp?pluginType=IS"
					onclick="_startProgressBar();" >
				<span class="menuitemspan">IS & TN</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%

%invoke wm.deployer.gui.UIPlugin:listPlugins%
	%loop plugins%
		<tr>
			<td nowrap id="%value pluginType%1" class="menuitem"
				onmouseover="menuMouseOver(this, '%value pluginType%1');"
				onmouseout="menuMouseOut(this, '%value pluginType%1');"
				onclick="menuSelect(this, '%value pluginType%1'); document.all['a%value pluginType%1'].click();"
				<nobr>
				<a id="a%value pluginType%1" target="body" href="target-group-manager.dsp?pluginType=%value -htmlcode pluginType%&pluginLabel=%value -htmlcode pluginLabel%&action=default"
					onclick="_startProgressBar();">
				<span class="menuitemspan">%value pluginLabel%</span></a>
				</nobr>
			</td>
		</tr>
	%endloop%
%endinvoke%


		<tr>
			<td class="menusection-Logs menusection menusection-expanded">
				Logs
			</td>
		</tr>
%scope param(itemName='Audit')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this, '%value itemName%');"
				onclick="menuSelect(this, '%value itemName%'); document.all['a%value itemName%'].click();"
				<nobr>
				<a id="a%value itemName%" target="body" href="audit-log.dsp">
				<span class="menuitemspan">%value itemName%</span></a>
				</nobr>
			</td>
		</tr>
%endscope%

	  <tr>
			<td class="menusection-DeployerTools menusection menusection-expanded">
				Tools
			</td>
		</tr>


		%scope param(itemName='Import')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this, '%value itemName%');"
				onclick="menuSelect(this, '%value itemName%'); document.all['a%value itemName%'].click();"
				<nobr>
				<a id="a%value itemName%" target="body" href="import-project.dsp">
				<span class="menuitemspan">Import Build</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%

		%scope param(itemName='Migrate')%
		<tr>
			<td id="%value itemName%" class="menuitem"
				onmouseover="menuMouseOver(this, '%value itemName%');"
				onmouseout="menuMouseOut(this, '%value itemName%');"
				onclick="menuSelect(this, '%value itemName%'); document.all['a%value itemName%'].click();"
				<nobr>
				<a id="a%value itemName%" target="body" href="migrate-project-manager.dsp">
				<span class="menuitemspan">Migrate Data</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%

		%scope param(itemName='Export To Project Automataor')%
		<tr>
			<td id="Export To Project Automataor" class="menuitem"
				onmouseover="menuMouseOver(this, 'Export To Project Automataor');"
				onmouseout="menuMouseOut(this, 'Export To Project Automataor');"
				onclick="menuSelect(this, 'Export To Project Automataor'); document.all['aExport To Project Automataor'].click();"
				<nobr>
				<a id="aExport To Project Automataor" target="body" href="exportToProjectAutomator.dsp"
				<span class="menuitemspan">Export to Project Automator</span></a>
				</nobr>
			</td>
		</tr>
		%endscope%
</table>
<SCRIPT>
	window.open("project-manager.dsp", "body");
</SCRIPT>
<div style="height=0; width=0">
<form name="urlsaver">
%comment%
<input type="hidden" name="helpURL" value="doc/OnlineHelp/WmDeployer.htm">
%endcomment%
<input type="hidden" name="helpURL" value="under-construction.dsp">
</form>
</div>

<!-- Progress Bar -->
<div id="stk">
<table width="100%" id="progressBar" style="display:none" align="center" border="0">
<TR> <TD align="center"><div id="resolve" style="visibility:hidden">This process may take several seconds.</div></TD> </TR>
<TR> <TD id="progressTitle" align="center">Please wait... </TD> </TR>
<tr><td>
<div style="font-size:6pt;padding:1px;border:solid black 1px">
<span id="progress1">&nbsp; &nbsp;</span>
<span id="progress2">&nbsp; &nbsp;</span>
<span id="progress3">&nbsp; &nbsp;</span>
<span id="progress4">&nbsp; &nbsp;</span>
<span id="progress5">&nbsp; &nbsp;</span>
<span id="progress6">&nbsp; &nbsp;</span>
<span id="progress7">&nbsp; &nbsp;</span>
</div> </td></tr>
</table>
</div>

<!-- Hidden input field to start progress Bar -->
<INPUT type="hidden" id="_startProgressBar" onclick="_startProgressBar();">
<INPUT type="hidden" id="_stopProgressBar" onclick="_stopProgressBar();">

</body>
</html>
