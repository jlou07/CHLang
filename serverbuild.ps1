# Script to define regional settings on Azure Virtual Machines deployed from the market place
# Author: Created by Alexandre Verkinderen, modified by Jean-Loup Orgitello
# Blogpost: https://mscloud.be/configure-regional-settings-and-windows-locales-on-azure-virtual-machines/
#
########################################

#variables
$regionalsettingsURL = "https://raw.githubusercontent.com/jlou07/CHLang/main/CHRegion.xml"
$RegionalSettings = "C:\Region.xml"
$Language = "fr-CH"
$GeoId = "223"
$TimeZone = "W. Europe Standard Time"

#LanguagePack Suisse
Install-Language $Language

#downdload regional settings file
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($regionalsettingsURL,$RegionalSettings)

#LanguagePack USA
unInstall-Language "en-US"
Start-sleep -Seconds 120

# Set languages/culture. Not needed perse.
Set-WinSystemLocale $Language
Set-WinUserLanguageList -LanguageList $Language -Force
Set-Culture -CultureInfo $Language
Set-WinHomeLocation -GeoId $GeoId 
Set-TimeZone -id $TimeZone

# Set Locale, language etc. 
& $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"$RegionalSettings`""

# restart virtual machine to apply regional settings to current user. 
Start-sleep -Seconds 40
Restart-Computer
