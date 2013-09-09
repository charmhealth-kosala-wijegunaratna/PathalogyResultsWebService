using System.IO;
using System.Reflection;

namespace PathalogyResultsService.Lib
{
    public class Stylesheet
    {
        private const string Stylesheetextract = "PathalogyResultsService.xslt.Results.xslt";

        public byte[] GetStream()
        {
            try
            {
                var memoryStream = new MemoryStream();
                Stream sourceStream = null;

                sourceStream = Assembly.GetExecutingAssembly().GetManifestResourceStream(Stylesheetextract);

                if (sourceStream != null) sourceStream.CopyTo(memoryStream);

                return memoryStream.ToArray();
            }
            catch
            {
                return null;
            }
        }
    }
}