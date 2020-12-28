

## 공공데이타 포털 COVID API 

일반 인증키 (UTF-8)		NsIHAIJjEw2Bv......IoRbw%3D%3D  
End Point				http://openapi.data.go.kr/openapi/service/rest/Covid19  
데이터포맷	            XML  


## xmllint 로 XML 파싱 

curl http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson\?serviceKey\=SERVICE_KEY\&pageNo\=1\&numOfRows\=10\&startCreateDt\=20200903\&endCreateDt\=20200904  | xmllint --format  -   

## xmllint 

$ sudo apt install libxml2-utils  
