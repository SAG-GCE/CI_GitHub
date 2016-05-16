<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Monitor Configuration Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
<SCRIPT>
    function onSubmit() {
	retVal = true;

	document.config.edit.value = true;
	
	if(isEmptyField('myWebmethodsPort')){
	alertFieldDefaultSet();
	}else if(isEmptyField('myWebmethodsHost')){
	alertFieldDefaultSet();
	}else if(isEmptyField('myWebmethodsTransport')){
	alertFieldDefaultSet();
	}else if(isEmptyField('myWebmethodsUserName')){
	alertFieldDefaultSet();
	}else if(isEmptyField('myWebmethodsPassword')){
	alertFieldDefaultSet();
	}else if(isEmptyField('dbRetries')){
	alertFieldDefaultSet();
	}else if(isEmptyField('connTimeout')){
	alertFieldDefaultSet();
	}else if(isEmptyField('dlsEnabled')){
	alertFieldDefaultSet();
	}
	else if(isEmptyField('dlsSuperUser')){
	alertFieldDefaultSet();
	}else if(isEmptyField('reportingBatchSize')){
	alertFieldDefaultSet();
	}else if(isEmptyField('jdbcArchive')){
	alertFieldDefaultSet();
	}
	else if(isEmptyField('addMwUsertoMonitorACL')){
	alertFieldDefaultSet();
	}
	else if(isEmptyField('resubmitOnLocalIS')){
		alertFieldDefaultSet();
	//}else if(isEmptyField('eventStoreServiceName')){
	//	alertFieldDefaultSet();
	//}else if(isEmptyField('useEventStoreForSearch')){
	//	alertFieldDefaultSet();
	}
	
	function alertFieldDefaultSet(){
	alert('The empty fields will be set to their default values');
	}
	
	 function isEmptyField(fieldName){
	  theForm = document.config;
	  valueField = eval('theForm.' + fieldName);
	  theValue = valueField.value.trim();
	  
	  if(theValue==""){
	  return true;
	  }else{
	  return false;
	  }
	  }

        if ( !isValidPositiveNumber('myWebmethodsPort') ) {
          alert('The MWS Port must be a positive number');
          retVal = false;
        }
        
        if ( !isValidPositiveNumber('dbRetries') ) {
          alert('The Database Retries must be a positive number');
          retVal = false;
        }
        
        if ( !isValidPositiveNumber('reportingBatchSize') ) {
          alert('The Reporting Batch Size must be a positive number');
          retVal = false;
        }

	if (retVal) {
		document.config.submit();
	}
        return retVal;
      }

      function isValidPositiveNumber(fieldName) {
        theForm = document.config;
        valueField = eval('theForm.' + fieldName);
        theValue = valueField.value.trim();
        
        if( Number(valueField.value) < 0 || (valueField.value % 1) != 0) {
          valueField.focus();
          return false;
        }
        return true;
      }

      String.prototype.trim = function() {
        a = this.replace(/^\s+/, '');
        return a.replace(/\s+$/, '');
      };
		
    function setDefault() {
    	document.config.edit.value = false;
    	document.config.submit();
    }
</SCRIPT>
</HEAD>
<BODY onLoad="setNavigation('monitorConfigSettings.dsp');">

