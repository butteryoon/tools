#
# Owncast using ffmpeg in Windows10 
#
# ffmpeg.exe -hide_banner -h encoder=h264_nvenc
# ISSUE
# audio codec linmp3lame : Error number -10054 occurred 
#

$streamUrl = "rtmp://awsome.duckdns.org:1935/live"
$streamKey = "butter0803"

$bitRateV = "2048k"
$bitRateA = "128k"
$videoSize = "1920x1080"
#$acodec = "libmp3lame"
$acodec = "aac" 
$bufSize = "512k"
$preset = "fast"
$threadQueueSize = "512"

$StreamingURL = "$streamUrl" + "/" + "$streamKey" 

ffmpeg -f gdigrab -framerate 30 -video_size $videoSize `
  -i desktop -thread_queue_size $threadQueueSize `
  -f dshow -i audio="마이크 배열(Realtek High Definition Audio)" `
  -deinterlace -vcodec h264_nvenc -qp 0 -pix_fmt yuv420p `
  -preset $preset -r 30 -g 60 -b:v $bitRateV `
  -acodec $acodec -ar 44100 -threads 8 -qscale 3 -b:a $bitRateA `
  -bufsize $bufSize `
  -f flv $StreamingURL 


