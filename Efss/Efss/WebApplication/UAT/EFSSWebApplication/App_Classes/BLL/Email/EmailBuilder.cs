using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using APP.Common;
using APP.Session;
using RAD.Common;

namespace APP.Email
{
    public class EmailBuilder
    {
        private static string GetEmailFrom(int emailid)
        {
            string emailFrom;
            var emails = new List<APP.Search.CompanyEmails>();
            emails = APP.Search.CompanyEmails.CompanyEmailsList();
            var emailF = emails.Where(g => (int)g.EmailId == emailid).Select(e => e.EmailDublin);
            emailFrom = Convert.ToString(emailF.Single());
            return emailFrom;
        }

        public static string GetEmailTo(int buyerid)
        {
            string emailTo;
            var emails = new List<APP.Search.BuyerContacts>();
            emails = APP.Search.BuyerContacts.SelectBuyerContacts(buyerid);
            var emailt = emails.Select(e => e.ContactEmail);
            if (emailt != null)
            {
                emailTo = Convert.ToString(emailt.Single());
                return emailTo;
            }
            else
            {
                return null;
            }
        }

        private static string BuildEmailSubject(int emailid)
        {
            string subject;
            var result = new List<APP.Search.CompanyEmailsDetails>();
            result = APP.Search.CompanyEmailsDetails.CompanyEmailDetails(emailid);
            var title = result.Select(b => b.Title);
            subject = Convert.ToString(title.Single());
            return subject;
        }

        private static string BuildEmailBody(int emailid)
        {
            StringBuilder emailBody = new StringBuilder();
            var result = new List<APP.Search.CompanyEmailsDetails>();
            result = APP.Search.CompanyEmailsDetails.CompanyEmailDetails(emailid);

            var header = result.Select(b => b.Header);
            emailBody.Append(Convert.ToString(header.Single()));
            emailBody.Append(StringFunction.GetNewLine(2));
            var body = result.Select(b => b.Body);
            emailBody.Append(Convert.ToString(body.Single()));
            emailBody.Append(StringFunction.GetNewLine(2));
            var footer = result.Select(b => b.Footer);
            emailBody.Append(Convert.ToString(footer.Single()));

            return emailBody.ToString();
        }

        public static void SendMailWithAttachments(int emailid, string excelpath, string pdfpath)
        {
            // Using the SMTP server
            SendEmail.MailAttachments(GetEmailFrom(emailid), GetEmailTo(Convert.ToInt32(SessionHandler.SelectedBuyerId)), BuildEmailSubject(emailid), BuildEmailBody(emailid), excelpath, pdfpath);
        }

        public static void SendMailNetherlands(int emailid, string excelpath, string pdfpath, string pdftransport)
        {
            SendEmail.MailAttachmentsNetherlands(GetEmailFrom(emailid), GetEmailTo(Convert.ToInt32(SessionHandler.SelectedBuyerId)), BuildEmailSubject(emailid), BuildEmailBody(emailid), excelpath, pdfpath, pdftransport);
        }

    }
}