<html>

  <head>
    <LINK REL="stylesheet" TYPE="text/css" HREF="/WmRoot/webMethods.css">
    <SCRIPT src="/WmRoot/webMethods.js.txt"></SCRIPT>

    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <title>Welcome</title>
    <!-- <base target="contents"> -->
  %invoke wm.b2b.edi.migration:getMigrateTemplates%
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
        if (!confirm ("Do you want to migrate the selected templates?"))
        {
          return;
        }
        var str = "";
		var forms = document.forms;
		var hidElem = document.hiddenForm.elements;
		for (fCnt = 0; fCnt < forms.length; fCnt++)
		{
			if (forms[fCnt].name != 'hiddenForm')
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
				var tBoxName = forms[fCnt].name + "_toMigrate";

				hidElem[tBoxName].value = str;

			}
		}
      document.hiddenForm.submit();
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
  <body>
    <DIV class="position">
      <TABLE WIDTH="100%">
          <TR>
		  	<A NAME="top">
            <TD CLASS="menusection-Server" colspan="2">Migration</TD>
          </TR>
          %ifvar Packages -notnull%
			  <TR>
			  	<TD colspan="5">
					<ul>
						%loop Packages%
							%loop Files%
								<li><a href="#%value ../PackageName%_%value Standard%_%value Version%"> %ifvar Standard%Standard: %value Standard%%else%Standard: None%endif%%ifvar Version%; Version: %value Version%%endif%</a></li>
							%endloop%
						%endloop%
						<li><a href="#Bottom">Bottom</A></li>
					</ul>
				</TD>
			  </TR>
            %loop Packages%
              %loop Files%
			    <form name="%value ../PackageName%:%value Standard%:%value Version%">
                <TR CLASS="Heading">
                  <TD>
			  		<a name="%value ../PackageName%_%value Standard%_%value Version%">
				  	Package: %value ../PackageName%<BR>
                    %ifvar Standard%Standard: %value Standard%%else%Standard: None%endif%%ifvar Version%; Version: %value Version%%endif%
                  </TD>
				  <TD>
				  	<A HREF="#top">Top</A>&nbsp;<A HREF="#Bottom">Bottom</A>
				  </TD>
                </TR>
                <TR>
                  <TD CLASS="subheading" width="75%">Template</TD>
                  <TD CLASS="subheading">Migrate (<input type="CHECKBOX" name="checkall" onclick="checkAll(this);"> Migrate All)</TD>
                </TR>
                <script>resetRows();</script>
                  %loop TemplateInfo%
                    <TR>
                    %comment%
                      <script>writeTD("rowdata");</script>
                        %value ../Standard%
                      </TD>
                      <script>writeTD("rowdata");</script>
                        %value ../Version%
                      </TD>
                    %endcomment%
                      <script>writeTD("rowdata");</script>
                        %value TemplateName%
                      </TD>
                    %comment%
                      <script>writeTD("rowdata");</script>
                        %value Exists%
                      </TD>
                    %endcomment%
                      <script>writeTD("rowdata");</script>
                        <INPUT TYPE="CHECKBOX" name="%value TemplateName%">
                      </TD>
                    </TR>
                    <script>swapRows();</script>
                  %endloop%
          		</form>
                %endloop%
            %loopsep '<TR><TD colspan="5">&nbsp;</TD></TD>'%
            %endloop%
          %else%
            <TR>
              <TD class="message">No templates found on this server.  Nothing to migrate
              </TD>
            </TR>
          %end%
          <TR>
            <TD  colspan="5">
              <P>
			  <a name="Bottom">
              <INPUT TYPE="Button" VALUE="Migrate Templates" onclick="doSubmit();">
              </P>
            </TD>
          </TR>
          <form name="hiddenForm" method="POST" action="confirmMigrate.dsp">
            <input type="hidden" name="PackagesToMigrate"
            value="%loop Packages%%loop Files%%value ../PackageName%:%value Standard%:%value Version%%loopsep ','%%endloop%%loopsep ','%%endloop%">
            %loop Packages%
				%loop Files%
   	         		<input type="hidden" name="%value ../PackageName%:%value Standard%:%value Version%_toMigrate">
	   	        	<input type="hidden" name="%value ../PackageName%:%value Standard%:%value Version%_fileName" value="%value FileName%">
				%endloop%
            %endloop%
          </form>
      </TABLE>
    </DIV>
    %onerror%
    </head>
    <body>
      <DIV class="position">
      <TABLE WIDTH="100%">
      <TR>
        <TD CLASS="Title" colspan="5">Migration</TD>
      </TR>
      <TD class="message">Error getting packages: %value error%<BR>
        %value errorMessage%
      </TD>
      </TABLE>
      </DIV>
    %endinvoke%
  </body>
</html>
