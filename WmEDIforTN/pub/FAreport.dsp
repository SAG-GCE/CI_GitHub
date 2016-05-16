<html>

	<head>
		<title>Create FA Report</title>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<script src="/WmRoot/webMethods.js.txt"></script>
        <style>
			.listbox  { width: 100%; }
		</style>
	
		<script language="JavaScript">
		
		function isYear(numobj) 
		{	
		  	num = numobj.value.toString();
		
		  	if (num.length == 0)
		  	  	return false;
			var checker = 0;
			
			if (num.length <4)
				checker = 1;
			
		  	for (var i = 0; i < num.length; i++)
		    	{	if (num.substring(i, i+1) < "0" || num.substring(i, i+1) > "9")
		      		checker = 1;
		      		
			}
			
			if ( checker==1)
			
			{  alert("Year should be 4-digit numeric number!");
				
				numobj.focus();
				numobj.select();
			   
			   return false;
			 }
			
		  	return true;
		}
		
		
		function isHour(numobj) 
				{	
				  	num = numobj.value.toString();
				
				  	if (num.length == 0)
				  	  	return false;
					var checker = 0;
					
					for (var i = 0; i < num.length; i++)
						{	if (num.substring(i, i+1) < "0" || num.substring(i, i+1) > "9")
							    checker = 1;
							      		
						}
				
					if (num.length == 1)
						{	
							if (num < "0" || num >  "9")
							   		 checker = 1;
						}
						
					else
						{	
							if (num.substring(0, 1)>"2" )
							   		 checker = 1;
						
							if (num.substring(0, 1)== "2" && num.substring(1, 2)> "3" )
							   		 checker = 1;
						}
				   	
									
					if ( checker==1)
					
					{  alert("Hour should be numeric number, which is between 0 and 23!");
						
						numobj.focus();
						numobj.select();
					   
					   return false;
					 }
					
				  	return true;
				}

