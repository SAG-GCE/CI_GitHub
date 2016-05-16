<html>
<head>
  <title>%value text% - %value $host% - webMethods Integration Server</title>
  <link rel="stylesheet" type="text/css" href="layout.css">
  <link rel="icon" HREF="/WmRoot/favicon.ico" />
</head>
<body>
  <div><iframe class="top" src="top.dsp?adapter=%value -urlencode adapter%&text=%value -urlencode text%%ifvar help%&help=%value -urlencode help%%endif%"></iframe></div>
  <div class="bottom">
    <iframe class="menuframe" name="menu" src="adapter-menu.dsp?tabset=%value -urlencode adapter%" scrolling="yes" seamless="seamless"></iframe>
    %invoke wm.server.ui:isValidAdapterURL%
        %ifvar result equals('true')%
            <iframe class="contentframe" name="body" src="%value url%"></iframe>
        %else%
            <iframe class="contentframe" name="body" src="error.dsp"></iframe>
        %endif%
    %endinvoke%
  </div>
</body>
</html>
