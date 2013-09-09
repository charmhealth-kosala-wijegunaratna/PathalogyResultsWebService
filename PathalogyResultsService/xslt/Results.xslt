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
            BODY                            { font-family:Arial; font-size:14pt;color:#000080}
            table                           { border-collapse: collapse; empty-cells: hide; width:700pt;}
            table.header                    { border-collapse: collapse; empty-cells: hide; width:700pt}
            table.results                   { border-collapse: collapse; border:0px; empty-cells: hide;width:800pt;cellPadding="0";cellSpacing="0"; width:700pt  }
            resultheader                    { width:700pt;border:0px solid #9F9F9F; }
            td.redfont                      {color:red;font-weight:bold;} 
            td.tealRedFont                  { background:Silver;font-weight:bold; font-size:10pt; font-family:"Calibri";color:red;}
            
            td                              { border: 0px; font-size: 10pt ;vertical-align="top" }
            td.italic                       { border: 0px; font-size: 8pt ;vertical-align="top" }
            td.left                         { font-size:10pt;color:#ff9966;align="left" }
            td.highlightcellgray1            { background:Gainsboro;border:0px; }
            td.highlightcellgraywithredfont1 { background:Gainsboro;border:0px; color:Red;font-weight:bold}
            td.highlightcellgray           { background:rgb(234,234,234);border:0px; }
            td.highlightcellgraywithredfont { background:rgb(234,234,234);border:0px; color:Red;font-weight:bold}
          
            td.highlightcellpink            { background:LightPink;border:0px; }
            td.highlightcellgreen           { background:LightGreen;border:0px; }
            td.results_header               { background:rgb(0,171,169); border:0px; font-weight:bold; font-size:12pt; color:AliceBlue; font-family:"Calibri"; text-align="left"}
            td.results_header_date          { background:rgb(0,171,169); border:0px; font-weight:bold; font-size:12pt; color:AliceBlue; font-family:"Calibri"; text-align="center"}
            td.teal                         { background:Silver;font-weight:bold; font-size:10pt; font-family:"Calibri";}
            td.boldfont10                   { font-size:10pt;font-weight:bold}
            td.Arial7ptBorderNavyGrayBorder { border:1px solid #9F9F9F; font-size:7pt; color:Navy; font-family:"Arial Narrow" }
            .h3                             { font-size:12pt;background-color="#cc0000";font-weight:bold;color:FFFFFF }
            .h6                             { font-size:10pt;background-color="#cc0000" ;font-weight:bold;color:FFFFFF }
            .cd                             { font-weight:bold; }
            .cd1                            { font-weight:bold; text-decoration: underline }
            .Calibri11ptBlackOnGray         { border:0px; font-size:11pt; color:Black; font-family:"Calibri"; background:#e9e9e9; }
            p.result                        { color:red;background:Gray;}
          </style>
        </head>
    
   
  <body> 
    <!-- PATIENT AND HEADER VARIABLES -->    
    <!--================================================================================================================================================================================-->
    
    <xsl:for-each select="//Segment">
      <xsl:variable name="vFirstName" select="PID/PID.5/PID.5.1"/>
      <xsl:variable name="vLastName" select="PID/PID.5/PID.5.0"/>
      <xsl:variable name="vMiddleName" select="PID/PID.5/PID.5.2"/>
      <xsl:variable name="vAddress1" select="PID/PID.11/PID.11.0"/>
      <xsl:variable name="vAddress2" select="PID/PID.11/PID.11.1"/>
      <xsl:variable name="vSuburb" select="PID/PID.11/PID.11.2"/>
      <xsl:variable name="vState" select="PID/PID.11/PID.11.3"/>
      <xsl:variable name="vPostCode" select="PID/PID.11/PID.11.4"/> 
      <xsl:variable name="vMRNo" select="PID/PID.2/PID.2.0"/>
      <xsl:variable name="vMRType" select="PID/PID.2/PID.2.3"/>
      <xsl:variable name="vDOB" select="PID/PID.7"/>
      <xsl:variable name="vPhone" select="PID/PID.13"/> 
      <xsl:variable name="vRequestedDate" select="OBR/OBR.27/OBR.27.3"/>
      <xsl:variable name="vCollectedDate" select="OBR/OBR.7"/>
      <xsl:variable name="vReportedDate" select="OBR/OBR.22"/> 
      <xsl:variable name="vOrderingDoctorSurname" select="OBR/OBR.16/OBR.16.1"/> 
      <xsl:variable name="vOrderingDoctorFirstname" select="OBR/OBR.16/OBR.16.2"/> 
      <xsl:variable name="vMessageType" select="MSH/MSH.8/MSH.8.1"/> 
      <!--cc:????-->
      <xsl:variable name="vLabName" select="MSH/MSH.3"/> 
      <xsl:variable name="vLabNumber" select="OBR/OBR.3"/>   
      <xsl:variable name="vFirstResult" select="//OBX/OBX.3/OBX.3.1"></xsl:variable>
      <!--================================================================================================================================================================================-->
      <!-- [END] PATIENT AND HEADER  VARIABLES -->     
      
      
      <!-- GLOBAL SEGMENT VARIABLES -->    
      <!--================================================================================================================================================================================-->
      <xsl:variable name="vCountObservations" select="count(OBX)"/>
      <xsl:variable name="vCountRequests" select="count(OBR)"/>
      <xsl:variable name="vCountOfOBRSegments" select="count(OBR)"/>
      
    
      <!--================================================================================================================================================================================-->
      <!-- [END] GLOBAL  VARIABLES -->   
      <br/>
      <br/>
      
      <!-- REPORT HEADER -->    
      <!--================================================================================================================================================================================-->
      
      <table>
        <colgroup>
          <font face="Calibri">
            <col align="left" width="200" />
            <col align="left" width="150" />
            <col align="left" width="150" />
            <col align="left" width="200" />
          <font size="1" />
          </font>
        </colgroup>
        <tr>
          <td class="Calibri11ptBlackOnGray"><xsl:text disable-output-escaping="yes">Patient:&amp;nbsp;&amp;nbsp;</xsl:text>
            <b>
            <xsl:value-of select ="$vLastName"/><xsl:text disable-output-escaping="yes">,</xsl:text> 
            <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text> 
            <xsl:value-of select ="$vFirstName"/>
            <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
            <xsl:value-of select ="$vMiddleName"/>
            <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text> 
            </b>
          </td>
          <td class="Calibri11ptBlackOnGray">
            <xsl:text disable-output-escaping="yes">ID:&amp;nbsp;</xsl:text>
            <b>
              <xsl:value-of select ="$vMRNo"/>
              <xsl:text disable-output-escaping="yes"> [</xsl:text>
              <xsl:value-of select ="$vMRType"/>
              <xsl:text disable-output-escaping="yes">]</xsl:text>
            </b>
            <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text> 
          </td>
          <td class="Calibri11ptBlackOnGray">
            <xsl:text disable-output-escaping="yes">DOB:&amp;nbsp;</xsl:text>
            <b>
              <xsl:value-of select ="substring($vDOB,7,2)"/>/
              <xsl:value-of select ="substring($vDOB,5,2)"/>/
              <xsl:value-of select ="substring($vDOB,1,4) "/>
            </b>
            
          </td>
          <td class="Calibri11ptBlackOnGray">
            <xsl:text disable-output-escaping="yes">Requested:&amp;nbsp;</xsl:text> 
            <b>
            <xsl:call-template name ="DisplayDateTime">
              <xsl:with-param name="vDate" select="$vRequestedDate"/>
            </xsl:call-template>
            </b>
          </td>  
        </tr>
        <tr>
          <td colspan="3" class="Calibri11ptBlackOnGray">
            <xsl:text disable-output-escaping="yes">Address:&amp;nbsp;</xsl:text>
            <b>
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
             
            </b>
          </td>
          <td class="Calibri11ptBlackOnGray"><xsl:text disable-output-escaping="yes">Collected:&amp;nbsp;</xsl:text>
            <b>
              <xsl:call-template name ="DisplayDateTime">
                <xsl:with-param name="vDate" select="$vCollectedDate"/>
              </xsl:call-template>
            </b>
          </td>
        </tr>
        <tr>
          <td class="Calibri11ptBlackOnGray">
            <xsl:text disable-output-escaping="yes">Ordered By:&amp;nbsp;</xsl:text>
            <b> 
              <xsl:value-of select ="$vOrderingDoctorSurname"/>
              <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
              <xsl:value-of select ="$vOrderingDoctorFirstname"/>
            </b>
          </td>
          <td class="Calibri11ptBlackOnGray">
            <xsl:text disable-output-escaping="yes">Lab:&amp;nbsp;</xsl:text>
            <b>
              <xsl:value-of select ="$vLabName"/>
            </b>
          </td>
          <td class="Calibri11ptBlackOnGray">
            <xsl:text disable-output-escaping="yes">LabNo:&amp;nbsp;</xsl:text>
            <b>
              <xsl:value-of select ="$vLabNumber"/>
            </b>
          </td>
          <td class="Calibri11ptBlackOnGray">
            <xsl:text disable-output-escaping="yes">Reported:&amp;nbsp;</xsl:text>
            <b>
              <xsl:call-template name ="DisplayDateTime">
                <xsl:with-param name="vDate" select="$vReportedDate"/>
              </xsl:call-template>
            </b>
          </td>
        </tr>
        
      </table>
      <!--================================================================================================================================================================================-->
      <!-- [END] REPORT HEADER -->  
      
      <br/>
       
      <!-- RESULT REPORT -->    
      <!--================================================================================================================================================================================-->
      
      <table>
        
        <colgroup>
          <font face="Calibri">
            <col align="left" width="100" />
            <col align="left" width="150" />
            <col align="left" width="200" />
            <col align="left" width="100" />
            <col align="left" width="100" />
            <col align="left" width="50" />
          </font>
          </colgroup>
         
      <xsl:for-each select="node()">
         <!-- <xsl:value-of select="local-name(current())"/>   -->     <!--code to get the current node of the xml tree -->
        
        <xsl:choose>
          <xsl:when test="local-name(current())='OBR'">                
            <!-- TEST HEADER  -->
            <xsl:variable name="vSpecimenSource" select="OBR.15/OBR.15.0/OBR.15.0.1"></xsl:variable>
            <xsl:variable name="vSpecimenSourceModifier" select="OBR.15/OBR.15.5"></xsl:variable>
            <xsl:variable name="vTestName" select="OBR.4/OBR.4.1"></xsl:variable>
            <xsl:variable name="vTestRequestDate" select="OBR.27/OBR.27.3"></xsl:variable>
            <xsl:variable name="vTestCollectDate" select="OBR.7"></xsl:variable>
            <xsl:variable name="vTestReportDate" select="OBR.22"></xsl:variable>
           
            
              <tr>
                <!-- Display number of Requests (OBR Segments), if greater than 1 Example    No. 1 of 3-->
                <td class="results_header" colspan="3">
                   <xsl:if test="$vCountOfOBRSegments>1">
                     <xsl:text disable-output-escaping="yes">No. </xsl:text>
                     <xsl:value-of select="OBR.1"/> 
                     <xsl:text disable-output-escaping="yes"> of </xsl:text>
                     <xsl:value-of select ="$vCountRequests"/><br/>
                   </xsl:if>
                   <xsl:value-of select ="$vTestName"/>
                   <xsl:if test="string-length($vSpecimenSource)>1">
                     <xsl:text disable-output-escaping="yes">:&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp</xsl:text> 
                     <i>
                       <xsl:value-of select="$vSpecimenSource"/>
                     </i>
                   </xsl:if>
                   <xsl:if test="string-length($vSpecimenSourceModifier)>1">
                     <i>
                       <xsl:text disable-output-escaping="yes"> - </xsl:text>
                       <xsl:value-of select="$vSpecimenSourceModifier"/>
                     </i> 
                   </xsl:if>
                 </td>
             
                 <td class="results_header_date">
                   <xsl:if test="$vRequestedDate != $vTestRequestDate">
                     <xsl:text disable-output-escaping="yes">Requested:&amp;nbsp;</xsl:text> <br/>
                     <b>
                     <xsl:call-template name ="DisplayDateTime">
                       <xsl:with-param name="vDate" select="OBR.27/OBR.27.3"/>
                     </xsl:call-template>
                     </b>
                   </xsl:if>
                  
                 </td>
                 <td class="results_header_date">
                   <xsl:if test="$vCollectedDate != $vTestCollectDate">
                     <xsl:text disable-output-escaping="yes">Collected:&amp;nbsp;</xsl:text><br/>
                     <b>
                       <xsl:call-template name ="DisplayDateTime">
                         <xsl:with-param name="vDate" select="OBR.7"/>
                       </xsl:call-template>
                     </b>
                   </xsl:if>
                 </td>
                 <td class="results_header_date">
                   <xsl:if test="$vReportedDate != $vTestReportDate">
                    <xsl:text disable-output-escaping="yes">Reported:&amp;nbsp;</xsl:text><br/>
                    <b>
                      <xsl:call-template name ="DisplayDateTime">
                        <xsl:with-param name="vDate" select="OBR.22"/>
                      </xsl:call-template>
                    </b>
                   </xsl:if>
                   
                 </td>
               </tr>
            <tr> <!--INSERT A BLANK ROW -->
              <td><br></br></td>
              <td><br></br></td>
              <td><br></br></td>
              <td><br></br></td>
              <td><br></br></td>
              <td><br></br></td>
            </tr>
            
          </xsl:when>
          <!-- <END> TEST HEADER  -->
          
          <xsl:otherwise>
            <!--DISPLAY RESULT OBSERVATION AND NOTES DATA -->
            <xsl:choose>
                <xsl:when test="local-name(current())='OBX'">
                  <xsl:variable name="vResultType" select="OBX.2"/>
                  <xsl:variable name="vPosition" select="OBX.1"/>
                  <xsl:variable name="vValue" select="OBX.5"/>
                  <xsl:variable name="vAbnormal" select="OBX.8"/>
                  <xsl:variable name="vResultName" select="OBX.3/OBX.3.1"/>
                  <xsl:variable name ="vprevResultName" select="preceding-sibling::OBX[1]/OBX.3/OBX.3.1"/>
                  <xsl:variable name ="vprevStatus" select="preceding-sibling::OBX[1]/OBX.11"/>
                  <xsl:variable name="vCurrentStatus" select = "OBX.11"/>
                  
                  <xsl:if test="$vPosition=1 and ($vResultType='NM' or $vResultType='CE')">
                    <tr class="results_header">
                     <td class="teal"></td>
                      <td class="teal"></td>
                      <td class="teal">Result</td>
                      <td class="teal">Units</td>
                      <td class="teal">Reference<br/>Range</td>
                      <td class="teal" align="center">Status</td>
                    </tr>
                    
                  </xsl:if>
                  
                  <!-- OBSERVATION:  NUMERIC ATOMIC DATA  -->
                  <xsl:if test="$vResultType='NM'">
                    <xsl:choose>
                      <xsl:when test="$vPosition mod 2=1"> <!-- <xsl:when test="$vPosition mod 2=1"> -->
                      <tr>
                        <td></td>
                        <td><b><xsl:value-of select="$vResultName"/></b></td>
                        <td> 
                           <xsl:choose>
                             <xsl:when test="string-length($vAbnormal)=0">
                                <xsl:value-of select="$vValue"/>
                            </xsl:when>
                             <xsl:otherwise>
                               <span style="color:red;font-weight:bold">
                               <xsl:value-of select="$vValue"/>
                               <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                               <xsl:value-of select="OBX.8"/>
                               </span>  
                             </xsl:otherwise>
                           </xsl:choose>
                        </td>
                        <td><xsl:value-of select="OBX.6/OBX.6.0"/></td>
                        <td><xsl:value-of select="OBX.7/OBX.7.0"/></td>
                        <td align="center"><xsl:value-of select="OBX.11"/></td>
                      </tr>
                     
                      
                      
                    </xsl:when>
                    <xsl:otherwise>
                    
                      <tr>
                        <td class="highlightcellgray"></td>
                        <td class="highlightcellgray"><b><xsl:value-of select="$vResultName"/></b></td>
                        <td class="highlightcellgray"> 
                          <xsl:choose>
                            <xsl:when test="string-length($vAbnormal)=0">
                              <xsl:value-of select="$vValue"/>
                            </xsl:when>
                            <xsl:otherwise>
                              <span style="color:red;font-weight:bold">
                                <xsl:value-of select="$vValue"/>
                                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                <xsl:value-of select="OBX.8"/>
                              </span>  
                            </xsl:otherwise>
                          </xsl:choose>
                        </td>
                        <td class="highlightcellgray"><xsl:value-of select="OBX.6/OBX.6.0"/></td>
                        <td class="highlightcellgray"><xsl:value-of select="OBX.7/OBX.7.0"/></td>
                        <td class="highlightcellgray" align="center"><xsl:value-of select="OBX.11"/></td>
                      </tr>
                      
                    </xsl:otherwise>
                  </xsl:choose>
                 </xsl:if>
                  <!-- [END]  OBSERVATION:  NUMERIC ATOMIC DATA  -->
                  
                  <!-- OBSERVATION:  CODED ATOMIC DATA            -->
                  <xsl:if test="$vResultType='CE'">
                    <xsl:variable name="vCodedDesc" select="OBX.5/OBX.5.0"></xsl:variable>
                    <xsl:variable name="vCodedValue" select="OBX.5/OBX.5.1"></xsl:variable>
                    <xsl:choose>
                     
                      <xsl:when test="$vPosition mod 2=1"> <!-- <xsl:when test="$vPosition mod 2=1"> -->
                     <tr>
                        <td></td>
                        <td><b><xsl:value-of select="$vResultName"/></b></td>
                        <td>
                          <xsl:choose>
                              <xsl:when test="string-length($vAbnormal)=0">
                                <xsl:call-template name="DisplayCodedElement" >
                                  <xsl:with-param name = "vCode" select="$vCodedValue"></xsl:with-param>
                                  <xsl:with-param name = "vDesc" select="$vCodedDesc"></xsl:with-param>
                                </xsl:call-template>
                              </xsl:when>
                              <xsl:otherwise>
                                <span style="color:red;font-weight:bold">
                                  <xsl:call-template name="DisplayCodedElement" >
                                    <xsl:with-param name = "vCode" select="$vCodedValue"></xsl:with-param>
                                    <xsl:with-param name = "vDesc" select="$vCodedDesc"></xsl:with-param>
                                  </xsl:call-template>
                                  <xsl:value-of select="OBX.8"/>
                                </span>  
                              </xsl:otherwise>
                            </xsl:choose>
                        </td>
                        <td><xsl:value-of select="OBX.6/OBX.6.0"/></td>
                        <td><xsl:value-of select="OBX.7/OBX.7.0"/></td>
                        <td align="center"><xsl:value-of select="OBX.11"/></td>
                      </tr>
                    </xsl:when>
                    <xsl:otherwise>
                                         
                      <tr>
                        <td class="highlightcellgray"></td>
                        <td class="highlightcellgray"><b><xsl:value-of select="$vResultName"/></b></td>
                        <td class="highlightcellgray"> 
                          <xsl:choose>
                            <xsl:when test="string-length($vAbnormal)=0">
                              <xsl:call-template name="DisplayCodedElement" >
                                <xsl:with-param name = "vCode" select="$vCodedValue"></xsl:with-param>
                                <xsl:with-param name = "vDesc" select="$vCodedDesc"></xsl:with-param>
                              </xsl:call-template>
                            </xsl:when>
                            <xsl:otherwise>
                              <span style="color:red;font-weight:bold">
                                <xsl:call-template name="DisplayCodedElement" >
                                  <xsl:with-param name = "vCode" select="$vCodedValue"></xsl:with-param>
                                  <xsl:with-param name = "vDesc" select="$vCodedDesc"></xsl:with-param>
                                </xsl:call-template>
                                <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                                <xsl:value-of select="OBX.8"/>
                              </span>  
                            </xsl:otherwise>
                          </xsl:choose>
                        </td>
                        <td class="highlightcellgray"><xsl:value-of select="OBX.6/OBX.6.0"/></td>
                        <td class="highlightcellgray"><xsl:value-of select="OBX.7/OBX.7.0"/></td>
                        <td class="highlightcellgray" align="center"><xsl:value-of select="OBX.11"/></td>
                      </tr>
                      
                    </xsl:otherwise>
                  </xsl:choose>
          
                  </xsl:if>
                  <!-- [END] OBSERVATION:  CODED ATOMIC DATA -->
                  
                  <!-- OBSERVATION:  FORMATTED TEXT - PROCESS USING THE WORDWRAP FUNCTION -->
                  
                  <xsl:if test="$vResultType='FT'">
                    <tr>
                      <td><b><xsl:value-of select="$vResultName"/></b></td>
                      <td colspan="5"> 
                        <xsl:call-template name="wordWrap">                 
                          <xsl:with-param name="string" select="$vValue" />               
                        </xsl:call-template>
                      </td>
                     
                    </tr>
                  </xsl:if>
                  <!-- [END] OBSERVATION:  FORMATTED TEXT - PROCESS USING THE WORDWRAP FUNCTION -->
                  
                  <!-- OBSERVATION: ATOMIC STRING DATA -->
                  <xsl:if test="$vResultType='ST'">
                    <tr>
                      <td></td>
                      <td align="left"><b><xsl:value-of select="$vResultName"/></b></td>
                      <td> 
                        <xsl:choose>
                          <xsl:when test="string-length($vAbnormal)=0">
                            <xsl:value-of select="$vValue"/>
                          </xsl:when>
                          <xsl:otherwise>
                            <span style="color:red;font-weight:bold">
                            <xsl:value-of select="$vValue"/>
                            <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
                            <xsl:value-of select="OBX.8"/>
                            </span>
                          </xsl:otherwise>
                        </xsl:choose>
                      </td>
                      <td><xsl:value-of select="OBX.6/OBX.6.0"/></td>
                      <td><xsl:value-of select="OBX.7/OBX.7.0"/></td>
                      <td><xsl:value-of select="OBX.11"/></td>
                    </tr>
                  </xsl:if>
                  <!-- [END]  OBSERVATION: ATOMIC STRING DATA -->
                  
                  <!--  OBSERVATION:  TEXT PRE FORMATTED DATA -->
                  <xsl:if test="$vResultType='TX'">
              
                      <tr>
                         <td>  
                            <xsl:if test="$vprevResultName !=$vResultName or string-length($vprevResultName)=0 ">
                              <b><xsl:value-of select="$vResultName"/></b>
                            </xsl:if>  
                          </td>
                          <td colspan="4"> <pre><xsl:value-of select="$vValue"/></pre></td>
                          <td>
                            <xsl:if test="$vprevStatus !=$vCurrentStatus or string-length($vprevStatus)=0">
                              <xsl:text>Status:  </xsl:text>
                              <xsl:value-of select="$vCurrentStatus"/>
                            </xsl:if>                          
                          </td>
                        </tr>
                   
                    </xsl:if>
                  <!-- TODO WRITE CODE to handle the fact that for some TX messages, the Result Name and Status repeats for all TX records -->
                   <!-- [END]   OBSERVATION:  TEXT PRE FORMATTED DATA -->
                  
                   
                 </xsl:when>  <!-- [END] OBSERVATION DATA  -->
                   
              <xsl:otherwise>  <!-- [START] NOTE DATA  -->
                
                
                <!--  NOTE DATA -->
                   <xsl:if test="local-name(current())='NTE'">
                     <xsl:variable name="vNoteHeader" select="NTE.2"/>
                     <xsl:variable name="vNote" select="NTE.3"/>
                     <xsl:if test="$vNote='Comment'">
                       <!--<xsl:if test="$vNote != 'VERIFIED by Discern Expert.'"> -->
                           <tr>
                             <td colspan="1"><xsl:value-of select="$vNoteHeader"/><br/><br/></td>
                             <td colspan="3"> 
                               <i> <xsl:call-template name="wordWrap">                 
                                 <xsl:with-param name="string" select="$vNote" />               
                               </xsl:call-template>
                                </i> 
                               <br/><br/>
                               
                             </td>
                             <td colspan="2"></td>
                           </tr>
                     </xsl:if>   
                   </xsl:if> 
                <!--  [END] NOTE DATA -->
                 </xsl:otherwise>
                
            </xsl:choose>
            
          </xsl:otherwise>
        
        </xsl:choose>
      </xsl:for-each>
      
  
    
    </table>
    </xsl:for-each>



 
  </body>
  </html>
  </xsl:template>

  <!--================================================================================================================================================================================-->
  <!-- [END] RESULT REPORT -->

  <!-- TEMPLATES -->    
  <!--DisplayDateTime Template -->
<xsl:template name="DisplayDateTime">
  <xsl:param name="vDate"/>
  <xsl:choose>
    <xsl:when test="string-length($vDate)=0"> <xsl:value-of select="$vDate"></xsl:value-of>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select ="substring($vDate,7,2)"/>/     
      <xsl:value-of select ="substring($vDate,5,2)"/>/
      <xsl:value-of select ="substring($vDate,1,4)"/>
      <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
      <xsl:text disable-output-escaping="yes">&amp;nbsp;</xsl:text>
      <xsl:value-of select ="substring($vDate,9,2)"/>
      <xsl:text disable-output-escaping="yes">:</xsl:text>
      <xsl:value-of select ="substring($vDate,11,2)"/>
    </xsl:otherwise>
  </xsl:choose>
 </xsl:template>
  <!--Display Coded Element Template -->
  <xsl:template name= "DisplayCodedElement">
    <xsl:param name="vCode"></xsl:param>
    <xsl:param name="vDesc"></xsl:param>
    <xsl:choose>
      <xsl:when test="string-length($vCode)>0 and ($vCode != $vDesc)">
        <xsl:value-of select="$vDesc"/> 
        <xsl:text> (</xsl:text>  
        <xsl:value-of select="$vCode"/>
        <xsl:text>}</xsl:text>  
          
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$vDesc"/>
      </xsl:otherwise>
    </xsl:choose>
    
  </xsl:template>
  
  <!-- Display Results Template -->
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
  
<!-- Wordwrap Template -->
<xsl:template name="wordWrap">
  <xsl:param name="string" />
  <xsl:param name="width" select="70" />
  <xsl:param name="string70"
    select="substring($string, 1, $width)" />
  <!-- first 70 chars -->
  <xsl:param name="string20"
    select="substring($string, $width + 1, 20)" />
  <!-- next 20 chars from 71-->
  <xsl:param name="stringRest" select="substring($string, 91)" />
  <xsl:param name="nextSpace"
    select="substring-before($string20, ' ')" />
  <xsl:param name="afterSpace"
    select="substring-after($string20, ' ')" />
  <xsl:param name="stringBreak"
    select="concat($string70, $nextSpace)" />
  <xsl:param name="stringAgain"
    select="concat($afterSpace, $stringRest)" />
  <xsl:param name="temp"
    select="substring-after($string, '\H\')" />
  <xsl:param name="highlightedText"
    select="substring-before($temp, '\N\')" />
  <xsl:choose>
    <!-- replacing \H\ \N\-->
    <xsl:when test="contains($string, '\H\')">
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-before($string, '\H\')" />
      </xsl:call-template>
      <nobr>
        <font color="red">
          <xsl:value-of select="$highlightedText" />
        </font>
      </nobr>
      <!--<b>    <font face="Calibri" size="2">       <xsl:value-of select="$highlightedText" />       </font>       </b>-->
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-after($string, '\N\')" />
      </xsl:call-template>
    </xsl:when>
    <!--replace single \.br\ -->
    <xsl:when test="contains($string, '\.br\')">
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-before($string, '\.br\')" />
      </xsl:call-template>
      <br />
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-after($string, '\.br\')" />
      </xsl:call-template>
    </xsl:when>
    <!--replace single ~ with linebreak-->
    <xsl:when test="contains($string, '~')">
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-before($string, '~')" />
      </xsl:call-template>
      <br />
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-after($string, '~')" />
      </xsl:call-template>
    </xsl:when>
    <!--replace single \XC4\ with - -->
    <xsl:when test="contains($string, '\XC4\')">
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-before($string, '\XC4\')" />
      </xsl:call-template>
      <nobr>
        <font face="Calibri" size="2">-</font>
      </nobr>
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-after($string, '\XC4\')" />
      </xsl:call-template>
    </xsl:when>
    <!--replace single \XE6\ with micro -->
    <xsl:when test="contains($string, '\XE6\')">
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-before($string, '\XE6\')" />
      </xsl:call-template>
      <nobr>
        <font face="Calibri" size="2">&#181;</font>
      </nobr>
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-after($string, '\XE6\')" />
      </xsl:call-template>
    </xsl:when>
    <!--replace single \XF8\ with degree -->
    <xsl:when test="contains($string, '\XF8\')">
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-before($string, '\XF8\')" />
      </xsl:call-template>
      <nobr>
        <font face="Calibri" size="2">&#176;</font>
      </nobr>
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-after($string, '\XF8\')" />
      </xsl:call-template>
    </xsl:when>
    <!--replace \R\ with ~ -->
    <xsl:when test="contains($string, '\R\')">
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-before($string, '\R\')" />
      </xsl:call-template>
      <nobr>
        <font face="Calibri" size="2">&#732;</font>
      </nobr>
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-after($string, '\R\')" />
      </xsl:call-template>
    </xsl:when>
    <!--replace \S\ with ^ -->
    <xsl:when test="contains($string, '\S\')">
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-before($string, '\S\')" />
      </xsl:call-template>
      <nobr>
        <font face="Calibri" size="2">^</font>
      </nobr>
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-after($string, '\S\')" />
      </xsl:call-template>
    </xsl:when>
    <!--replace \T\ with & -->
    <xsl:when test="contains($string, '\T\')">
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-before($string, '\T\')" />
      </xsl:call-template>
      <nobr>
        <font face="Calibri" size="2">&amp;</font>
      </nobr>
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-after($string, '\T\')" />
      </xsl:call-template>
    </xsl:when>
    <!--replace \F\ with | -->
    <xsl:when test="contains($string, '\F\')">
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-before($string, '\F\')" />
      </xsl:call-template>
      <nobr>
        <font face="Calibri" size="2">|</font>
      </nobr>
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-after($string, '\F\')" />
      </xsl:call-template>
    </xsl:when>
    <!--replace ~ with only first result -->
    <xsl:when test="contains($string, '^')">
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-before($string, '^')" />
      </xsl:call-template>
    </xsl:when>
    <!--replace \E\ with \ -->
    <xsl:when test="contains($string, '\E\')">
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-before($string, '\E\')" />
      </xsl:call-template>
      <nobr>
        <font face="Calibri" size="2">\</font>
      </nobr>
      <xsl:call-template name="wordWrap">
        <xsl:with-param name="string"
          select="substring-after($string, '\E\')" />
      </xsl:call-template>
    </xsl:when>
    <xsl:when test="string-length($string) &gt; 70">
      <xsl:choose>
        <xsl:when test="substring($string, $width, 1) = ' '">
          <xsl:value-of select="substring($string, 1, $width)" />
          <br />
          <xsl:call-template name="wordWrap">
            <xsl:with-param name="string"
              select="substring($string, $width + 1)" />
            <xsl:with-param name="width" select="$width" />
          </xsl:call-template>
        </xsl:when>
        <!--otherwise break at next space -->
        <xsl:otherwise>
          <xsl:value-of select="$stringBreak" />
          <br />
          <xsl:call-template name="wordWrap">
            <xsl:with-param name="string"
              select="$stringAgain" />
            <xsl:with-param name="width" select="$width" />
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:when>
    <xsl:otherwise>
      <xsl:value-of select="$string" />
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>
  
  
  <!--REPLACE TEMPLATE-->
  
  <xsl:template name="replace">
    <xsl:param name="string" />
    <xsl:param name="temp"
      select="substring-after($string, '\H\')" />
    <xsl:param name="highlightedText"
      select="substring-before($temp, '\N\')" />
    <xsl:choose>
      <!-- replacing \H\ \N\-->
      <xsl:when test="contains($string, '\H\')">
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-before($string, '\H\')" />
        </xsl:call-template>
        <nobr>
          <font color="red">
            <xsl:value-of select="$highlightedText" />
          </font>
        </nobr>
        <!--<b>    <font face="Calibri" size="2">       <xsl:value-of select="$highlightedText" />       </font>       </b>-->
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-after($string, '\N\')" />
        </xsl:call-template>
      </xsl:when>
      <!--replace single \.br\ -->
      <xsl:when test="contains($string, '\.br\')">
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-before($string, '\.br\')" />
        </xsl:call-template>
        <br />
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-after($string, '\.br\')" />
        </xsl:call-template>
      </xsl:when>
      <!--5879 replace single \.nf\ -->
      <xsl:when test="contains($string, '\.nf\')">
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-before($string, '\.nf\')" />
        </xsl:call-template>
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-after($string, '\.nf\')" />
        </xsl:call-template>
      </xsl:when>
      <!--replace single ED-CROSSMATCH -->
      <!--<xsl:when test="contains($string, 'ED-CROSSMATCH')">      <xsl:call-template name="replace">       <xsl:with-param name="string"           select="substring-before($string, 'ED-CROSSMATCH')" />      </xsl:call-template>      <xsl:value-of select='CROSSMATCH'/>      <xsl:call-template name="replace">       <xsl:with-param name="string"           select="substring-after($string, 'ED-CROSSMATCH')" />      </xsl:call-template>     </xsl:when>-->
      <!--replace single ~ with linebreak-->
      <xsl:when test="contains($string, '~')">
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-before($string, '~')" />
        </xsl:call-template>
        <br />
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-after($string, '~')" />
        </xsl:call-template>
      </xsl:when>
      <!--replace single ^ with space -->
      <!--<xsl:when test="contains($string, '^')">        <xsl:call-template name="replace">          <xsl:with-param name="string"                          select="substring-before($string, '^')" />        </xsl:call-template>       <nobr><font face="Calibri" size="2">&#32;</font></nobr>        <xsl:call-template name="replace">          <xsl:with-param name="string"                          select="substring-after($string, '^')" />        </xsl:call-template>      </xsl:when>-->
      <!--replace single \XC4\ with - -->
      <xsl:when test="contains($string, '\XC4\')">
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-before($string, '\XC4\')" />
        </xsl:call-template>
        <nobr>
          <font face="Calibri" size="2">-</font>
        </nobr>
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-after($string, '\XC4\')" />
        </xsl:call-template>
      </xsl:when>
      <!--replace single \XE6\ with micro -->
      <xsl:when test="contains($string, '\XE6\')">
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-before($string, '\XE6\')" />
        </xsl:call-template>
        <nobr>
          <font face="Calibri" size="2">&#181;</font>
        </nobr>
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-after($string, '\XE6\')" />
        </xsl:call-template>
      </xsl:when>
      <!--replace single \XF8\ with degree -->
      <xsl:when test="contains($string, '\XF8\')">
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-before($string, '\XF8\')" />
        </xsl:call-template>
        <nobr>
          <font face="Calibri" size="2">&#176;</font>
        </nobr>
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-after($string, '\XF8\')" />
        </xsl:call-template>
      </xsl:when>
      <!--replace \R\ with ~ -->
      <xsl:when test="contains($string, '\R\')">
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-before($string, '\R\')" />
        </xsl:call-template>
        <nobr>
          <font face="Calibri" size="2">&#732;</font>
        </nobr>
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-after($string, '\R\')" />
        </xsl:call-template>
      </xsl:when>
      <!--replace \S\ with ^ -->
      <xsl:when test="contains($string, '\S\')">
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-before($string, '\S\')" />
        </xsl:call-template>
        <nobr>
          <font face="Calibri" size="2">^</font>
        </nobr>
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-after($string, '\S\')" />
        </xsl:call-template>
      </xsl:when>
      <!--replace \T\ with & -->
      <xsl:when test="contains($string, '\T\')">
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-before($string, '\T\')" />
        </xsl:call-template>
        <nobr>
          <font face="Calibri" size="2">&amp;</font>
        </nobr>
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-after($string, '\T\')" />
        </xsl:call-template>
      </xsl:when>
      <!--replace \F\ with | -->
      <xsl:when test="contains($string, '\F\')">
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-before($string, '\F\')" />
        </xsl:call-template>
        <nobr>
          <font face="Calibri" size="2">|</font>
        </nobr>
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-after($string, '\F\')" />
        </xsl:call-template>
      </xsl:when>
      <!--replace \E\ with \ -->
      <xsl:when test="contains($string, '\E\')">
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-before($string, '\E\')" />
        </xsl:call-template>
        <nobr>
          <font face="Calibri" size="2">\</font>
        </nobr>
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-after($string, '\E\')" />
        </xsl:call-template>
      </xsl:when>
      <!--replace ^ with space-->
      <xsl:when test="contains($string, '^')">
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-before($string, '^')" />
        </xsl:call-template>
        <nobr>
          <font face="Calibri" size="2">&#160;</font>
        </nobr>
        <xsl:call-template name="replace">
          <xsl:with-param name="string"
            select="substring-after($string, '^')" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$string" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
<!--================================================================================================================================================================================-->
<!-- [END] TEMPLATES -->


</xsl:stylesheet>
