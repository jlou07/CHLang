# Script to define regional settings on Azure Virtual Machines deployed from the market place
# Author: Created by Alexandre Verkinderen, modified by Jean-Loup Orgitello
# Blogpost: https://mscloud.be/configure-regional-settings-and-windows-locales-on-azure-virtual-machines/
#
######################################33

#variables
$regionalsettingsURL = "https://raw.githubusercontent.com/jlou07/CHLang/main/CHRegion.xml"
$RegionalSettings = "C:\CHRegion.xml"


#downdload regional settings file
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($regionalsettingsURL,$RegionalSettings)


# Set Locale, language etc. 
& $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"$RegionalSettings`""

# Set languages/culture. Not needed perse.
Set-WinSystemLocale fr-CH
Set-WinUserLanguageList -LanguageList fr-CH -Force
Set-Culture -CultureInfo fr-CH
Set-WinHomeLocation -GeoId 223
Set-TimeZone -Name "W. Europe Standard Time"

# restart virtual machine to apply regional settings to current user. You could also do a logoff and login.
Start-sleep -Seconds 40
Restart-Computer