<script language="JavaScript">
    var agent = navigator.userAgent.toLowerCase();   
    var ie = (agent.indexOf("msie") != -1);
	
	function toggleKerberosProperties(){
		var cAuth = document.getElementById('clientAuth');
		if (cAuth != null && cAuth.value != null && (cAuth.value == 'requestKrb' || cAuth.value == 'requireKrb')) {
			displayRows("kerberosPropsDiv");
		} else {
			hideRows("kerberosPropsDiv");
		}
	}
	
	function toggleKerberosProperties(cAuth){
		var cAuth2 = cAuth;
		if( cAuth.type != null && cAuth.type.indexOf('select') >= 0 ) {
			cAuth2 = cAuth.value;
		} else {
			cAuth2 = cAuth;
		}
		if (cAuth2 != null && (cAuth2 == 'requestKrb' || cAuth2 == 'requireKrb')) {
			displayRows("kerberosPropsDiv");
		} else {
			hideRows("kerberosPropsDiv");
		}
	}
	
	function processKrbOnSubmit(){
		var obj1 = document.getElementById("krbClientPassword");
		var obj2 = document.getElementById("retype_krbClientPassword");
		if(obj1 != null && obj2 != null) {
			var clientPwd = obj1.value;
			var clientRePwd = obj2.value;
			var pwdConfirm = confirmPassword(clientPwd, clientRePwd, "Kerberos Client");
			return pwdConfirm;
		} else {
			return true;
		}
	}

	function toggleIdentityProvider() {
		var cAuth = document.getElementById('clientAuth');
		var idP   = document.getElementById('idProvider');
		if (idP != null) {
			if (cAuth.value == 'idProvider') {
				idP.disabled = false;
			} else {
				idP.disabled = true;
			}
		}
	}

	function respondToClientAuthChange(cAuth) {
		toggleIdentityProvider();
		toggleKerberosProperties(cAuth);
	}
	
	function confirmPassword(original, retyped, type) {
		if (original.length > 0 && retyped.length == 0) {
			alert (type + " password must be retyped for confirmation.");
			return false;
		} else if (original != retyped) {
			alert ("The " + type + " passwords entered do not match.");
			return false;
		}
		return true;
	}	
	
	function toggleJSSEoption(index, disable) {
		var elems = document.getElementsByName("useJSSE");
		elems[index].disabled=disable;
		elems[index+1].disabled=disable;
		if(disable) { // visible
			elems[index].checked=false;
			elems[index+1].checked=true;
		} else {
			elems[index].checked=true;
			elems[index+1].checked=false;
		}
	}
	
	function hideJSSERow() {
		var elems = document.getElementsByName("JSSERow");
		var i;
		for (i = 0; i < elems.length; i++) {
			elems[i].style.display="none";
		}
	}
	
	function showJSSERow() {
		var elems = document.getElementsByName("JSSERow");
		var i;
		for (i = 0; i < elems.length; i++) {
			if (ie) {
				elems[i].style.display="block";
			}else{
				elems[i].style.display="block";
				elems[i].style.display="table-row";
			}
		}
	}	
	
	function displayRows(elementID)
	{
		elem = document.getElementById(elementID);
		rows = elem.rows;

		for(i = 0; i < rows.length; i++){
			if (ie) {
				rows[i].style.display="block";
			}else{
				rows[i].style.display="block";
				rows[i].style.display="table-row";
			}
		}
	}

	function hideRows(elementID)
	{
		elem = document.getElementById(elementID);
		rows = elem.rows;

		for(i = 0; i < rows.length; i++){
			rows[i].style.display="none";
		}
	}	
	
</script>	

<tbody>
    <tr>
		<td class="heading" colspan="2">Security Configuration</td>
   	</tr>
	
	<tr name="JSSERow" id="JSSERow">
			<td class="evenrow">Use JSSE</td>
		    	<td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
		    	%ifvar mode equals('view')%
		        	%switch useJSSE%
		            	    %case 'yes'%Yes
		            	    %case 'true'%Yes
		                    %case%No
		             %endswitch%
		         %else%
				<input type="radio" name="useJSSE" value="yes" 
					%switch useJSSE%
		            	    %case 'yes'%checked
		            	    %case 'true'%checked
							%case%checked
		             %endswitch%>Yes</input>
				<input type="radio" name="useJSSE" value="no" %switch useJSSE%
		            	    %case 'no'%checked
		            	    %case 'false'%checked
		             %endswitch%>No</input>		         
		          %endif%
		       </td>
	</tr>

	<tr>
			<td class="evenrow">Client Authentication</td>
		    <td class="%ifvar ../mode equals('view')%evenrowdata-l%else%evenrow-l%endif%">
		    	%ifvar mode equals('view')%
		        	%ifvar clientAuth equals('none')%Username/Password%endif%
					%ifvar clientAuth equals('digest')%Digest%endif%
					%ifvar clientAuth equals('requestKrb')%Request Kerberos Ticket%endif%
					%ifvar clientAuth equals('requireKrb')%Require Kerberos Ticket%endif%					
					%ifvar ssl equals('true')%
						%ifvar clientAuth equals('request')%Request Client Certificates%endif%
						%ifvar clientAuth equals('require')%Require Client Certificates%endif%
						%ifvar clientAuth equals('idProvider')%Use Identity Provider%endif%
					%endif%
		         %else%
					  <select name="clientAuth" id="clientAuth" onchange="respondToClientAuthChange(this.value);">
						  <option %ifvar clientAuth equals('none')%selected %endif%value="none">Username/Password</option>
						  %ifvar listenerType equals('revinvokeinternal')%
						  %else%
							  %ifvar ftps equals('true')%
							  %else%
								<option %ifvar clientAuth equals('digest')%selected %endif%value="digest">Digest</option>
							  %endif%  	
						  %endif%
						  %ifvar ssl equals('true')%
							  <option %ifvar clientAuth equals('request')%selected %endif%value="request">Request Client Certificates</option>
							  <option %ifvar clientAuth equals('require')%selected %endif%value="require">Require Client Certificates</option>
							  %ifvar ftps equals('true')% 
							  %else%
							     <option %ifvar clientAuth equals('idProvider')%selected %endif%value="idProvider">Use Identity Provider</option>
							  %endif%
						  %endif%
						  %ifvar listenerType equals('revinvokeinternal')%
						  %else%						  
							  %ifvar ftps equals('true')%
							  %else%
								<option %ifvar clientAuth equals('requestKrb')%selected %endif%value="requestKrb">Request Kerberos Ticket</option>
								<option %ifvar clientAuth equals('requireKrb')%selected %endif%value="requireKrb">Require Kerberos Ticket</option>
							  %endif%
						  %endif%
					  </select>
		          %endif%
		       </td>
	</tr>
	%ifvar ssl equals('true')%
   	   %ifvar ftps equals('true')% 
	   %else%
       <tr>
			<td class="oddrow">Identity Provider
			</td>
		    <td class="%ifvar ../mode equals('view')%oddrowdata-l%else%oddrow-l%endif%">
					%ifvar mode equals('view')%
						%ifvar clientAuth equals('idProvider')%
							%value idProvider%
						%else%
							none
						%endif%
					%else%
						%invoke wm.server.security.openid:getIdProviderNamesUI%
							<select name="idProvider" id="idProvider">
							%loop names%
								<option value="%value name%" %ifvar ../idProvider vequals(name)% selected %endif%>%value name%</option>
							%endloop%
							</select>
						%endinvoke%
					%endif%
			</td>
	   </tr>
	   %endif%
	%endif%
	%ifvar listenerType equals('revinvoke')%
		<tr>
			<td class="evenrow">&nbsp;</td>
			<td class="evencol-l">Must match Client Authentication setting on the Internal Server.</td>
		</tr>	
	%endif%
	
	%switch listenerType%
	%case 'revinvoke'%
		<script>showJSSERow();</script>
	%case 'revinvokeinternal'%
		<script>showJSSERow();</script>
	%case%
		%ifvar ssl equals('true')%
		%else%
			<script>hideJSSERow(); </script>
		%endif%
	%end%
	
	%ifvar ftps equals('true')%
		<script> hideJSSERow(); </script>
	%endif%	
	
</tbody>

<!-- Kerberos Properties-->

<tbody id="kerberosPropsDiv">
<TR>
	<TD colspan="2" class="heading">Kerberos Properties (Optional)</TD>
</TR>
<TR>
	<TD class="evenrow">JAAS Context</TD>
	<TD class="evenrow-l">
		%ifvar ../mode equals('view')%
				%value -htmlall kerberosSettings/jaasContext%
		%else%
			<input type="text" name="krbJaasContext" id="krbJaasContext" value="%value -htmlall kerberosSettings/jaasContext%" size="60">
		%endif% 
	</TD>
</TR>
<TR>
	<TD class="oddrow">Principal</TD>
	<TD class="oddrow-l">
		%ifvar ../mode equals('view')%
			%value -htmlall kerberosSettings/clientPrincipal%
		%else%
			<input type="text" name="krbClientPrincipal" VALUE="%value -htmlall kerberosSettings/clientPrincipal%" size="60">
		%endif% 
	</TD>
</TR>
%ifvar ../mode equals('view')%
%else%
	<TR id="clntPwdRow">
		<TD class="evenrow">Principal Password</TD>
		<TD class="evenrowdata-l">
			<input type="password" name="krbClientPassword" id="krbClientPassword" value="%value -htmlall kerberosSettings/clientPassword%" autocomplete="off">
		</TD>
	</TR>
	<TR id="clntPwdReRow">
		<TD class="oddrow">Retype Principal Password</TD>
		<TD class="oddrowdata-l">
			<input type="password" name="retype_krbClientPassword" id="retype_krbClientPassword" value="%value -htmlall kerberosSettings/clientPassword%" autocomplete="off">
		</TD>
	</TR>
%endif%
<TR>
	<TD class="evenrow">Service Principal Name Format</TD>
	<TD class="evenrow-l">
		%ifvar ../mode equals('view')%
			%ifvar kerberosSettings/servicePrincipalForm equals('username')% username %else% host-based %endif%
		%else%
			<label>
				<input type="radio" name="krbServicePrincipalForm" value="hostbased" 
					%ifvar kerberosSettings/servicePrincipalForm equals('username')%
					%else%checked%endif% />
				host-based
			</label>
			<label>
				<input type="radio" name="krbServicePrincipalForm" value="username" 
					%ifvar kerberosSettings/servicePrincipalForm equals('username')%checked%endif% />
				username
			</label>
		%endif%
	</TD>
</TR>
<TR>
	<TD class="oddrow">Service Principal Name</TD>
	<TD class="oddrow-l">
		%ifvar ../mode equals('view')%
			%value -htmlall kerberosSettings/servicePrincipal%
		%else%
			<input type="text" name="krbServicePrincipal" id="krbServicePrincipal" value="%value -htmlall kerberosSettings/servicePrincipal%" size="60">
		%endif% 
	</TD>
</TR>

</tbody>
%ifvar ../mode equals('view')%
<SCRIPT> toggleKerberosProperties(clientAuth); </SCRIPT>
%else%
%ifvar ../mode equals('edit')%
<SCRIPT> toggleKerberosProperties(clientAuth); </SCRIPT>
%else%
<SCRIPT> toggleKerberosProperties(); </SCRIPT>
%endif%
%endif%
<script>toggleIdentityProvider();</script>
