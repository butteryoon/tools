
$streamUrl = "rtmp://192.168.0.92:1955/01022330523"
$streamKey = "ffmpeg"
$bitRate = "4500k"

$StreamingURL = "$streamUrl" + "/" + "$streamKey" 

ffmpeg -f gdigrab -framerate 30 -video_size 1920x1080 -i desktop -f dshow -i audio="마이크 배열(Realtek High Definition Audio)" -deinterlace -vcodec h264_nvenc -qp 0 -pix_fmt yuv420p -preset medium -r 30 -g 60 -b:v $bitRate -acodec libmp3lame -ar 44100 -threads 6 -qscale 3 -b:a 712000 -bufsize 512k -f flv $StreamingURL
