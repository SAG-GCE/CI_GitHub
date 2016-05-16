<html>

<head>
<meta http-equiv="Content-Type" content='text/html; charset=UTF-8'>
<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
<title>Sample Overview</title>
<base target="_self">
<SCRIPT SRC="/WmRoot/webMethods.js.txt"></SCRIPT>
</head>

<body onLoad="setNavigation('index.dsp', '', 'foo');">

<div class="position">
  <table WIDTH="100%">
    <tr>
      <td class="menusection-Solutions" colspan="2">Sample Overview</td>
    </tr>
    <tr></tr>
    <tr>
      <td class="evenrow-l">
        <p><br>
        This sample shows an example of how to use the webMethods Modeler to create business processes that manipulate EDI documents.
        <p>In this sample, an XML Purchase Order document is posted to the Trading Network. This document triggers a business process. The process model that defines the business process converts the document into an EDI 850 purchase order and transmits the EDI 850 purchase order to the appropriate trading partner.</p>
        <p>The following picture illustrates sender-side EDI business process:</p>
        <p><img border="0" src="CreateConversation.jpg" width="720" height="540"></p>
        <p>In the first level (transaction set level) of business process, the sender forms an 850 from an XML document, sends the 850 and wait for an 855 in response. The receiver receives the 850 and sends the 855 back to the sender, which the sender translates and sends to a back-end system.</p>
        <p>In the second level (functional acknowledgement level) of business process, the sender waits to receive a 997 in response to the group. The receiver receives the group and generates a 997 in response and sends back to the sender.</p>
        <p>The sample provides you the opportunity to be the "back-end" system of your trading network. You can make changes to the XML document that starts the business process and submit the XML document to the Trading Network. You can then use webMethods Monitor to track the business processes.</p>
        <p>The sample is configured to run on a single server. Therefore, you will see both the sender and receiver side processes. A total of four processes are created each time you run the sample.</p>
        <p>
        	%invoke wm.b2b.editn.sample.util:checkSetup%
        		%ifvar setupProperly equals('true')%
        			<a HREF="send.dsp">Run</a> the example 
	        	%else%
   		     		<a HREF="setup.dsp">Setup</a> the example 
       	 	%endif%
        	%endinvoke%
        </p>
		</td>
    </tr>
  </table>
</div>

</body>

</html>
