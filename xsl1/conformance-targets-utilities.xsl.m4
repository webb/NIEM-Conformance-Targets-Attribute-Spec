<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
    xmlns="http://www.w3.org/1999/XSL/Transform" 
    xmlns:ctu="CTU_XSL1_NAMESPACE"
    version="1.0">

  <!-- 
    Sample use:
      <xsl:call-template name="ctu:get-effective-conformance-targets"/>
    This template yields the effective conformance targets value for the current XML document.
  -->
  <template name="ctu:get-effective-conformance-targets">
    <value-of select="(//@*[
      namespace-uri() = 'CT_NAMESPACE'
      and local-name() = 'conformanceTargets'
    ])[1]"/>
  </template>

  <!--
    Sample use:

      <xsl:call-template name="ctu:conformance-targets-contains">
        <with-param name="conformance-targets" 
                    select="/xs:schema/@ct:conformanceTargets"/>
        <with-param name="iri"
         >http://example.org/specification/version/#ConformanceTarget</with-param>
      </xsl:call-template>

      Yields 'true' if the iri appears in the list of conformance targets.
      Yields 'false' otherwise.
  -->
  <template name="ctu:conformance-targets-contains">
    <param name="conformance-targets"/>
    <param name="iri"/>

    <call-template name="ctu:list-contains">
      <with-param name="list" select="$conformance-targets"/>
      <with-param name="member" select="$iri"/>
    </call-template>
  </template>

  <!--
      list operations: 
        list is empty: string-length(normalize-space($list)) = 0
  -->

  <!-- Yields the first member of a list. -->
  <template name="ctu:list-get-first">
    <param name="list"/>
    <param name="ns-list" select="normalize-space($list)"/>
    <choose>
      <when test="string-length($ns-list) = 0">
        <message terminate="yes">ERROR in template <!--
        -->{CTU_XSL1_NAMESPACE}get-first-from-list: <!--
        -->You can't get the first entry of an empty list.</message>
      </when>
      <when test="contains($ns-list, ' ')">
        <value-of select="substring-before($ns-list, ' ')"/>
      </when>
      <otherwise>
        <value-of select="$ns-list"/>
      </otherwise>
    </choose>
  </template>

  <!-- Yields evertyhing after the first member of a list. -->
  <template name="ctu:list-get-rest">
    <param name="list"/>
    <param name="ns-list" select="normalize-space($list)"/>
    <choose>
      <when test="string-length($ns-list) = 0">
        <message terminate="yes">ERROR in template <!--
        -->{CTU_XSL1_NAMESPACE}get-first-from-list: <!--
        -->You can't get the rest of an empty list.</message>
      </when>
      <when test="contains($ns-list, ' ')">
        <value-of select="substring-after($ns-list, ' ')"/>
      </when>
      <!-- otherwise yield nothing -->
    </choose>
  </template>

  <!-- Yields true iff the list contains the member. -->
  <template name="ctu:list-contains">
    <param name="list"/>
    <param name="member"/>
    <choose>
      <when test="string-length(normalize-space($list)) = 0">
        <value-of select="false()"/>
      </when>
      <otherwise>
        <variable name="first">
          <call-template name="ctu:list-get-first">
            <with-param name="list" select="$list"/>
          </call-template>
        </variable>
        <choose>
          <when test="$first = $member">
            <value-of select="true()"/>
          </when>
          <otherwise>
            <variable name="rest">
              <call-template name="ctu:list-get-rest">
                <with-param name="list" select="$list"/>
              </call-template>
            </variable>
            <choose>
              <when test="string-length($rest) = 0">
                <value-of select="false()"/>
              </when>
              <otherwise>
                <call-template name="ctu:list-contains">
                  <with-param name="list" select="$rest"/>
                  <with-param name="member" select="$member"/>
                </call-template>
              </otherwise>
            </choose>
          </otherwise>
        </choose>
      </otherwise>
    </choose>
  </template>

</stylesheet>
m4_dnl Local Variables:
m4_dnl mode: sgml
m4_dnl indent-tabs-mode: nil
m4_dnl fill-column: 9999
m4_dnl End:
