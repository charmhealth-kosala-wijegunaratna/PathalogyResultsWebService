using System;
using System.Collections.Generic;
using System.IO;
using System.ServiceModel.Activation;
using System.Text.RegularExpressions;
using System.Xml.Xsl;
using PathalogyResultsService.Lib;

namespace PathalogyResultsService
{
    // NOTE:TODO: Please complete the ExceptionLogger class.
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class ServicePathalogyResults : IServicePathalogyResults
    {
        //TODO: Format error message
        private const string HtmlError = "<html>Error occured</html>";

        public string GetData(string value)
        {
            return ConvertHl7ToHtml(value);
        }

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }

        private string ConvertHl7ToHtml(string hl7Message)
        {
            //validate msg 
            if (String.IsNullOrEmpty(hl7Message)) return HtmlError;

            try
            {
                //convert 
                string hl7Contents = hl7Message;
                var hl7Parser = new HL7ToXmlConverter();
                string xmlContents = hl7Parser.ConvertToXml(hl7Contents);
                var random = new Random().Next();

                //save/overwrite xml in users temp folder
                string xmlPath = Path.Combine(Path.GetTempPath(), "pathalogyresults_" + random + ".xml");
                File.WriteAllText(xmlPath, xmlContents);

                if ((DevideSegments(xmlPath, "MSH", "Segment")))
                {
                    return TransformXml(xmlPath);
                }
                return HtmlError;
            }
            catch (Exception e)
            {
                ExceptionLogger.LogException(e);
                return HtmlError;
            }
        }

        private static bool DevideSegments(string xmlPath, string seperator, string tag)
        {
            string xmlText = File.ReadAllText(xmlPath);
            var segmentedXmlLines = new List<string>();
            string startTag = "<" + tag + ">";
            string endTag = "</" + tag + ">";
            string startSeperator = "<" + seperator + ">";
            string[] segmentedTexts = null;
            const string xsltEndTag = "</HL7Message>";

            segmentedTexts = Regex.Split(xmlText, startSeperator);


            for (int i = 0; i <= segmentedTexts.GetUpperBound(0); i++)
            {
                if (i == 1)
                {
                    segmentedXmlLines.Add(startTag + startSeperator);
                }
                if (i > 1)
                {
                    segmentedXmlLines.Add(string.Format("{0}{1}{2}", endTag, startTag, startSeperator));
                }
                if (segmentedTexts[i].Trim().Contains(xsltEndTag))
                {
                    segmentedTexts[i] = segmentedTexts[i].Replace(xsltEndTag,
                                                                  string.Format("{0}{1}", endTag, xsltEndTag));
                }
                segmentedXmlLines.Add(segmentedTexts[i]);
            }
            try
            {
                File.Delete(xmlPath);
                File.WriteAllLines(xmlPath, segmentedXmlLines);
                string contents = File.ReadAllText(xmlPath);
                contents = contents.Replace(string.Format("{0}\r", "ARG0"), "")
                                   .Replace(string.Format("{0}\n", "ARG0"), "");
                File.WriteAllText(xmlPath, contents);
                return true;
            }
            catch (Exception e)
            {
                ExceptionLogger.LogException(e);
                return false;
            }
        }

        private string TransformXml(string xmlfilepath)
        {
            string temphtmlpath = null;
            var filepath = Path.GetTempPath() + "pathalogyresults";
            var xsltpath = filepath + ".xslt";
            var random = new Random().Next();

            //create stylesheet
            var stylesheet = new Stylesheet();
            var stream = stylesheet.GetStream();

            File.WriteAllBytes(xsltpath, stream);

            var xmlFilePath = xmlfilepath;

            if (!File.Exists(xmlFilePath))
            {
                throw new Exception(xmlFilePath + " does not exist.");
            }

            var xmlTransformer = new XslCompiledTransform();

            xmlTransformer.Load(xsltpath);

            temphtmlpath = filepath + "_" + random + ".html";

            xmlTransformer.Transform(xmlFilePath, temphtmlpath);

            var contents = File.ReadAllText(temphtmlpath);

            return !string.IsNullOrEmpty(contents) ? contents : HtmlError;
        }
    }
}