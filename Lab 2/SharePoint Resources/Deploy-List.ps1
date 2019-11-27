# Install the required modules
Install-Module SharePointPnPPowerShellOnline -Force -ErrorAction SilentlyContinue -Scope CurrentUser

# Collect user inputs
[string]$tenancy = Read-Host "Enter the URL of the tenancy e.g. https://packt.sharepoint.com"
[PSCredential]$cred = Get-Credential

# Site Details
[string]$site = "Griffton IT Assets2"

# Connect to the tenancy root site to establish connection
Connect-PnPOnline -Url $tenancy -Credentials $cred

# Create the SharePoint Site
$site = New-PnPSite -Type TeamSite -Title $site -Alias $site.Replace(" ", "") -Description "Site created for Lab 2"

# Connect to the newly created site
Connect-PnPOnline -Url $site -Credentials $cred

# Create the SharePoint list
New-PnPList -Title "Assets" -Url "Assets" -Template GenericList -OnQuickLaunch

# Get the list so that we can add columns
$list = Get-PnPList "Assets"

# Add the columns
Add-PnPField -DisplayName "Asset Type" -InternalName "AssetType" -Type Choice -Choices "Laptop", "Desktop", "Monitor", "Camera" -List $list
Add-PnPField -DisplayName "Item Description" -InternalName "ItemDescription" -Type Note -List $list
Add-PnPField -DisplayName "Received Date" -InternalName "ReceivedDate" -Type DateTime -List $list
Add-PnPField -DisplayName "Issue Date" -InternalName "IssueDate" -Type DateTime -List $list
Add-PnPField -DisplayName "Issued To" -InternalName "IssuedTo" -Type User -List $list

# Confirm Creation
Write-Host "Your site has now finished creating." 

# Launch the site
Start-Process $site
