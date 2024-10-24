# Script to define regional settings on Azure Virtual Machines deployed from the market place
# Author: Created by Alexandre Verkinderen, modified by Jean-Loup Orgitello
# Blogpost: https://mscloud.be/configure-regional-settings-and-windows-locales-on-azure-virtual-machines/
# Blogpost: https://jlou.eu/languevm 
########################################

#variables
$regionalsettingsURL = "https://raw.githubusercontent.com/jlou07/CHLang/main/CHRegion.xml"
$RegionalSettings = "C:\Region.xml"
$Language = "fr-CH"
$GeoId = "223"
$TimeZone = "W. Europe Standard Time"
Set-WinHomeLocation -GeoId $GeoId 
Set-TimeZone -id $TimeZone

# Set Locale, language etc. 
& $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"$RegionalSettings`""
