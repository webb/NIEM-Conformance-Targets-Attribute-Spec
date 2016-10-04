<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
    version="2.0"
    xmlns:ctu="CTU_XSL2_NAMESPACE"
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
m4_dnl Local Variables:
m4_dnl mode: sgml
m4_dnl indent-tabs-mode: nil
m4_dnl fill-column: 9999
m4_dnl End:
