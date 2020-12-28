param([string]$a)

<# Custom URL Scheme 
브라우저에 아래와 같이 입력한다. 
iwsviewer://launch?IP=106.240.249.74&PORT=15221&ID=0522&PW=NULL&SITE=LS&PLAYMODE=0&BASEGRID=1&GRIDMENU=16&PLAYLIST=1&INSTANCE=1 

파워쉘 테스트 
> .\test.ps1 "iwsviewer:\\launch?IP=106.240.249.74&PORT=15221&ID=0522&PW=NULL&TITLE=m+CAM&SITE=LS&PLAYMODE=0&BASEGRID=1&GRIDMENU=16&PLAYLIST=1&INSTANCE=1"


Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\iwsviewer]
"URL protocol"=""
[HKEY_CLASSES_ROOT\iwsviewer\shell]
[HKEY_CLASSES_ROOT\iwsviewer\shell\open]
[HKEY_CLASSES_ROOT\iwsviewer\shell\open\command]
@="powershell -file \"D:\\App\\Dropbox\\tools\\CustomURL\\runviewer.ps1\" %1\""

# for commercial
powershell -WindowStyle Hidden -file "D:\App\Dropbox\tools\CustomURL\runviewer.ps1" %1"

#>

Write-Host "

LIVEVIEW Custom URL Scheme TEST 

INPUT : [ $a ]

"

$PARAMS = ""

$list = $a.Split('&')

Write-Host "COUNT : " $list.Count  

<# Parsing Rules
    1st parameters : launch?IP=xxx.xxx.xxx.xxx
    2nd parameters : &PORT=15221 
    3th parameters : ... 
#> 

Write-Host $list[0].Split('?')[1]

$PARAMS = $PARAMS + $list[0].Split('?')[1]

for ( $i=1 ; $i -lt $list.Count ; $i++)
{
    Write-Host $list[$i]
    $PARAMS = $PARAMS + ' ' + $list[$i]
}

Read-Host "Please enter "

<# 
run program 
#>
Start-Process -FilePath "C:\IIOT-LIVEVIEW\LIVEVIEW.exe" -ArgumentList $PARAMS
 
<#  
Start-Sleep 10 
#>



