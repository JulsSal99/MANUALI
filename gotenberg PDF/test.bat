@echo off

curl.exe ^
  --request POST ^
  --url "http://192.168.1.144:3000/forms/chromium/convert/html" ^
  --form "files=@test.html;filename=index.html" ^
  --output risultato.pdf

pause