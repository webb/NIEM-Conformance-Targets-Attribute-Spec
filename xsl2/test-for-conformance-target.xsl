<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
    version="2.0"
    xmlns:ctu="http://example.org/conformance-targets-utilities/xslt2/"
    xmlns="http://www.w3.org/1999/XSL/Transform">

  <import href="conformance-targets-utilities.xsl"/>

  <param name="iri" required="yes"/>

  <output method="text"/>

  <template match="/">
    <value-of select="ctu:conformance-targets-contains(
        ctu:get-effective-conformance-targets(.), $iri)"/>
    <text>&#10;</text>
  </template>

</stylesheet>
