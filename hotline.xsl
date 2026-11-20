<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:key name="cat" match="category" use="id"/>
  <xsl:template match="/price">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>Прайс-лист <xsl:value-of select="firmName"/></title>
        <style>
          body { font-family: Arial, sans-serif; margin: 24px; color: #222; }
          h1 { margin-bottom: 4px; }
          table { border-collapse: collapse; width: 100%; margin-top: 16px; }
          th, td { border: 1px solid #bbb; padding: 6px 8px; font-size: 14px; text-align: left; }
          th { background: #e8eef7; }
          .out { color: #b00020; }
          .order { color: #a66a00; }
          .in { color: #1b7f3a; }
        </style>
      </head>
      <body>
        <h1>Прайс-лист магазину <xsl:value-of select="firmName"/></h1>
        <div>Дата формування: <xsl:value-of select="date"/> · firmId: <xsl:value-of select="firmId"/> · курс USD: <xsl:value-of select="rate"/></div>
        <table>
          <tr><th>id</th><th>Категорія</th><th>Код</th><th>Виробник</th><th>Назва</th><th>Ціна, грн</th><th>Ціна, $</th><th>Наявність</th><th>Гарантія, міс.</th></tr>
          <xsl:for-each select="items/item">
            <xsl:sort select="priceRUAH" data-type="number" order="descending"/>
            <tr>
              <td><xsl:value-of select="id"/></td>
              <td><xsl:value-of select="key('cat', categoryId)/name"/></td>
              <td><xsl:value-of select="code"/></td>
              <td><xsl:value-of select="vendor"/></td>
              <td><a href="{url}"><xsl:value-of select="name"/></a></td>
              <td><xsl:value-of select="priceRUAH"/></td>
              <td><xsl:value-of select="priceRUSD"/></td>
              <td>
                <xsl:attribute name="class">
                  <xsl:choose>
                    <xsl:when test="stock='В наявності'">in</xsl:when>
                    <xsl:when test="stock='Під замовлення'">order</xsl:when>
                    <xsl:otherwise>out</xsl:otherwise>
                  </xsl:choose>
                </xsl:attribute>
                <xsl:value-of select="stock"/>
              </td>
              <td><xsl:value-of select="guarantee"/></td>
            </tr>
          </xsl:for-each>
        </table>
        <p>Усього товарів: <xsl:value-of select="count(items/item)"/></p>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
