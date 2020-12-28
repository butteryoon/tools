#!/bin/sh
# Create index.html
# 생성일자 기준 내림차순 정렬
#################################### 

# ls -R -lt > list.txt

output_file="${PWD}/index.html"

echo ${output_file}

echo "<html><head>Packages list</head>
<style>
table, th, td {
	  border: 1px solid black;
	  border-collapse: collapse;
}
th, td {
	  padding: 5px;
      text-align: left;    
}
tr:nth-child(even) {
      background-color: #dddddd;
}
</style>
<body><p>" > ${output_file}
echo "<table style="width:100%">
<tr><td>link</td><td>Size</td><td>date</td><td>hour</td></tr>
" >> ${output_file}

find ${current_dir} -type f | grep -v '.git' | xargs ls -R -lt | awk -F' ' '{print "<tr><td><a href="$9">"$9"</a></td><td>"$5"</td><td> "$6" "$7"</td><td> "$8"</td></tr>"}' >> ${output_file}

echo "</tr></table></body>
</html>" >> ${output_file}

exit
