using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PathalogyResultsService.Lib
{
    public class ExceptionLogger
    {
        public static void LogException(Exception e)
        {
            try
            {
                //TODO: Create a log file
                Console.WriteLine(e.Message);
            }
            // ReSharper disable EmptyGeneralCatchClause
            catch
            // ReSharper restore EmptyGeneralCatchClause
            {

            }
        }
    }
}