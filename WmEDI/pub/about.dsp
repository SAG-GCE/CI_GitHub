<HTML>
	<HEAD>

		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<META HTTP-EQUIV="Expires" CONTENT="-1">

		<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
	</HEAD>
	<BODY onLoad="setNavigation('about.dsp', '', 'foo');">
		<TABLE width="100%">
			<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
			%invoke wm.b2b.edi.util.GUI:getPackageInfos%
		      <TR>
		      <table class="tableView" width="100%">
		      
		                  <tbody><tr>
		                    <td class="heading" colspan="2">Copyright</td>
		                  </tr>
		                  <tr>
		      
		                    <td class="evenrow-l" colspan="2">
		      
		                    <table class="tableInline" width="100%" cellspacing="0px" cellpadding="0px">
		                      <tbody><tr>
		                        <td width="100%">
		                          <table class="tableInline" border="0" width="100%" cellspacing="0px" cellpadding="0px">
		                            <tbody><tr>
		                              <td valign="top"><img src="images/blank.gif" height="0" width="5"><img src="images/SAG_BlueFlag_100x36.png" border="0">&nbsp;&nbsp;&nbsp;&nbsp;</td>
		                              <td>
		            	<b>webMethods EDI 9.0 module</b>
		            	<br>
		            	<font style="font-family: trebuchet ms;">Copyright © 2001 - 2013 Software AG, Darmstadt, Germany and/or Software AG USA, Inc., Reston, VA, United States of America, and/or their licensors.
		            	<br><br>
		      	The name Software AG, webMethods and all Software AG product names are either trademarks or registered trademarks of Software AG and/or Software AG USA, Inc. and/or its Subsidiaries and/or their licensors. Other company and product names mentioned herein may be trademarks of their respective owners. 	
		      	<br><br>
		      	Detailed information on trademarks and patents owned by Software AG and/or its subsidiaries is located at <a href="http://documentation.softwareag.com/legal/">http://documentation.softwareag.com/legal/</a>.
		      	<br><br>
		      	This software may include portions of third-party products. For third-party copyright notices and license terms, please refer to "License Texts, Copyright Notices and Disclaimers of Third Party Products", found at <a href="http://documentation.softwareag.com/legal">http://documentation.softwareag.com/legal/</a> and/or in the root installation directory of the licensed product(s)..
		      	<br>
		      	</font>      	
		      		</td>
		                            </tr>
		                            
		                          </tbody></table>
		                        </td>
		                      </tr>
		                    </tbody></table>
		      
		      
		      </td>
		                    </tr>
</tbody></table></TR><TR>
		            <TABLE class="tableView" width ="100%">
			            <TR>
						<TD class="heading">Package Information</TD>
						<TD class="heading">WmEDI</TD>
					%ifvar WmEDIforTN equals('true')%
						<TD class="heading">WmEDIforTN</TD>
					%endif%
					</TR>
					<TR>
						<script>writeTD("row");</script>Version</TD>
						<script>writeTD("rowdata-l");</script>%value /EDI/version%&nbsp;</TD>
					%ifvar WmEDIforTN equals('true')%
						<script>writeTD("rowdata-l");</script>%value /EDIforTN/version%&nbsp;</TD>
					%endif%
						<script>swapRows();</script>
					</TR>
					<TR>
						<script>writeTD("row");</script>Build</TD>
						<script>writeTD("rowdata-l");</script>%value /EDI/build%&nbsp;</TD>
					%ifvar WmEDIforTN equals('true')%
						<script>writeTD("rowdata-l");</script>%value /EDIforTN/build%&nbsp;</TD>
					%endif%
						<script>swapRows();</script>
					</TR>
					<TR>
						<script>writeTD("row");</script>Minimum Version of JVM</TD>
						<script>writeTD("rowdata-l");</script>%value /EDI/jvm_version%&nbsp;</TD>
					%ifvar WmEDIforTN equals('true')%
						<script>writeTD("rowdata-l");</script>%value /EDIforTN/jvm_version%&nbsp;</TD>
					%endif%
						<script>swapRows();</script>
					</TR>

					<TR>
						<script>writeTD("row");</script>Package List ACL</TD>
						<script>writeTD("rowdata-l");</script>%value /EDI/listACL%&nbsp;</TD>
					%ifvar WmEDIforTN equals('true')%
						<script>writeTD("rowdata-l");</script>%value /EDIforTN/listACL%&nbsp;</TD>
					%endif%
						<script>swapRows();</script>
					</TR>
					<TR>
						<script>writeTD("row");</script>Patches Included</TD>
						<script>writeTD("rowdata-l");</script>%value /EDI/patch_nums%&nbsp;</TD>
					%ifvar WmEDIforTN equals('true')%
						<script>writeTD("rowdata-l");</script>%value /EDIforTN/patch_nums%&nbsp;</TD>
					%endif%
						<script>swapRows();</script>
					</TR>

					<TR>
						<script>writeTD("row");</script>Description</TD>
						<script>writeTD("rowdata-l");</script>%value /EDI/description%&nbsp;</TD>
					%ifvar WmEDIforTN equals('true')%
						<script>writeTD("rowdata-l");</script>%value /EDIforTN/description%&nbsp;</TD>
					%endif%
						<script>swapRows();</script>
					</TR>
					<TR>
						<script>writeTD("row");</script>Publisher</TD>
						<script>writeTD("rowdata-l");</script>%value /EDI/publisher%&nbsp;</TD>
					%ifvar WmEDIforTN equals('true')%
						<script>writeTD("rowdata-l");</script>%value /EDIforTN/publisher%&nbsp;</TD>
					%endif%
						<script>swapRows();</script>
					</TR>
					<TR>
						<script>writeTD("row");</script>Created on</TD>
						<script>writeTD("rowdata-l");</script>%value /EDI/time%&nbsp;</TD>
					%ifvar WmEDIforTN equals('true')%
						<script>writeTD("rowdata-l");</script>%value /EDIforTN/time%&nbsp;</TD>
					%endif%
						<script>swapRows();</script>
					</TR>

					<TR>
					<TR></TR>
					<script>resetRows();</script>
					<TR>
						<TD class="heading">Patch History</TD>
						<TD class="heading">WmEDI</TD>
						%ifvar WmEDIforTN equals('true')%
						<TD class="heading">WmEDIforTN</TD>
						%endif%
					</TR>
					<TR>
						<script>writeTD("row");</script>Names</TD>
						<script>writeTD("rowdata-l");</script>
					%ifvar /EDI/patchlist%
						%loop /EDI/patchlist% %value name%%loopsep ',<BR>'% %endloop%
					%else%
						No Patches
					%endif%
						</TD>
					%ifvar WmEDIforTN equals('true')%
						<script>writeTD("rowdata-l");</script>
					%ifvar /EDIforTN/patchlist%
						%loop /EDIforTN/patchlist% %value name%%loopsep ',<BR>'% %endloop%
					%else%
						No Patches
					%endif%
						</TD>
					%endif%
					</TR>
				</TABLE>
			</TR>
			%endinvoke%
		 </TABLE>
	</BODY>
</HTML>

