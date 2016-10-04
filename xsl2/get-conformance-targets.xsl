<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
    version="2.0"
    xmlns:ctu="http://example.org/conformance-targets-utilities/xslt2/"
    xmlns="http://www.w3.org/1999/XSL/Transform">

  <import href="conformance-targets-utilities.xsl"/>

  <output method="text"/>

  <template match="/">
    <for-each select="ctu:get-effective-conformance-targets(.)">
      <value-of select="."/>
      <text>&#10;</text>
    </for-each>
  </template>

</stylesheet>
