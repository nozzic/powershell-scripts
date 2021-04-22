"""
Author: nozzic
Version 1.0
Creates new task wil run 2 minutes after it has been created. Then it will run after each hour.
If it 12:00 then the task will run for the first time at 12:02 then 13:02, etc.
The task will run as SYSTEM which is not safe at all. It would be safe to create a new service account and only use it to run this script.

Credits:

I did use the answer from Dawid K. on StackOverflow to make this
https://stackoverflow.com/a/48180200/11847836
"""
$addtime = New-TimeSpan -Minutes 2
$date = (get-date) + $addtime
$action = New-ScheduledTaskAction -Execute 'C:\salt\bin\python.exe' -Argument 'C:\Tools\agent\agent.py'
$trigger = New-ScheduledTaskTrigger -Once -At $date -RepetitionInterval (New-TimeSpan -Hours 1)
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "AgentHourly" -Description "Run agent.py every hour" -User 'System'