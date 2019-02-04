using Quartz;
using Quartz.Impl;
using System;
using System.Threading.Tasks;


namespace UrbanEco
{
    public class JobScheduler
    {
        public static IScheduler Start()
        {
            IScheduler scheduler = StdSchedulerFactory.GetDefaultScheduler().Result;
            //scheduler.Start();

            IJobDetail job = JobBuilder.Create<EmailJobcs>().Build();

            TimeOfDay time = TimeOfDay.HourMinuteAndSecondOfDay(DateTime.UtcNow.Hour, DateTime.UtcNow.Minute, DateTime.UtcNow.Second);

            ITrigger trigger = TriggerBuilder.Create()
                .WithDailyTimeIntervalSchedule
                  (s =>
                     s.WithRepeatCount(3)
                    .OnEveryDay()
                    .StartingDailyAt(time)
                  )
                .Build();

            scheduler.ScheduleJob(job, trigger);
            scheduler.Start();
           

            return scheduler;
        }
    }
}