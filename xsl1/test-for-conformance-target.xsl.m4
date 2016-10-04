<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
    version="1.0"
    xmlns:ctu="CTU_XSL1_NAMESPACE"
    xmlns="http://www.w3.org/1999/XSL/Transform">

  <import href="conformance-targets-utilities.xsl"/>

  <param name="iri"/>

  <output method="text"/>

  <template match="/">
    <call-template name="ctu:conformance-targets-contains">
      <with-param name="conformance-targets">
        <call-template name="ctu:get-effective-conformance-targets"/>
      </with-param>
      <with-param name="iri" select="$iri"/>
    </call-template>
    <text>&#10;</text>
  </template>

</stylesheet>
m4_dnl Local Variables:
m4_dnl mode: sgml
m4_dnl indent-tabs-mode: nil
m4_dnl fill-column: 9999
m4_dnl End:
