<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
  <html>
    <head>
      <style>
      
      </style>
    </head>
    <body>
      <table border="1">
      <xsl:call-template name="pintarTabla">
        <xsl:with-param name="ejeX" select="0"/>
        <xsl:with-param name="ejeY" select="8"/>
      </xsl:call-template>
      </table>
    </body>
  </html>
</xsl:template>



<xsl:template name="pintarTabla">
  <xsl:param name="ejeX"/>
  <xsl:param name="ejeY"/>
  
<!-- Cabeceras -->
  <xsl:if test="$ejeY=8">
    <tr>
      <th>hora\dia</th>
      <th>lunes</th>
      <th>martes</th>
      <th>miercoles</th>
      <th>jueves</th>
      <th>viernes</th>
    </tr>
    <!-- Siguiente fila -->
    <xsl:call-template name="pintarTabla">
      <xsl:with-param name="ejeX" select="0"/>
      <xsl:with-param name="ejeY" select="$ejeY+1"/>
    </xsl:call-template>
  </xsl:if>
  
<!-- Cuerpo de la tabla -->
  <xsl:if test="$ejeY&gt;8 and $ejeY&lt;20">
    <!-- Escribe la cabecera de la hora segun la fila en la que este y pasa a 
    la siguiente celda-->
    <xsl:if test="$ejeX=0">
      <tr>
        <th>De <xsl:value-of select="$ejeY"/> 
          a <xsl:value-of select="$ejeY + 1"/>
        </th>
        <xsl:call-template name="pintarTabla">
          <xsl:with-param name="ejeX" select="$ejeX+1"/>
          <xsl:with-param name="ejeY" select="$ejeY"/>
        </xsl:call-template>
      </tr>
    </xsl:if>
    
    <!-- Pinta una celda, comprueba si ese dia a esa hora hay tarea y pasa a 
    la siguiente celda -->
    <xsl:if test="$ejeX&gt;0 and $ejeX&lt;6">
      <td>
        <xsl:call-template name="hayTarea">
          <xsl:with-param name="XDia" select="$ejeX"/>
          <xsl:with-param name="YHora" select="$ejeY"/>
        </xsl:call-template>
      </td>
      <xsl:call-template name="pintarTabla">
        <xsl:with-param name="ejeX" select="$ejeX+1"/>
        <xsl:with-param name="ejeY" select="$ejeY"/>
      </xsl:call-template>
    </xsl:if>
    
    <!-- Siguiente fila -->
    <xsl:if test="$ejeX=6">
      <xsl:call-template name="pintarTabla">
        <xsl:with-param name="ejeX" select="0"/>
        <xsl:with-param name="ejeY" select="$ejeY+1"/>
      </xsl:call-template>
    </xsl:if>
    
  </xsl:if>
  
<!-- Pie de tabla con el total de tareas -->
  <xsl:if test="$ejeY=20">
    <!-- Escribe la cabecera -->
    <xsl:if test="$ejeX=0">
      <tr>
        <th>total tareas</th>
        <xsl:call-template name="pintarTabla">
          <xsl:with-param name="ejeX" select="$ejeX+1"/>
          <xsl:with-param name="ejeY" select="$ejeY"/>
        </xsl:call-template>
      </tr>
    </xsl:if>
    
    <!-- Por cada dia de la semana, cuenta el total de tareas y pasa a la 
    siguiente celda -->
    <xsl:if test="$ejeX&gt;0 and $ejeX&lt;6">
      <td>
        <xsl:call-template name="contarTareas">
          <xsl:with-param name="XDia" select="$ejeX"/>
        </xsl:call-template>
      </td>
      <xsl:call-template name="pintarTabla">
        <xsl:with-param name="ejeX" select="$ejeX+1"/>
        <xsl:with-param name="ejeY" select="$ejeY"/>
      </xsl:call-template>
    </xsl:if>
    
  </xsl:if>
  
</xsl:template>

<!-- Comprueba si hay tarea dado un dia y hora determinada y escribe su nombre -->
<xsl:template name="hayTarea">
  <xsl:param name="XDia"/>
  <xsl:param name="YHora"/>
  <xsl:value-of select="//dia[numdia=$XDia]/tarea[hora-ini&lt;$YHora+1 and hora-fin&gt;$YHora]/nombre"/>
</xsl:template>

<!-- Cuenta el total de tareas de un dia determinado -->
<xsl:template name="contarTareas">
  <xsl:param name="XDia"/>
  <xsl:value-of select="count(//dia[numdia=$XDia]/tarea)"/>
</xsl:template>


</xsl:stylesheet>