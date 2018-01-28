﻿using School_Universe.Views;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows;

namespace School_Universe.Shared
{
    public class GeneralMethods
    {
        public static void ShowNotification(string Title, string Message, Boolean IsError = false)
        {
            Notification winNotification = new Notification(Title, Message, IsError);
            winNotification.Show();
        }

        public static void CreateGlobalObject(string globalObjectName, object objObject)
        {
            Application.Current.Properties[globalObjectName] = objObject;
        }
        public static object GetGlobalObject(string globalObjectName)
        {
            return Application.Current.Properties[globalObjectName];
        }

        public static Boolean IsInternetAvailable()
        {
            try
            {
                IPHostEntry ipHe = Dns.GetHostEntry("www.google.com");
                return true;
            }
            catch
            {
                return false;
            }
        }
        public static Boolean Log(string line,Boolean IsHeading = false, Boolean append = true)
        {
            Boolean IsSuccess = false;
            string fileName = @"Logs\log.txt";
            if (!File.Exists(fileName))
                Directory.CreateDirectory(Path.GetDirectoryName(fileName));
            using (StreamWriter objStreamWriter = new StreamWriter(fileName, append))
            {
                if(IsHeading)
                    objStreamWriter.WriteLine("--------------------------------------------------------------------------------------");
                objStreamWriter.WriteLine(line);
                if (!IsHeading)
                    objStreamWriter.WriteLine();
                if (IsHeading)
                    objStreamWriter.WriteLine("--------------------------------------------------------------------------------------");
                IsSuccess = true;
            }


            // Read and show each line from the file.
            //string line = "";
            //using (StreamReader sr = new StreamReader("names.txt"))
            //{
            //    while ((line = sr.ReadLine()) != null)
            //    {
            //        Console.WriteLine(line);
            //    }
            //}

            return IsSuccess;

        }

        #region HttpGetRequet
        public static string httpGetWebRequest(string APIUri)
        {
            string returnedJSON;
            try
            {
                if (!APIUri.StartsWith("http"))
                    APIUri = "http://" + APIUri;
                var httpWebRequest = (HttpWebRequest)WebRequest.Create(APIUri);
                httpWebRequest.ContentType = "application/json; charset=utf-8";
                httpWebRequest.Method = "GET";

                var response = (HttpWebResponse)httpWebRequest.GetResponse();

                using (var sr = new StreamReader(response.GetResponseStream()))
                {
                    returnedJSON = sr.ReadToEnd();
                }
                return string.IsNullOrEmpty(returnedJSON) ? "[]" : returnedJSON;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        #endregion

        #region HttpPostRequet
        public static string httpPostWebRequest(string APIUri)
        {
            string returnedJSON;
            try
            {
                if (!APIUri.StartsWith("http"))
                    APIUri = "http://" + APIUri;
                var httpWebRequest = (HttpWebRequest)WebRequest.Create(APIUri);
                httpWebRequest.ContentType = "application/json; charset=utf-8";
                httpWebRequest.Method = "POST";

                var response = (HttpWebResponse)httpWebRequest.GetResponse();

                using (var sr = new StreamReader(response.GetResponseStream()))
                {
                    returnedJSON = sr.ReadToEnd();
                }
                return string.IsNullOrEmpty(returnedJSON) ? "[]" : returnedJSON;
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
        #endregion
    }
}
