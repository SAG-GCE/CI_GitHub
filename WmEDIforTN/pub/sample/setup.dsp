<html>

	<head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
		<title>Sample Setup</title>
        <base target="_self">
	</head>

	<body>

	<TABLE>
      	<tr>
			<TD class="menusection-Solutions">Sample Setup</TD> 
		</tr>

	<tr>
	<td>
        <table>
          <tbody>
            <tr>
              <td colspan="2">
               	<IMG border="0" src="../images/blank.gif" width="10" height="10">
              </td>
            </tr>
            <tr>
              <td class="evenrow-l" align="middle" colspan="2">
					<P align="left">
				The setup process will create the following items.  If you are running the 
                EDI Module EDIINT demo too, run the EDIINT demo first, then run this setup.   
					</P>
					<P align="left">
				After running this setup process you must import four process models into the webMethods Modeler.  The models are located in the directory 
                <em>ServerDirectory\packages\WmEDIforTN\config\Models</em>.  After importing these models, use the webMethods Modeler to generate process models.  See the 
                <i>webMethods Modeler User's Guide</i> for help with these procedures.
					</P>
              </td>
            </tr>
            <tr>
              <td colspan="2">
               	<IMG border="0" src="../images/blank.gif" width="10" height="10">
              </td>
            </tr>
            <tr>
                      <td class="subheading" colspan="2"><b>Document Types:</b></td>
            </tr>
            <tr>
                      <td class="oddrow-l" colspan="2" nowrap>X12 4010 850</td>
            </tr>
            <tr>
                      <td class="evenrow-l" colspan="2">X12 4010 855 </td>
            </tr>
            <tr>
                      <td class="oddrow-l" colspan="2" nowrap>EDI for TN Sample PO</td>
            </tr>
            <tr>
                      <td class="evenrow-l" colspan="2" nowrap>EDI Sample Envelope</td>
            </tr>
            <tr>
              <td colspan="2">
               	<IMG border="0" src="../images/blank.gif" width="10" height="10">
              </td>
            </tr>
            <tr>
            		 <FORM NAME="install" METHOD="POST" ACTION="dosetup.dsp" target="">
                      <td class="subheading" colspan="2">
                        <b>Sender Profile:</b>       
                      </td>
            </tr>
            <tr>
                      <td class="evenrow">Corporation Name</td>
                      <td class="evenrow-l">SENDER</td>
                      <INPUT TYPE="HIDDEN" NAME="SenderCorporateName" VALUE="SENDER">

            </tr>
            <tr>
                      <td class="oddrow">External ID (DUNS)</td>
                      <td class="oddrow-l">112223333</td>
                      <INPUT TYPE="HIDDEN" NAME="SenderDuns" VALUE="112223333">
            </tr>
            <tr>
                      <td class="evenrow" nowrap>Host</td>
                      <td class="evenrow-l"><input type="text" name="SenderHost" value="localhost"></td>
            </tr>
            <tr>
                      <td class="oddrow" nowrap>Port</td>
                      <td class="oddrow-l"><input type="text" name="SenderPort" value="5555"></td>
            </tr>
            <tr>
                      <td class="evenrow" nowrap>Location</td>
                      <td class="evenrow-l">/invoke/wm.b2b.editn.sample.util:receive</td>
            </tr>
            <tr>
                      <td class="oddrow" nowrap>User Name </td>
                      <td class="oddrow-l"><input type="text" name="SenderUserName" value="Administrator">
                      </td>
            </tr>
            <tr>
                      <td class="evenrow" nowrap>Password</td>
                      <td class="evenrow-l"><input type="password" name="SenderPassword" value="manage"></td>
            </tr>
            <tr>
              <td colspan="2">
               	<IMG border="0" src="../images/blank.gif" width="10" height="10">
              </td>
            </tr>
                  <tbody>
                   

                    <tr>
                      <td class="subheading" colspan="2"><b>Receiver Profile:</b> </td>
                    </tr>
                    <tr>
                      <td class="evenrow">Corporation Name </td>
                      <td class="evenrow-l">SENDER</td>
                      <INPUT TYPE="HIDDEN" NAME="ReceiverCorporateName" VALUE="RECEIVER">
                    </tr>
                      <tr>
                      <td class="oddrow">External ID (DUNS) </td>
                      <td class="oddrow-l">445556666</td>
                      <INPUT TYPE="HIDDEN" NAME="ReceiverDuns" VALUE="445556666">
                      </tr>
                    <tr>
                      <td class="evenrow" nowrap>
                        Host
                      </td>
                      <td class="evenrow-l">
                      <input type="text" name="ReceiverHost" value="localhost">
                      </td>
                    </tr>
                      <tr>
                      <td class="oddrow" nowrap>Port</td>
                      <td class="oddrow-l"><input type="text" name="ReceiverPort" value="5555"></td>
                      </tr>
                      <tr>
                      <td class="evenrow" nowrap>Location</td>
                      <td class="evenrow-l">/invoke/wm.b2b.editn.sample.util:receive</td>
                      </tr>
                      <tr>
                      <td class="oddrow" nowrap>User Name </td>
                      <td class="oddrow-l"><input type="text" name="ReceiverUserName" value="Administrator"></td>
                      </tr>
                      <tr>
                      <td class="evenrow" nowrap>Password</td>
                      <td class="evenrow-l"><input type="password" name="ReceiverPassword" value="manage"></td>
                      </tr>
                    <tr>
                      <td class="action" colspan="2">
                        <input type="submit" value="Setup">
                      </td>
                    </tr>
                    <tr>
              <td colspan="2">
               	<IMG border="0" src="../images/blank.gif" width="10" height="10">
              </td>
                    </tr>
                    </form>
                    <tr>
              <td colspan="2">
               	<IMG border="0" src="../images/blank.gif" width="10" height="10">
              </td>
                    </tr>
                    <tr>
              <td colspan="2">
				<A HREF="index.dsp">Back</A> to introduction | <A HREF="send.dsp">Run</A> the example 
              </td>
                    </tr>
                  </tbody>
        </table>
					</td>
				</tr>
			</table>

	</body>

</html>
