<?xml version="1.0" encoding="UTF-8"?>
<stylesheet 
    version="1.0"
    xmlns:ctu="http://example.org/conformance-targets-utilities/xslt1/"
    xmlns:this="http://example.org/get-conformance-targets/xslt1/1/"
    xmlns="http://www.w3.org/1999/XSL/Transform">

  <import href="conformance-targets-utilities.xsl"/>

  <output method="text"/>

  <template match="/">
    <call-template name="this:print-list">
      <with-param name="list">
        <call-template name="ctu:get-effective-conformance-targets"/>
      </with-param>
    </call-template>
  </template>

  <template name="this:print-list">
    <param name="list"/>
    <choose>
      <when test="string-length(normalize-space($list)) = 0"/>
      <otherwise>
        <call-template name="ctu:list-get-first">
          <with-param name="list" select="$list"/>
        </call-template>
        <text>&#10;</text>
        <call-template name="this:print-list">
          <with-param name="list">
            <call-template name="ctu:list-get-rest">
              <with-param name="list" select="$list"/>
            </call-template>
          </with-param>
        </call-template>
      </otherwise>
    </choose>
  </template>

</stylesheet>