<FORM NAME="config">
<INPUT NAME="edit" TYPE="hidden">
  <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings" colspan="2">
          Monitor &gt;
          Configuration Settings 
      </TD>
    </TR>
    %invoke wm.monitor.util:configSettings%
    %ifvar errorMessage%
    	<tr>
    	   <td class="message">%value errorMessage%</td>
    	</tr>
    %endif%
    %ifvar message%
    	<tr>
    	  <td class="message">%value message%</td>
    	</tr>
    %endif%
    <TR> 
      <TD>
          <TABLE class="tableForm">
          <TR>
            <TD class="heading" colspan="2">Configuration Settings</TD>
          </TR>
	<SCRIPT>swapRows();</SCRIPT>
    		<TR>
              <SCRIPT>writeTDnowrap("row");</SCRIPT>
              	MWS Host</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="myWebmethodsHost"  VALUE="%value myWebmethodsHost%">
            </TD>    
          </TR>
	<SCRIPT>swapRows();</SCRIPT>
    		<TR>
              <SCRIPT>writeTDnowrap("row");</SCRIPT>
              	MWS Port</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="myWebmethodsPort"  VALUE="%value myWebmethodsPort%">
            </TD>    
          </TR>
	<SCRIPT>swapRows();</SCRIPT>
    		<TR>
              <SCRIPT>writeTDnowrap("row");</SCRIPT>
              	MWS Transport</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="myWebmethodsTransport"  VALUE="%value myWebmethodsTransport%">
            </TD>    
          </TR>
	<SCRIPT>swapRows();</SCRIPT>
    		<TR>
              <SCRIPT>writeTDnowrap("row");</SCRIPT>
              	MWS Username</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="myWebmethodsUserName"  VALUE="%value myWebmethodsUserName%">
            </TD>    
          </TR>
	<SCRIPT>swapRows();</SCRIPT>
    		<TR>
              <SCRIPT>writeTDnowrap("row");</SCRIPT>
              	MWS Password</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT TYPE="password" NAME="myWebmethodsPassword"  VALUE="********">
            </TD>    
          </TR>
	<SCRIPT>swapRows();</SCRIPT>
    		<TR>
              <SCRIPT>writeTDnowrap("row");</SCRIPT>
              	Database Retries</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="dbRetries"  VALUE="%value dbRetries%">
            </TD>    
          </TR>
           <SCRIPT>swapRows();</SCRIPT>
          <TR>
              <SCRIPT>writeTDnowrap("row");</SCRIPT>
              	Connection Timeout</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="connTimeout"  VALUE="%value connTimeout%">
            </TD>    
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Enable Data Level Security</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT TYPE=CHECKBOX NAME="dlsEnabled" %ifvar dlsEnabled equals('true')%CHECKED%end%>
                
            </TD>    
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Data Level Security Administrator</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="dlsSuperUser"  VALUE="%value dlsSuperUser%">
                
            </TD>    
          </TR>
	  <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Reporting Batch Size</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="reportingBatchSize"  VALUE="%value reportingBatchSize%">
            </TD>    
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
               Enable JDBC Archive for Server, Service, Activation, Document</TD>
              <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT TYPE=CHECKBOX NAME="jdbcArchive" %ifvar jdbcArchive equals('true')%CHECKED%end%>
            </TD>    
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
	  <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Add 'My webMethods Users' role to 'MonitorUsers' ACL</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT TYPE=CHECKBOX NAME="addMwUsertoMonitorACL" %ifvar addMwUsertoMonitorACL equals('true')%CHECKED%end%>
            </TD>    
          </TR> 
	  <SCRIPT>swapRows();</SCRIPT>
	    <TR>
	      <SCRIPT>writeTDnowrap("row");</SCRIPT>
		Resubmit to local IS</TD>
	      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
		  <INPUT TYPE=CHECKBOX NAME="resubmitOnLocalIS" %ifvar resubmitOnLocalIS equals('true')%CHECKED%end%>

	      </TD>    
	    </TR>
	    <!--<SCRIPT>swapRows();</SCRIPT>
    		<TR>
              <SCRIPT>writeTDnowrap("row");</SCRIPT>
              	Event Store Service Name</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="eventStoreServiceName"  VALUE="%value eventStoreServiceName%">
            </TD>    
          </TR>
          <SCRIPT>swapRows();</SCRIPT>
	    <TR>
	      <SCRIPT>writeTDnowrap("row");</SCRIPT>
		Use Event Store for Search</TD>
	      <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
		  <INPUT TYPE=CHECKBOX NAME="useEventStoreForSearch" %ifvar useEventStoreForSearch equals('true')%CHECKED%end%>

	      </TD>    
	    </TR>-->
                    <TR>
		<TD class="action" colspan=2><INPUT type="button" value="Submit" onclick="onSubmit();">
		<INPUT type="button" value="Revert Changes" onclick="setDefault();">
		</TD>
	  </TR>
        </TABLE>
      </TD>
    </TR>
  </TABLE>    
  %endinvoke wm.monitor.util:configSettings%  
</FORM>
</BODY>
</HTML>
