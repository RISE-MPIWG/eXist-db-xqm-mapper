<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:template match="t:supportDesc">
        <xsl:if test="parent::t:objectDesc/@form">
            <h3>Form of support <xsl:if test="./ancestor::t:msPart">
                    <xsl:variable name="currentMsPart">
                        <a href="{./ancestor::t:msPart/@xml:id}">
                            <xsl:value-of select="substring-after(./ancestor::t:msPart/@xml:id, 'p')"/>
                        </a>
                    </xsl:variable> of codicological unit
            <xsl:value-of select="$currentMsPart"/>
                </xsl:if>
            </h3>
            <p>
                <xsl:if test=".//t:material/@key">
                    <xsl:for-each select=".//t:material">
                    <xsl:value-of select="concat(upper-case(substring(@key,1,1)),                 substring(@key, 2),        ' ' )"/>
                <xsl:apply-templates/>
                    </xsl:for-each>
                   
                </xsl:if>
                <xsl:text> </xsl:text>
                <xsl:value-of select="parent::t:objectDesc/@form"/>
            </p>
        </xsl:if>
        <xsl:apply-templates/>
    </xsl:template>
</xsl:stylesheet>