<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
    xmlns="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:ctu="http://example.org/conformance-targets-utilities/xslt2/"
    version="2.0">

  <!-- 
    Sample use:
       <xsl:sequence select="
         ctu:get-effective-conformance-targets(/)
       "/>
    This function yields the effective conformance targets value for XML document. 
  -->
  <function name="ctu:get-effective-conformance-targets" as="xs:anyURI*">
    <param name="node" as="node()"/>
    <sequence select="for $string in tokenize(normalize-space(
      (root($node)//@*[
         namespace-uri() = 'http://release.niem.gov/niem/conformanceTargets/3.0/'
         and local-name() = 'conformanceTargets'
      ])[1]), ' ') return xs:anyURI($string)"/>
  </function>

  <!--
      Sample use:
          <xsl:if test="
            ctu:conformance-targets-contains(
              ctu:get-effective-conformance-targets(/), 
              xs:anyURI('http://example.org/specification/version/#ConformanceTarget')
            )">
      This function yields true if and only if the list of conformance targets contains the given iri.
  -->
  <function name="ctu:conformance-targets-contains" as="xs:boolean">
    <param name="conformance-targets" as="xs:anyURI*"/>
    <param name="iri" as="xs:anyURI"/>

    <sequence select="$iri = $conformance-targets"/>
  </function>

</stylesheet>
