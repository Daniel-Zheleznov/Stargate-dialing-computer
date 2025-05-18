@echo off
del my_code.zip

7z a -tzip my_code.zip .

echo %ROKU_ADDR%
curl --silent -w "Status code: %%{http_code}\n" --digest -u rokudev:%ROKU_PASS% -F "mysubmit=Install" -F "archive=@./my_code.zip" "http://%ROKU_ADDR%/plugin_install"