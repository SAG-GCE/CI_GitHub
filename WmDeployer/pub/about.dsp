<html>
<head>
<!-- Copyright (c) 2005, webMethods Inc.  All Rights Reserved. -->
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="-1">
<title>About webMethods Deployer</title> 
<link rel="stylesheet" type="text/css" href="webMethods.css">
<style> body { border-top: 1px solid black; } </style>
<script src="webMethods.js"></script>
</head>

<body>
<table class="tableView" width="100%">
	<tbody>
		<tr>
			<td class="heading" colspan="2">Copyright</td>
		</tr>
		<tr>
        	<td class="evenrow-l" colspan="2">
              <table class="tableInline" width="100%" cellspacing="0px" cellpadding="0px">
                <tbody><tr>
                  <td width="100%">
                    <table class="tableInline" width="100%" cellspacing="0px" cellpadding="0px">
                      <tbody>
                      	<tr>
	                        <td valign="top"><img src="images/blank.gif" height="0" width="5"><img src="images/webmethods_deployer_stacked.png" border="0">&nbsp;&nbsp;&nbsp;&nbsp;</td>
	                        <td>
		                         <b>webMethods Deployer</b>
		                         <br>
					        	<font style="font-family: trebuchet ms;">Copyright © 2004 - 2016 Software AG, Darmstadt, Germany and/or Software AG USA Inc., Reston, VA, USA, and/or its subsidiaries and/or its affiliates and/or their licensors.
							       	 <br><br>
	     								The name Software AG and all Software AG product names are either trademarks or registered trademarks of Software AG and/or Software AG USA Inc. and/or its subsidiaries and/or its affiliates and/or their licensors. Other company and product names mentioned herein may be trademarks of their respective owners. 	
							    	 <br><br>
	     								Detailed information on trademarks and patents owned by Software AG and/or its subsidiaries is located at <a href="http://softwareag.com/licenses/">http://softwareag.com/licenses.</a>
							    	 <br><br>
	     								This software may include portions of third-party products. For third-party copyright notices, license terms, additional rights or restrictions, please refer to "License Texts, Copyright Notices and Disclaimers of Third Party Products". For certain specific third-party license restrictions, please refer to section E of the Legal Notices available under "License Terms and Conditions for Use of Software AG Products / Copyright and Trademark Notices of Software AG Products". These documents are part of the product documentation, located at http://softwareag.com/licenses and/or in the root installation directory of the licensed product(s).
							    	 <br><br>
	     								Use, reproduction, transfer, publication or disclosure is prohibited except as specifically provided for in your License Agreement with Software AG.	
							    	 <br>
					    		</font>          
	        				 </td>
                      	 </tr>
                       </tbody>
                     </table>
         		  </td>
                 </tr>
                </tbody>
              </table>
			</td>
        </tr>
       
	</tbody>
</table>

<table class="tableView" width="100%">
	<tr>
		<td class="heading" colspan="2">Product Information</td>
	</tr>
	<tr>
    	<td class="evenrow">Name</td>
    	<td class="evenrowdata-l">webMethods Deployer</td>
    </tr>
    %scope param(package='WmDeployer')%
	%invoke wm.deployer.Wrapper:getPackageInfo%
	<tr>	    
		<td class="evenrow">Version</td>
		<td class="evenrowdata-l" colspan=3>%value version%</td>
	</tr>

	<tr>	    
		<td class="oddrow">Build</td>
		<td class="oddrowdata-l" colspan=3>%value build%</td>
	</tr>

	<tr>	    
		<td class="evenrow">Patches Applied</td>
		<td class="evenrowdata-l" colspan=3>%value patch_nums%</td>
	</tr>
	%endscope%
</table>

<table class="tableView" width="100%">
	<tr>
		<td class="heading" colspan="2">Environment</td>
	</tr>
	<tr>
			%invoke wm.deployer.Wrapper:getCurrentUser%
			<td class="oddrow" valign=top>Current User</td>
			<td class="oddrowdata-l" colspan=3>%value username%&nbsp;</td>
			%endinvoke%
		</tr>

		<tr>
			<td class="evenrow" valign=top>Web Host</td>
			<td class="evenrowdata-l" colspan=3>
			<a href="/WmRoot/server-environment.dsp">webMethods Integration Server</a> running on %sysvar host% at port %sysvar property(watt.server.port)% </td>
		</tr>
	
</table>
</body>
</html>
