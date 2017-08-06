using System;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Net.Mail;
using RAD.Diagnostics;
using RAD.Common;

namespace APP.Common
{
    public class SendEmail
    {
        public static void SendApplicationEmail(string emailFrom, string emailTo, string subject, string body)
        {
            MailMessage message = new MailMessage();
            SmtpClient emailsender = new SmtpClient("hertzcom.hertz.com");  // server 
            message.From = new MailAddress(emailFrom);
            message.To.Add(emailTo);
            message.Subject = subject;
            message.Body = body;
            emailsender.DeliveryMethod = SmtpDeliveryMethod.PickupDirectoryFromIis;
            emailsender.Credentials = CredentialCache.DefaultNetworkCredentials;
            emailsender.Send(message);
        }

       

        public static void MailAttachments(string emailFrom, string emailTo, string subject, string body, string excelpath, string pdfpath)
        {
            try
            {

                string smtpServerAddress = "smtp1.hertz.com";

                if (!Servers.PingServer(smtpServerAddress))
                {

                }
                else
                {
                    //Create the new message
                    MailMessage mail = new MailMessage();

                    Attachment itemexcel = new Attachment(excelpath);

                    //Add to the mail
                    mail.Attachments.Add(itemexcel);

                    Attachment itempdf = new Attachment(pdfpath);

                    //Add to the mail
                    mail.Attachments.Add(itempdf);

                    MailAddress mailToAddress = new MailAddress(emailTo);
                    MailAddress mailFromAddress = new MailAddress(emailFrom);
                    MailPriority priority = MailPriority.Normal;
                    DeliveryNotificationOptions deliveryOptions = DeliveryNotificationOptions.OnSuccess;

                    using (mail)
                    {
                        //Add all other items
                        mail.BodyEncoding = System.Text.Encoding.Unicode;
                        mail.To.Add(mailToAddress);
                        mail.From = mailFromAddress;
                        mail.Priority = priority;
                        mail.DeliveryNotificationOptions = deliveryOptions;
                        mail.Sender = mailFromAddress;
                        mail.Subject = subject;
                        mail.Body = body;
                        mail.IsBodyHtml = false;

                        //Create an instance of SMTP Client
                        SmtpClient client = new SmtpClient();
                        client.Host = smtpServerAddress;
                        client.Port = 25;
                        //client.EnableSsl = true;
                        client.DeliveryMethod = SmtpDeliveryMethod.Network;
                        client.UseDefaultCredentials = true;

                        //Send the mail
                        try
                        {
                            //Send Mail
                            client.Send(mail);

                            //Set the result code
                            //result = ResultCode.Success;
                        }
                        catch (Exception ex)
                        {

                            StackTrace errorStackTrace = new StackTrace(true);
                            Logs.LogError(errorStackTrace, ex);
                            //this.LabelError.Text = ex.Message;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }

        }

        public static void MailAttachmentsSearchEngine(string emailFrom, string emailTo, string subject, string body, string pdfpath)
        {
            try
            {
                string smtpServerAddress = "smtp1.hertz.com";

                if (!Servers.PingServer(smtpServerAddress))
                {

                }
                else
                {
                    //Create the new message
                    MailMessage mail = new MailMessage();

                    Attachment itempdf = new Attachment(pdfpath);

                    //Add to the mail
                    mail.Attachments.Add(itempdf);

                    MailAddress mailToAddress = new MailAddress(emailTo);
                    MailAddress mailFromAddress = new MailAddress(emailFrom);
                    MailPriority priority = MailPriority.Normal;
                    DeliveryNotificationOptions deliveryOptions = DeliveryNotificationOptions.OnSuccess;

                    using (mail)
                    {
                        //Add all other items
                        //mail.BodyEncoding = System.Text.Encoding.UTF8;
                        mail.To.Add(mailToAddress);
                        mail.From = mailFromAddress;
                        mail.Priority = priority;
                        mail.DeliveryNotificationOptions = deliveryOptions;
                        mail.Sender = mailFromAddress;
                        mail.Subject = subject;
                        mail.Body = body;
                        mail.IsBodyHtml = false;

                        //Create an instance of SMTP Client
                        SmtpClient client = new SmtpClient();
                        client.Host = smtpServerAddress;
                        client.Port = 25;
                        //client.EnableSsl = true;
                        client.DeliveryMethod = SmtpDeliveryMethod.Network;
                        client.UseDefaultCredentials = true;

                        //Send the mail
                        try
                        {
                            //Send Mail
                            client.Send(mail);

                            //Set the result code
                            //result = ResultCode.Success;
                        }
                        catch (Exception ex)
                        {

                            StackTrace errorStackTrace = new StackTrace(true);
                            Logs.LogError(errorStackTrace, ex);
                            //this.LabelError.Text = ex.Message;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

        public static void MailAttachmentsNetherlands(string emailFrom, string emailTo, string subject, string body, string excelpath, string pdfpath, string pdfTransport)
        {
            try
            {
                string smtpServerAddress = "smtp1.hertz.com";

                if (!Servers.PingServer(smtpServerAddress))
                {

                }
                else
                {
                    //Create the new message
                    MailMessage mail = new MailMessage();
                    
                    Attachment itemexcel = new Attachment(excelpath);

                    //Add to the mail
                    mail.Attachments.Add(itemexcel);

                    Attachment itempdf = new Attachment(pdfpath);

                    //Add to the mail
                    mail.Attachments.Add(itempdf);

                    Attachment itemtransport = new Attachment(pdfTransport);

                    //Add to the mail
                    mail.Attachments.Add(itemtransport);

                    MailAddress mailToAddress = new MailAddress(emailTo);
                    MailAddress mailFromAddress = new MailAddress(emailFrom);
                    MailPriority priority = MailPriority.Normal;
                    DeliveryNotificationOptions deliveryOptions = DeliveryNotificationOptions.OnSuccess;

                    using (mail)
                    {
                        //Add all other items
                        //mail.BodyEncoding = System.Text.Encoding.UTF8;
                        mail.To.Add(mailToAddress);
                        mail.From = mailFromAddress;
                        mail.Priority = priority;
                        mail.DeliveryNotificationOptions = deliveryOptions;
                        mail.Sender = mailFromAddress;
                        mail.Subject = subject;
                        mail.Body = body;
                        mail.IsBodyHtml = false;

                        //Create an instance of SMTP Client
                        SmtpClient client = new SmtpClient();
                        client.Host = smtpServerAddress;
                        client.Port = 25;
                        //client.EnableSsl = true;
                        client.DeliveryMethod = SmtpDeliveryMethod.Network;
                        client.UseDefaultCredentials = true;

                        //Send the mail
                        try
                        {
                            //Send Mail
                            client.Send(mail);
                        }
                        catch (Exception ex)
                        {

                            StackTrace errorStackTrace = new StackTrace(true);
                            Logs.LogError(errorStackTrace, ex);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                StackTrace errorStackTrace = new StackTrace(true);
                Logs.LogError(errorStackTrace, ex);
            }
        }

    }
}