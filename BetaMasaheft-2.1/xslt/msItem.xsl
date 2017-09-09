<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:t="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:template match="t:msItem[parent::t:msContents]">
        <xsl:variable name="trimid" select="concat(replace(@xml:id, '\.', '-'), 'N', position())"/>
        <div class="accordion-group">
            <div class="accordion-heading">
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#contents" href="#item{$trimid}">
                    <button type="button" class="btn btn-secondary" id="{@xml:id}"> 
                        <xsl:apply-templates select="./t:title" mode="nolink"/> Item <xsl:value-of select="@xml:id"/>
                        <xsl:if test="child::t:msItem">
                            <span class="badge">
                                <xsl:value-of select="count(child::t:msItem)"/>
                            </span>
                        </xsl:if>
                    </button>
                </a>
            </div>
            <div id="item{$trimid}" class="accordion-body collapse">
                <div class="col-md-12 accordion-inner">
                    <hr class="msItems" align="left"/>
                    <xsl:choose>
                        <xsl:when test="child::t:msItem">
                            <xsl:apply-templates select="node() except t:msItem"/>
                            <div class="accordion" id="accordion{$trimid}">
                                <xsl:apply-templates select="t:msItem"/>
                            </div>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
            </div>
        </div>
        <hr/>
    </xsl:template>
    <xsl:template match="t:msItem">
        <xsl:variable name="trimid" select="replace(@xml:id, '\.', '-')"/>
        <div class="accordion-group msItem">
            <div class="accordion-heading">
                <a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion{replace(./parent::t:msItem[1]/@xml:id, '.','')}" href="#item{$trimid}">
                    <button type="button" class="btn btn-secondary" id="{@xml:id}"> 
                        <xsl:apply-templates select="./t:title" mode="nolink"/> Item 
                        <xsl:value-of select="@xml:id"/>
                        <xsl:if test="child::t:msItem">
                            <span class="badge">
                                <xsl:value-of select="count(child::t:msItem)"/>
                            </span>
                        </xsl:if>
                    </button>
                </a>
            </div>
            <div id="item{$trimid}" class="accordion-body collapse">
                <div class="col-md-12 accordion-inner">
                    <hr class="msItems" align="left"/>
                    <xsl:choose>
                        <xsl:when test="child::t:msItem">
                            <xsl:apply-templates select="node() except t:msItem"/>
                            <div class="accordion" id="accordion{$trimid}">
                                <xsl:apply-templates select="t:msItem"/>
                            </div>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:apply-templates/>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>