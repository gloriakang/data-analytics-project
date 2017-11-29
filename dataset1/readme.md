# dataset1

logon_info.csv (~850k records)
* Fields: id, date, user, pc, activity (Logon/Logoff)
* Logoff requires preceding logon
* Each user has an assigned machine, but can share others
* 100 machines shared (physically shared) by some of the users in addition to their assigned PC. 
* Some logons occur after-hours 
*Note: Screen unlocks are recorded as logons. Screen locks are not recorded.
* 12 of the users are IT administrators

device_info.csv (~66k records)
* Fields: id, date, user, pc, activity (connect/disconnect)
* Some users use a portable zip drive
* Some connect(s) may be missing disconnect(s), since machine may be turned off without a proper disconnect. 


Employees_info Folder
* 18 Employee files (~1k records each file)
  - Fields: employee_name, user_id, email, domain, role
  - Record of who is employed at the end of the month 

HTTP_info.csv (~3.5M records)
* Fields: id, date, user, pc, url
* Up to 15 URLs visited daily between daily logon and daily logoff
* Up to 5 URLs visited daily after-hours


Additional Note:
Field ids are unique within a .csv file but are not necessarily unique across all files.