function isMin(numobj) 
				{	
				
								
				  	num = numobj.value.toString();
				
				  	if (num.length == 0)
				  	  	return false;
					var checker = 0;
					
					
					for (var i = 0; i < num.length; i++)
						{	if (num.substring(i, i+1) < "0" || num.substring(i, i+1) > "9")
							    checker = 1;
							      		
						}
				
			
					if (num.length == 1)
						{	
							if (num < "0" || num >  "9")
							   	 checker = 1;
						}
						
					else
						{	
							if (num.substring(0, 1)>"5" )
							   		 checker = 1;
						
						}
				   		      					   		      		
			
					
					if ( checker==1)
					
					{  alert("Minute should be numeric number, which is between 0 and 59!");
						
						numobj.focus();
						numobj.select();
					   
					   return false;
					 }
					
				  	return true;
				}



		
		</script>
	</head>

	<body class="main" onLoad="setNavigation('FAreport.dsp', '', 'foo');">
				
		<table width=100% >
			<tr>
				<td class="menusection-Settings" colspan=2>Create FA Report&nbsp;</td>
			</tr>

			<tr><td>&nbsp;</td></tr>
			
			<FORM name="reportnameform" METHOD="GET" ACTION="FAinvoke.dsp" target="" align="left">
			<input type="hidden" name="reportName" value=%reportName%>						
										
			<!--- Search Criteria --->
			<tr>
				<td>
					<table>
						<tr>
							<td class="heading" colspan="9">Set search criteria
							</td>
						</tr>
						
								
								<tr>
								<td class="oddrow">Report File Name:</td>
								<td class="oddrow-l"><input name="reportFileName"></td>
								</tr>
								
								<tr>
								<td class="evenrow">Report template:</td>
									<td class="evenrow-l">
									<select name="template"> 
									<option name="template" selected value="TXT">Text</option>
									<option name="template" value="HTML">HTML</option>
																		
								</select>
								</td>
								
								</tr>
								
								
								
								<tr>
									<td class="oddrow">Sender ID:</td>
									<td class="oddrow-l"><input name="senderID" ></td>
								</tr>
								<tr>	<td class="evenrow">Receiver ID:</td>
									<td class="evenrow-l"><input name="receiverID"> </td>
								</tr>
								
								<tr>	<td class="oddrow">From date:</td>											                               
									<td class="oddrow-l">year:<input name="docAfterYear" size=4 MAXLENGTH=4 onBlur="javascript:isYear(this);">
									month:<select name="docAfterMonth" size="1">
											<option name="docAfterMonth" value=""></option>
											<option name="docAfterMonth" value="01">January</option>											
											<option name="docAfterMonth" value="02">February</option>											
											<option name="docAfterMonth" value="03">March</option>											
											<option name="docAfterMonth" value="04">April</option>											
											<option name="docAfterMonth" value="05">May</option>											
											<option name="docAfterMonth" value="06">June</option>											
											<option name="docAfterMonth" value="07">July</option>											
											<option name="docAfterMonth" value="08">August</option>	
											<option name="docAfterMonth" value="09">September</option>
											<option name="docAfterMonth" value="10">October</option>
											<option name="docAfterMonth" value="11">November</option>
											<option name="docAfterMonth" value="12">December</option> 
															
										</select>
									day:<select name="docAfterDay" size="1">
											<option name="docAfterDay" value=""></option>
									              	<option name="docAfterDay" value="01">1</option>											
											<option name="docAfterDay" value="02">2</option>											
											<option name="docAfterDay" value="03">3</option>											
											<option name="docAfterDay" value="04">4</option>											
											<option name="docAfterDay" value="05">5</option>											
											<option name="docAfterDay" value="06">6</option>											
											<option name="docAfterDay" value="07">7</option>											
											<option name="docAfterDay" value="08">8</option>	
											<option name="docAfterDay" value="09">9</option>
											<option name="docAfterDay" value="10">10</option>
											<option name="docAfterDay" value="11">11</option>
											<option name="docAfterDay" value="12">12</option> 
											<option name="docAfterDay" value="13">13</option>											
											<option name="docAfterDay" value="14">14</option>											
											<option name="docAfterDay" value="15">15</option>											
											<option name="docAfterDay" value="16">16</option>											
											<option name="docAfterDay" value="17">17</option>											
											<option name="docAfterDay" value="18">18</option>											
											<option name="docAfterDay" value="19">19</option>											
											<option name="docAfterDay" value="20">20</option>	
											<option name="docAfterDay" value="21">21</option>
											<option name="docAfterDay" value="22">22</option>
											<option name="docAfterDay" value="23">23</option>
											<option name="docAfterDay" value="24">24</option> 
											<option name="docAfterDay" value="25">25</option>											
											<option name="docAfterDay" value="26">26</option>											
											<option name="docAfterDay" value="27">27</option>	
											<option name="docAfterDay" value="28">28</option>
											<option name="docAfterDay" value="29">29</option>
											<option name="docAfterDay" value="30">30</option>
											<option name="docAfterDay" value="31">31</option> 
																
										</select>
										hour:<input name="docAfterHour" size =2 MAXLENGTH =2 onBlur="javascript:isHour(this);">
										minute:<input name="docAfterMin" size =2 MAXLENGTH =2 onBlur="javascript:isMin(this);">
										
										</td>
								</tr>
								<tr>
									<td class="evenrow">To date:</td>
									<td class="evenrow-l">year:<input name="docBeforeYear" size =4 MAXLENGTH =4 onBlur="javascript:isNum(this.value);">
									month:<select name="docBeforeMonth" size="1">
									        <option name="docBeforeMonth" value=""></option>
										<option name="docBeforeMonth" value="01">January</option>											
										<option name="docBeforeMonth" value="02">February</option>											
										<option name="docBeforeMonth" value="03">March</option>											
										<option name="docBeforeMonth" value="04">April</option>											
										<option name="docBeforeMonth" value="05">May</option>											
										<option name="docBeforeMonth" value="06">June</option>											
										<option name="docBeforeMonth" value="07">July</option>											
										<option name="docBeforeMonth" value="08">August</option>	
										<option name="docBeforeMonth" value="09">September</option>
										<option name="docBeforeMonth" value="10">October</option>
										<option name="docBeforeMonth" value="11">November</option>
										<option name="docBeforeMonth" value="12">December</option> 
									</select>
									day:<select name="docBeforeDay" size="1">
										<option name="docBeforeDay" value=""></option>
										<option name="docBeforeDay" value="01">1</option>											
										<option name="docBeforeDay" value="02">2</option>											
										<option name="docBeforeDay" value="03">3</option>											
										<option name="docBeforeDay" value="04">4</option>											
										<option name="docBeforeDay" value="05">5</option>											
										<option name="docBeforeDay" value="06">6</option>											
										<option name="docBeforeDay" value="07">7</option>											
										<option name="docBeforeDay" value="08">8</option>	
										<option name="docBeforeDay" value="09">9</option>
										<option name="docBeforeDay" value="10">10</option>
										<option name="docBeforeDay" value="11">11</option>
										<option name="docBeforeDay" value="12">12</option> 
										<option name="docBeforeDay" value="13">13</option>											
										<option name="docBeforeDay" value="14">14</option>											
										<option name="docBeforeDay" value="15">15</option>											
										<option name="docBeforeDay" value="16">16</option>											
										<option name="docBeforeDay" value="17">17</option>											
										<option name="docBeforeDay" value="18">18</option>											
										<option name="docBeforeDay" value="19">19</option>											
										<option name="docBeforeDay" value="20">20</option>	
										<option name="docBeforeDay" value="21">21</option>
										<option name="docBeforeDay" value="22">22</option>
										<option name="docBeforeDay" value="23">23</option>
										<option name="docBeforeDay" value="24">24</option> 
										<option name="docBeforeDay" value="25">25</option>											
										<option name="docBeforeDay" value="26">26</option>											
										<option name="docBeforeDay" value="27">27</option>	
										<option name="docBeforeDay" value="28">28</option>
										<option name="docBeforeDay" value="29">29</option>
										<option name="docBeforeDay" value="30">30</option>
										<option name="docBeforeDay" value="31">31</option> 
										</select>
									hour:<input name="docBeforeHour" size =2 MAXLENGTH =2 onBlur="javascript:isHour(this);">
									minute:<input name="docBeforeMin" size =2 MAXLENGTH =2 onBlur="javascript:isMin(this);">
																				
									
									</td>
								</tr>
								<tr>
									<td class="evenrow">FA from date:</td>
									<td class="evenrow-l">year:<input name="FAAfterYear" size = 4 MAXLENGTH =4 onBlur="javascript:isNum(this.value);">
									month:<select name="FAAfterMonth" size="1">
										<option name="FAAfterMonth" value=""></option>
										<option name="FAAfterMonth" value="01">January</option>											
										<option name="FAAfterMonth" value="02">February</option>											
										<option name="FAAfterMonth" value="03">March</option>											
										<option name="FAAfterMonth" value="04">April</option>											
										<option name="FAAfterMonth" value="05">May</option>											
										<option name="FAAfterMonth" value="06">June</option>											
										<option name="FAAfterMonth" value="07">July</option>											
										<option name="FAAfterMonth" value="08">August</option>	
										<option name="FAAfterMonth" value="09">September</option>
										<option name="FAAfterMonth" value="10">October</option>
										<option name="FAAfterMonth" value="11">November</option>
										<option name="FAAfterMonth" value="12">December</option> 
										</select>
										day:<select name="FAAfterDay" size="1">
										<option name="FAAfterDay" value=""></option>	
										<option name="FAAfterDay" value="01">1</option>											
										<option name="FAAfterDay" value="02">2</option>											
										<option name="FAAfterDay" value="03">3</option>											
										<option name="FAAfterDay" value="04">4</option>											
										<option name="FAAfterDay" value="05">5</option>											
										<option name="FAAfterDay" value="06">6</option>											
										<option name="FAAfterDay" value="07">7</option>											
										<option name="FAAfterDay" value="08">8</option>	
										<option name="FAAfterDay" value="09">9</option>
										<option name="FAAfterDay" value="10">10</option>
										<option name="FAAfterDay" value="11">11</option>
										<option name="FAAfterDay" value="12">12</option> 
										<option name="FAAfterDay" value="13">13</option>											
										<option name="FAAfterDay" value="14">14</option>											
										<option name="FAAfterDay" value="15">15</option>											
										<option name="FAAfterDay" value="16">16</option>											
										<option name="FAAfterDay" value="17">17</option>											
										<option name="FAAfterDay" value="18">18</option>											
										<option name="FAAfterDay" value="19">19</option>											
										<option name="FAAfterDay" value="20">20</option>	
										<option name="FAAfterDay" value="21">21</option>
										<option name="FAAfterDay" value="22">22</option>
										<option name="FAAfterDay" value="23">23</option>
										<option name="FAAfterDay" value="24">24</option> 
										<option name="FAAfterDay" value="25">25</option>											
										<option name="FAAfterDay" value="26">26</option>											
										<option name="FAAfterDay" value="27">27</option>	
										<option name="FAAfterDay" value="28">28</option>
										<option name="FAAfterDay" value="29">29</option>
										<option name="FAAfterDay" value="30">30</option>
										<option name="FAAfterDay" value="31">31</option> 
										
										</select>
									hour:<input name="FAAfterHour" size =2 MAXLENGTH =2 onBlur="javascript:isHour(this);">
									minute:<input name="FAAfterMin" size =2 MAXLENGTH =2 onBlur="javascript:isMin(this);">
										
									
									</td>
								</tr>
								
								<tr>
									<td class="oddrow">FA to date:</td>
									<td class="oddrow-l">Year:<input name="FABeforeYear" size= 4 MAXLENGTH =4 onBlur="javascript:isNum(this.value);">
									
									month:<select name="FABeforeMonth" size="1">
										<option name="FABeforeMonth" value=""></option>
										<option name="FABeforeMonth" value="01">January</option>											
										<option name="FABeforeMonth" value="02">February</option>											
										<option name="FABeforeMonth" value="03">March</option>											
										<option name="FABeforeMonth" value="04">April</option>											
										<option name="FABeforeMonth" value="05">May</option>											
										<option name="FABeforeMonth" value="06">June</option>											
										<option name="FABeforeMonth" value="07">July</option>											
										<option name="FABeforeMonth" value="08">August</option>	
										<option name="FABeforeMonth" value="09">September</option>
										<option name="FABeforeMonth" value="10">October</option>
										<option name="FABeforeMonth" value="11">November</option>
										<option name="FABeforeMonth" value="12">December</option> 
										</select>
									day:<select name="FABeforeDay" size="1">
										<option name="FABeforeDay" value=""></option>
										<option name="FABeforeDay" value="01">1</option>											
										<option name="FABeforeDay" value="02">2</option>											
										<option name="FABeforeDay" value="03">3</option>											
										<option name="FABeforeDay" value="04">4</option>											
										<option name="FABeforeDay" value="05">5</option>											
										<option name="FABeforeDay" value="06">6</option>											
										<option name="FABeforeDay" value="07">7</option>											
										<option name="FABeforeDay" value="08">8</option>	
										<option name="FABeforeDay" value="09">9</option>
										<option name="FABeforeDay" value="10">10</option>
										<option name="FABeforeDay" value="11">11</option>
										<option name="FABeforeDay" value="12">12</option> 
										<option name="FABeforeDay" value="13">13</option>											
										<option name="FABeforeDay" value="14">14</option>											
										<option name="FABeforeDay" value="15">15</option>											
										<option name="FABeforeDay" value="16">16</option>											
										<option name="FABeforeDay" value="17">17</option>											
										<option name="FABeforeDay" value="18">18</option>											
										<option name="FABeforeDay" value="19">19</option>											
										<option name="FABeforeDay" value="20">20</option>	
										<option name="FABeforeDay" value="21">21</option>
										<option name="FABeforeDay" value="22">22</option>
										<option name="FABeforeDay" value="23">23</option>
										<option name="FABeforeDay" value="24">24</option> 
										<option name="FABeforeDay" value="25">25</option>											
										<option name="FABeforeDay" value="26">26</option>											
										<option name="FABeforeDay" value="27">27</option>	
										<option name="FABeforeDay" value="28">28</option>
										<option name="FABeforeDay" value="29">29</option>
										<option name="FABeforeDay" value="30">30</option>
										<option name="FABeforeDay" value="31">31</option> 
										</select>
										hour:<input name="FABeforeHour" size =2 MAXLENGTH =2 onBlur="javascript:isHour(this);"> 
										minute:<input name="FABeforeMin" size =2 MAXLENGTH =2 onBlur="javascript:isMin(this);">
										
									
									</td>
									
								</tr>


								<tr>
									<td class="oddrow">Group type:</td>
									<td class="oddrow-l"><input name="groupType"></td>
								</tr>
								<tr>	<td class="evenrow">Version:</td>
									<td class="evenrow-l"><input name="version"></td>
								</tr>
							
								
								<tr>
									<td class="oddrow">Status:</td>
									<td class="oddrow-l">
										<select name="status" size="1">
											<option name="status" value=""></option>
											<option name="status" value="100">None</option>	
											<option name="status" value="110">Disabled</option>
											<option name="status" value="120">Duplicate</option>											
											<option name="status" value="130">Error</option>											
											<option name="status" value="140">Duplicate FA/Errors</option>											
											<option name="status" value="150">Accepted</option>											
											<option name="status" value="160">Accepted with Errors</option>											
											<option name="status" value="170">Partially Accepted</option>											
											<option name="status" value="180">Rejected</option>	
											<option name="status" value="190">FA Error</option>
											<option name="status" value="200">Interchange Received</option>
															
										</select>
									</td>	
										
								</tr>
								
								<tr>
									<td class="evenrow">Sort by:</td>
							
							<td class="evenrow-l">
									<select name="orderBy" size = 5 MULTIPLE>
									<option name="orderBy" value="3">Sender</option>
									<option name="orderBy" value="4">Receiver</option>
									<option name="orderBy" value="2" SELECTED>Document Type</option>
									<option name="orderBy" value="6">Group ID</option>
									<option name="orderBy" value="8">Group Type</option>
									<option name="orderBy" value="9">Group Version</option>
									<option name="orderBy" value="10">Document Time Stamp</option>
									<option name="orderBy" value="11">FA Time Stamp</option>
									<option name="orderBy" value="12">FA Status</option>																							
									</select>
						
							</td>											
																		
							</tr>
								
							<tr>

								
							</tr>
							<tr>
							                      <td class="action" colspan="2">
							                        <input type="submit" value="Generate FA Report">
							                      </td>
                   					 </tr>
                  
						</table>
					</form>
					
					
								
					
				</td>
			</tr>
		</table>
	
	</body>
</html>
