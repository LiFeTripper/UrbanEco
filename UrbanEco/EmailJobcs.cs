using Quartz;
using System;
using System.Diagnostics;
using System.Net;
using System.Net.Mail;
using System.Threading.Tasks;

namespace UrbanEco
{
    public class EmailJobcs : IJob
    {
        public Task Execute(IJobExecutionContext context)
        {
            return new Task(TestPauvre);
        }

        public void test() {
            using (var message = new MailMessage("theverygoodteam@gmail.com", "will_1998@hotmail.fr"))
            {
                message.Subject = "Test";
                message.Body = "Test at " + DateTime.Now;
                using (SmtpClient client = new SmtpClient
                {
                    EnableSsl = true,
                    Host = "smtp.gmail.com",
                    Port = 587,
                    Credentials = new NetworkCredential("theverygoodteam@gmail.com", "DreamTeam")
                })
                {
                    client.Send(message);
                }
            }
        }

        public void TestPauvre()
        {
            Process.Start("notepad.exe");
        }

    }
}