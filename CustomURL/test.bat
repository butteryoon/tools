
echo.-- Split the date into weekday, month, day, and year, using slash and space as delimiters
for /f "tokens=1,2,3,4,5,6 delims=,/" %%a in ("TEST://IP=106.243.121.204,ID=softroom,PW=NULL,SITE=LS,MULTI=1/") do set wday=%%b&set month=%%c&set day=%%d&set year=%%e&set multi=%%f

echo LIVEVIEW %wday% %month% %day% %year% %multi%
