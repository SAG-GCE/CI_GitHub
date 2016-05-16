<html>
	<head>
		<title>List FA Reports</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
			
        <style>
		.listbox  { width: 100%; }
	</style>
		<script src="/WmRoot/webMethods.js.txt"></script>


 <SCRIPT>
      
	  function checkAll (control)
	  {
	  	var form = control.form;
		var checked = control.checked;
		if (form != null)
		{
			var elements = form.elements;
			for (i = 0; i < elements.length; i ++)
			{
				elements[i].checked = checked;
			}
		}
	  }
	  
          function doSubmit ()
           {
             if (!confirm ("Do you want to delete the selected files?"))
             {
               return;
             }
             else 
              { 

var str = "";
	     		var forms = document.forms;
	     		
	     	for (fCnt = 0; fCnt < forms.length; fCnt++)
	     		{
	     			if (forms[fCnt].name =="fileListform")
	     			{
	     				var str = "";
	     				var elements = forms[fCnt].elements;
	     				var started = false;
	     				for (eCnt = 0; eCnt < elements.length; eCnt ++)
	     				{
	     					var elem = elements[eCnt];
	     					if (elem.type == "checkbox" && elem.name != "checkall" && elem.checked)
	     					{
	     						if (started)
	     						{
	     							str = str + ",";
	     						}
	     						else
	     						{
	     							started = true;
	     						}
	     						str = str + elem.name;
	     					}
	     				}
	     				
	     
	     				document.fileListform.out.value = str;
	     
	     			}
			}

          	 document.fileListform.submit();
           	}
           }


      function checkChecked (index, pkgName)
      {
        var toCheck = false;
        var elements = document.mainForm.elements;
		alert (elements);
        if (document.mainForm.elements[pkgName].checked)
        {
          toCheck = true;
        }
        var boxNames = pkgs[index];
        var str = "";
        for (i = 0; i < boxNames.length; i ++)
        {
		  if (i = 0)
		  {
		  	alert ("Looking for: " + boxNames[i]);
		  }
          elements[boxNames[i]].checked = toCheck;
        }
      }

      function setShared (control)
      {
        if (control.checked)
        {
          document.hiddenForm.elements[control.name].value = "true";
        }
        else
        {
          document.hiddenForm.elements[control.name].value = "false";
        }
      }
    </SCRIPT>

	</head>

	<body class="main" onLoad="setNavigation('FAOut.dsp', '', 'foo');">
	
	<table width=100% >
		<tr>
			<td class="menusection-Settings" colspan=2>List FA Reports</td>
		</tr>
			
		<tr><td>&nbsp;</td></tr>
	</table>
	
	%scope param(dir='packages/WmEDIforTN/pub/FAReports')%
		%invoke wm.b2b.editn.FAReport:getReportList%
		
		%onerror%
		<table>
			<TR><TD class="message" colspan="2">
			<P><B>The following error occured while attempting to generate FA report:</B></P>
			<P><B>Service: </B>%value errorService%<br>
			<B>Error: </B>%value error%</P>
			</TD></TR>
			
		</table>
	
	%endinvoke%
	
		
	<FORM name="fileListform" METHOD="get" onsubmit="doSubmit()" ACTION="deleteConfirmation.dsp" target="" align="left">
	
		<br>
	<table width=100% >
		<tr>
			<td class="heading" colspan="2">FA Report list:
			</td>
		</tr>
		<tr>
               	<td class="oddcol"><input type="CHECKBOX" name="checkall" onclick="checkAll(this);">&nbsp;Check All</td>
			<td class="oddcol">Report Name</td>
		</tr>							

		<script>resetRows();</script>
			  		
		<tr>
	%loop filelist%
		<script>writeTD('rowdata');</script><INPUT TYPE="CHECKBOX" name="deleteFile" value="%value filelist%"></td>
		<script>writeTD('rowdata-l');</script><nobr><a href="FAReports/%value -urlencode filelist%">%value filelist%</a></nobr></td>


		</tr>
		<script>swapRows();</script>
	%endloop%

		
	   <input type ="hidden" name= "out" value="">
		<tr>
		<td class="action" colspan="4">
			<INPUT TYPE="submit" VALUE="Delete Files" >
            </td>
		</tr>

	</table>

	</FORM>
		
	%end scope%					
	</body>
</html>
