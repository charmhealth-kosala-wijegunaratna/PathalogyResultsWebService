<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt">
  <xsl:output method="html" encoding="windows-1252"/>

  <!--
  
  Author: Kosala W
  CopyRights : Charmhealth
  Date: 25/03/2013
  
  Revision History:
  
  Version Auth DefectID Date          Summary
  v1.0    KW            25/03/2013    Created for LifeHouse using codeprojects HL7 renderer http://www.codeproject.com/Articles/29670/Converting-HL7-to-XML
  
  -->
    
  <xsl:template match="/">
      <html>
        <head>
          <style>
            BODY                            { font-family:Arial; font-size:6pt;color:#000080}

            table                           { border-collapse: collapse; empty-cells: hide;}
            resultheader                    {  width:800pt;border:0px solid #9F9F9F; }
            table.noBorder                  {  width:400pt;border:0px solid #9F9F9F; }
            table.drugList                  { width:800pt;border:1px solid #000000; }

            td                              { border: 1px solid solid #9F9F9F; font-size: 8pt ; }
            td.left                         { font-size:10pt;color:#ff9966;align="left" }
            td.special                      { border: 0px; }
            td.special1                     { border-top:1px solid #000000; border-bottom:1px solid #000000; border-right:1px solid #000000; border-left:1px solid #000000 }
            td.special2                     { border-top:1px solid #000000; border-bottom:1px solid #000000; border-right:0px solid #000000; border-left:1px solid #000000; font-size:8pt; font-family:"Arial" }
            td.special3                     { border-top:0px solid #000000; border-bottom:1px solid #000000; border-right:1px solid #000000; border-left:1px solid #000000 }
            td.special5                     { border-top:1px solid #000000; border-bottom:1px solid #000000; border-right:0px solid #000000; border-left:1px solid #000000; color:black; font-size:7pt; font-family:"Arial Narrow" }

            .special6                       { font-size:7pt; font-family:"Arial Narrow"; color:black }
            td.special7                     { border-top:0px solid #000000; border-bottom:1px solid #000000; border-right:0px solid #000000; border-left:0px solid #000000 }

            td.MultiMiddle2                 { border-top:1px solid #000000; border-bottom:0px solid #000000; border-right:0px solid #000000; border-left:1px solid #000000; font-size:8pt; font-family:"Arial" }
            td.MultiMiddle3                 { border-top:0px solid #000000; border-bottom:0px solid #000000; border-right:1px solid #000000; border-left:1px solid #000000 }
            td.MultiMiddle5                 { border-top:0px solid #000000; border-bottom:0px solid #000000; border-right:0px solid #000000; border-left:1px solid #000000; color:black; font-size:7pt; font-family:"Arial Narrow" }
            td.MultiMiddlePB2               { border-top:1px solid #000000; border-bottom:0px solid #000000; border-right:0px solid #000000; border-left:1px solid #000000; font-size:8pt; font-family:"Arial" }
            td.MultiMiddlePB3               { border-top:1px solid #000000; border-bottom:0px solid #000000; border-right:0px solid #000000; border-left:0px solid #000000; font-size:8pt; font-family:"Arial" }
            td.MultiMiddlePB5               { border-top:0px solid #000000; border-bottom:0px solid #000000; border-right:0px solid #000000; border-left:1px solid #000000; color:black; font-size:7pt; font-family:"Arial Narrow" }

            td.DischargMeds2                { width:800pt;border-top:0px; border-bottom:1px solid #9F9F9F; border-right:0px; border-left:1px solid #9F9F9F; font-size:8pt; font-family:"Arial" }
            td.DischargMeds3                { border-top:0px; border-bottom:1px solid #9F9F9F; border-right:1px solid #9F9F9F; border-left:1px solid #9F9F9F }
            td.DischargMeds5                { border-top:0px; border-bottom:1px solid #9F9F9F; border-right:0px; border-left:1px solid #9F9F9F; color:black; font-size:7pt; font-family:"Arial Narrow" }
            td.DischargMeds6                { border-top:0px; border-bottom:0px; border-right:0px; border-left:1px solid #9F9F9F; color:black; font-size:7pt; font-family:"Arial Narrow" }

            td.firstMed                     { border-top:0px; border-bottom:0px; border-right:1px solid #9F9F9F; border-left:1px solid #9F9F9F }
            td.LastMed                      { border-top:0px; border-bottom:1px solid #9F9F9F; border-right:1px solid #9F9F9F; border-left:1px solid #9F9F9F }

            td.test                         { border-top:1px solid #9F9F9F; border-bottom:1px solid #9F9F9F; border-right:1px solid #9F9F9F; border-left:1px solid #9F9F9F }

            td.firstDrug                    { border-top:1px solid #000000; border-bottom:0px; border-right:1px solid #000000; border-left:1px solid #000000 }
            td.LastDrug                     { border-top:0px; border-bottom:0px solid #000000; border-right:1px solid #000000; border-left:1px solid #000000 }
            td.middleDrug                   { border-top:0px; border-bottom:0px; border-right:1px solid #000000; border-left:1px solid #000000 }

            td.Arial7ptBorderNavyGrayBorder { border:1px solid #9F9F9F; font-size:7pt; color:Navy; font-family:"Arial Narrow" }
            td.Arial7ptBorderNavy           { border:1px solid #000000; font-size:7pt; color:Navy; font-family:"Arial Narrow" }
            td.Arial7ptnoBorderNavy         { border:0px; font-size:7pt; color:Navy; font-family:"Arial Narrow" }
            td.Arial8ptnoBorderNavy         { border:0px; font-size:8pt; color:Navy; font-family:"Arial Narrow" }
            td.Arial10ptnoBorderNavy        { border:0px; font-size:10pt; color:Navy; font-family:"Arial Narrow" }
            td.Arial10ptnoBorderBlack       { border:0px; font-size:10pt; color:Black; font-family:"Arial" }
            td.Arial12ptnoBorderBlack       { border:0px; font-size:12pt; color:Black; font-family:"Arial" }
            td.Arial10ptBorderRed           { border:1px solid #FF0000; font-size:10pt; color:Red; font-family:"Arial Narrow" }
            td.Arial10ptBottomRed           { border-top:0px; border-bottom:1px solid #FF0000; border-right:0px; border-left:0px }
            td.Arial7ptBorderRed            { border:1px solid #FF0000; font-size:10px; color:Red; font-family:"Arial Narrow" }
            td.Arial7ptnoBorderRed          { border:0px; font-size:10px; color:Red; font-family:"Arial Narrow";background-color="#E8E8E8";font-size:10pt }
            td.patientDetails               { border: 0px; }

            .h6                             { font-size:10pt;background-color="#cc0000" ;font-weight:bold;color:FFFFFF }
            .cd                             { font-weight:bold; }
            .cd1                            { font-weight:bold; text-decoration: underline }
            .Arial11ptWhiteOnGray           { width:150pt;font-size:11pt; color:White; background:Gray; font-family:"Arial";}
            .Arial11ptWhiteOnGray2           { width:280pt;font-size:12pt;color:White; background:Gray; font-family:"Arial";}
          </style>
        </head>
      </html>
   
  <body>   
    <xsl:for-each select="/HL7Message/Segment">
      <xsl:variable name="vFirstName" select="PID/PID.5/PID.5.1"/>
      <xsl:variable name="vLastName" select="PID/PID.5/PID.5.0"/>
      <xsl:variable name="vMiddleName" select="PID/PID.5/PID.5.2"/>
      <xsl:variable name="vAddress1" select="PID/PID.11/PID.11.0"/>
      <xsl:variable name="vAddress2" select="PID/PID.11/PID.11.1"/>
      <xsl:variable name="vSuburb" select="PID/PID.11/PID.11.2"/>
      <xsl:variable name="vState" select="PID/PID.11/PID.11.3"/>
      <xsl:variable name="vPostCode" select="PID/PID.11/PID.11.4"/> 
      <xsl:variable name="vMRNo" select="PID/PID.3.5/PID.3.5.1"/>
      <xsl:variable name="vPID" select="PID/PID.2"/>
      <xsl:variable name="vDOB" select="PID/PID.7"/>
      <xsl:variable name="vPhone" select="PID/PID.13"/>      
      <br/>
      <br/>
      <br/>
      <br/>
      <table>
      <tr>
        <td class="Arial11ptWhiteOnGray2">
          <b>Patient : </b>
          <xsl:value-of select ="$vFirstName"/>
          <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
          <xsl:value-of select ="$vLastName"/>
          <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
          <xsl:value-of select ="$vMiddleName"/>
          <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>          
        </td>
        <td class="Arial11ptWhiteOnGray">
          <b>ID : </b>
          <xsl:value-of select ="$vPID"/>
          <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
        </td>
        <td class="Arial11ptWhiteOnGray">
          <b>DOB : </b>
          <xsl:value-of select ="substring($vDOB,7,2)"/>/
          <xsl:value-of select ="substring($vDOB,5,2)"/>/
          <xsl:value-of select ="substring($vDOB,1,4) "/>
          <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>        
        </td>
      </tr>
      <tr>
        <td class="Arial11ptWhiteOnGray">
        <b>Address : </b>
        <xsl:value-of select ="$vAddress1"/>
        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
        <xsl:value-of select ="$vAddress2"/>
        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
        <xsl:value-of select ="$vSuburb"/>
        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
        <xsl:value-of select ="$vState"/>
        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
        <xsl:value-of select ="$vPostCode"/>
        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
        </td>
        <td class="Arial11ptWhiteOnGray">
          <b>Phone : </b>
        <xsl:value-of select ="$vPhone"/>
        <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>        
        </td>
        <td class="Arial11ptWhiteOnGray">
        </td>
      </tr>
     </table>
      <br/>
      <br/>
      
      <table class="resultheader">       
      <xsl:for-each select="OBR">
        <xsl:if test="position()=1">
          <xsl:variable name="vResult1_obr" select="OBR.27/OBR.27.3"/> <!--requested-->
          <xsl:variable name="vResult2_obr" select="OBR.7"/><!--collected-->
          <xsl:variable name="vResult3_obr" select="OBR.16/OBR.16.1"/> <!--ByRef-->
          <!--cc:????-->
          <xsl:variable name="vResult5_obr" select="OBR.22"/> <!--Reported:--> 
          <xsl:variable name="vResult6_obr" select="OBR.3/OBR.3.0"/> <!--Lab:--> 
          <xsl:variable name="vResult7_obr" select="OBR.3/OBR.3.1"/> <!--LabNo:-->           
            <xsl:call-template name ="DisplayResults">
              <xsl:with-param name="Results" select="$vResult1_obr"/>
              <xsl:with-param name="Header" select="'Requested'"/>
              <xsl:with-param name="FormatedDate" select="'Y'"/>             
            </xsl:call-template>
            <xsl:call-template name ="DisplayResults">
              <xsl:with-param name="Results" select="$vResult2_obr"/>
              <xsl:with-param name="Header" select="'Collected'"/>
              <xsl:with-param name="FormatedDate" select="'Y'"/>
            </xsl:call-template>
            <xsl:call-template name ="DisplayResults">
              <xsl:with-param name="Results" select="$vResult3_obr"/>
              <xsl:with-param name="Header" select="'By Ref'"/>
              <xsl:with-param name="FormatedDate" select="'N'"/>
            </xsl:call-template>       
            <xsl:call-template name ="DisplayResults">
              <xsl:with-param name="Results" select="$vResult5_obr"/>
              <xsl:with-param name="Header" select="'Reported'"/>
              <xsl:with-param name="FormatedDate" select="'Y'"/>
            </xsl:call-template>
            <xsl:call-template name ="DisplayResults">
              <xsl:with-param name="Results" select="$vResult6_obr"/>
              <xsl:with-param name="Header" select="'Lab No'"/>
             <xsl:with-param name="FormatedDate" select="'N'"/>
            </xsl:call-template>
            <xsl:call-template name ="DisplayResults">
              <xsl:with-param name="Results" select="$vResult7_obr"/>
              <xsl:with-param name="Header" select="'Lab'"/>
             <xsl:with-param name="FormatedDate" select="'N'"/>
            </xsl:call-template>  
          </xsl:if>
       </xsl:for-each>
     </table>
      
      <br/>
      
      <table class="drugList">
        <b>
        <tr>
          <td class="Arial7ptnoBorderRed">Code</td>
          <td class="Arial7ptnoBorderRed">Drug</td>
          <td class="Arial7ptnoBorderRed">Comments</td>
          <td class="Arial7ptnoBorderRed">Units</td>
          <td class="Arial7ptnoBorderRed">UOM</td>
          <td class="Arial7ptnoBorderRed">ReferenceRange</td>
          <td class="Arial7ptnoBorderRed">Status</td>
        </tr>
         </b>
        <xsl:for-each select="OBX">
          <xsl:variable name="vResult1" select="OBX.3/OBX.3.0"/>
          <xsl:variable name="vResult2" select="OBX.3/OBX.3.1"/>          
          <xsl:variable name="vResult4" select="OBX.3/OBX.3.3"/>          
          <xsl:variable name="vResult6" select="OBX.5"/>
          <xsl:variable name="vResult7" select="OBX.6"/>
          <xsl:variable name="vResult8" select="OBX.7"/>
          <xsl:variable name="vResult9" select="OBX.8"/>
          <tr>
            <xsl:call-template name ="DisplayResults">
              <xsl:with-param name="Results" select="$vResult1"/>
            </xsl:call-template>
            <xsl:call-template name ="DisplayResults">
              <xsl:with-param name="Results" select="$vResult2"/>
            </xsl:call-template>   
            <xsl:call-template name ="DisplayResults">
              <xsl:with-param name="Results" select="$vResult4"/>
            </xsl:call-template>          
            <xsl:call-template name ="DisplayResults">
              <xsl:with-param name="Results" select="$vResult6"/>
            </xsl:call-template>
            <xsl:call-template name ="DisplayResults">
              <xsl:with-param name="Results" select="$vResult7"/>
            </xsl:call-template>
            <xsl:call-template name ="DisplayResults">
              <xsl:with-param name="Results" select="$vResult8"/>
            </xsl:call-template> 
           <xsl:call-template name ="DisplayResults">
              <xsl:with-param name="Results" select="$vResult9"/>
            </xsl:call-template>    
            </tr>
       </xsl:for-each>
     </table>    
    </xsl:for-each>
    <br/>
    <br/>   
  </body>    
  </xsl:template>

 <xsl:template name="DisplayResults">
   <xsl:param name="Results"/> 
   <xsl:param name="Header"/> 
   <xsl:param name="FormatedDate"/>        
        <xsl:if test="$Results">         
            <td class="td">
            <xsl:if test="$Header">
              <font color="Blue" size="2pt">
                <b><xsl:value-of select ="$Header"/></b>  :
                </font>
             </xsl:if>  
           <xsl:choose>
             <xsl:when test="$FormatedDate ='Y'">
               <xsl:value-of select ="substring($Results,7,2)"/>/     
               <xsl:value-of select ="substring($Results,5,2)"/>/
               <xsl:value-of select ="substring($Results,1,4)"/> 
             </xsl:when>
           <xsl:otherwise>
              <xsl:value-of select ="$Results"/>
           </xsl:otherwise>
          </xsl:choose>
          </td>         
        </xsl:if>                 
    </xsl:template>
   </xsl:stylesheet>