<?xml version="1.0" encoding="UTF-8"?>
<schema 
   queryBinding="xslt2"
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns="http://purl.oclc.org/dsdl/schematron">

  <title>Rules about the NIEM Conformance Targets Attribute Specification</title>

  <ns prefix="xs" uri="http://www.w3.org/2001/XMLSchema"/>
  <ns prefix="xsl" uri="http://www.w3.org/1999/XSL/Transform"/>

  <pattern>
    <rule context="doc:rule">
      <assert test="empty(@applicability)"
              >A doc:rule must not own @applicability.</assert>
    </rule>
  </pattern>

</schema>
<!-- 
  Local Variables:
  mode: sgml
  indent-tabs-mode: nil
  fill-column: 9999
  End:
-->
