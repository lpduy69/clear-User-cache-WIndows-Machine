Write-Host -ForegroundColor Green "Users list"

dir C:\Users | select Name | Export-Csv -Path C:\Users\$env:USERNAME\users.csv -NoTypeInformation

$list=Test-Path C:\Users\$env:USERNAME\users.csv

Write-Host -ForegroundColor Green "Cleaning user font cache "
get-childitem -path $env:systemroot\ServiceProfiles\LocalService\AppData\Local -filter *font*.dat | del -EA SilentlyContinue

Write-Host -ForegroundColor Green "Cleaning caches Excel"
get-childitem -Path C:\Users\*\AppData\Local\Assembly\DL3 | del -Recurse -Force -EA SilentlyContinue

Write-Host -ForegroundColor Green "Cleaning cache IE, Java, Chrome, Mozilla"

if ($list) {

    Write-Host -ForegroundColor Green "Cleaning Mozilla Cache"

    Import-CSV -Path C:\Users\$env:USERNAME\users.csv -Header Name | foreach {

            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default*\cache\* -Recurse -Force -EA SilentlyContinue -Verbose

            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default*\cache\*.* -Recurse -Force -EA SilentlyContinue -Verbose

			Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default*\cache2\entries\* -Recurse -Force -EA SilentlyContinue -Verbose

            Remove-Item -path C:\Users\$($_.Name)\AppData\Local\Mozilla\Firefox\Profiles\*.default*\thumbnails\* -Recurse -Force -EA SilentlyContinue -Verbose

            }

    Write-Host -ForegroundColor Green "Cleaning Completed"
	

    Write-Host -ForegroundColor Green "Cleaning Chrome Cache"

    Import-CSV -Path C:\Users\$env:USERNAME\users.csv -Header Name | foreach {

            Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -EA SilentlyContinue -Verbose

			Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Cache2\entries\*" -Recurse -Force -EA SilentlyContinue -Verbose
			
			Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Code Cache\js\*" -Recurse -Force -EA SilentlyContinue -Verbose

            Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Google\Chrome\User Data\Default\Media Cache" -Recurse -Force -EA SilentlyContinue -Verbose

            }

    Write-Host -ForegroundColor Green "Cleaning Completed"


    Write-Host -ForegroundColor Green "Cleaning cache IE & Java"

    Write-Host -ForegroundColor yellow "Clearing Google caches"

    Import-CSV -Path C:\Users\$env:USERNAME\users.csv | foreach {

        Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Windows\Temporary Internet Files\*" -Recurse -Force -EA SilentlyContinue -Verbose
		
		Remove-Item -path "C:\Users\$($_.Name)\AppData\LocalLow\sun\Java\Deployment\cache\*" -Recurse -Force -EA SilentlyContinue -Verbose
		
		Remove-Item -path "C:\Users\$($_.Name)\AppData\Local\Microsoft\Terminal Server Client\Cache\*" -Recurse -Force -EA SilentlyContinue -Verbose

            }

    Write-Host -ForegroundColor Green "Cleaning Completed"

    } else {

	Write-Host -ForegroundColor Yellow "Cleaning failed"	

	Exit

	}
