<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0">
    <xsl:output method="text"/>
    <xsl:template match="/">
        {
        "Company":[
        <xsl:for-each select="laptops/company">
            <xsl:sort select="company_name"/>
            {
            "brand": "<xsl:value-of select="company_name"/>",
            "model":"<xsl:value-of select="model"/>"
            }<xsl:if test="position() !=last()">,</xsl:if>
        </xsl:for-each>
        ],
        "Prices":[
        <xsl:for-each select="laptops/company/detail/prices/price">
            <xsl:if test="position() mod 2 = 1">
                {
                "normal Price": "<xsl:value-of select="value"/> <xsl:value-of select="currency"/>"
                }<xsl:if test="position() !=last()">,</xsl:if>
            </xsl:if>
            <xsl:if test="position() mod 2 = 0">
                {
                "discounted Price": "<xsl:value-of select="discounted_value"/> <xsl:value-of select="currency"/>",
                "discount": "<xsl:value-of select="discount"/>%"
                }<xsl:if test="position() !=last()">,</xsl:if>
            </xsl:if>
        </xsl:for-each>
        ],
        "discount type":[
        <xsl:for-each select="laptops/company/detail/prices/price">
            <xsl:sort select="discount" order="ascending"/>
            <xsl:choose>
                <xsl:when test="discount>10">
                    <xsl:if test="@type = 'discounted'">
                        {
                        "student discount": "<xsl:value-of select="discount"/>",
                        "discounted value": "<xsl:value-of select="discounted_value"/>"
                        }<xsl:if test="position() !=last()">,</xsl:if>
                    </xsl:if>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:if test="@type = 'discounted'">
                        {
                        "normal discount": "<xsl:value-of select="discount"/>",
                        "discounted value": "<xsl:value-of select="discounted_value"/>"
                        }<xsl:if test="position() !=last()">,</xsl:if>
                    </xsl:if>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
        ]
        }
    </xsl:template>
</xsl:stylesheet>