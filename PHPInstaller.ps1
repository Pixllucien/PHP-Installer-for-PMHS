# This script can be executed directly from a GitHub URL using the following command:
# iex (New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/Pixllucien/PHP-Installer-for-PMHS/refs/heads/main/PHPInstaller.ps1')
# Replace https://raw.githubusercontent.com/Pixllucien/PHP-Installer-for-PMHS/refs/heads/main/PHPInstaller.ps1' with your actual raw script URL.

# License agreement
$licenseAgreement = @"
This script is free to use. By using this script, you agree to acknowledge Pixl_lucien as the author.
If you continue using this script, it implies that you agree to these terms.
"@

Write-Output $licenseAgreement
Start-Sleep -Seconds 5  # Wait for 5 seconds

# Promotional message
Write-Output "Script by Pixl_lucien"
Write-Output "Check out my GitHub profile: https://github.com/Pixllucien"
Start-Sleep -Seconds 5  # Wait for 5 seconds

# Check if PHP 8.2 is installed
$phpVersion = php -v 2>&1
if ($phpVersion -like "*PHP 8.2*") {
    Write-Output "PHP 8.2 is already installed."
} else {
    # Prompt the user for PHP installation
    $phpUserInput = Read-Host -Prompt "PHP 8.2 is not installed. Do you want to install it? (y/n)"
    if ($phpUserInput -eq 'y') {
        # Install PHP 8.2 using winget
        winget install --id=PHP.PHP.8.2 -e
    } else {
        Write-Output "PHP 8.2 installation cancelled."
    }
}

# Check if VS Code is installed
$vsCodeVersion = winget list --id=Microsoft.VisualStudioCode
if ($vsCodeVersion -like "*Microsoft Visual Studio Code*") {
    Write-Output "Visual Studio Code is already installed."
} else {
    # Prompt the user for VS Code installation
    $vsCodeUserInput = Read-Host -Prompt "Visual Studio Code is not installed. Do you want to install it? (y/n)"
    if ($vsCodeUserInput -eq 'y') {
        # Install Visual Studio Code using winget
        winget install --id=Microsoft.VisualStudioCode -e
    } else {
        Write-Output "Visual Studio Code installation cancelled."
    }
}

# Function to check if a VS Code extension is installed
function IsVSCodeExtensionInstalled {
    param (
        [string]$extensionId
    )
    $installedExtensions = code --list-extensions
    return $installedExtensions -contains $extensionId
}

# Open VS Code silently and then close it to ensure it's properly set up
try {
    Start-Process -FilePath "code" -ArgumentList "-n" -NoNewWindow
    Start-Sleep -Seconds 10  # Wait for VS Code to start
    Stop-Process -Name "Code"
} catch {
    Write-Output "Failed to open or close Visual Studio Code. Please ensure VS Code is installed and try again."
    exit
}

# Install and enable PHP Server extension
$phpServerExtensionId = "brapifra.phpserver"
if (IsVSCodeExtensionInstalled -extensionId $phpServerExtensionId) {
    Write-Output "PHP Server extension is already installed."
} else {
    # Prompt the user for PHP Server extension installation
    $phpServerUserInput = Read-Host -Prompt "PHP Server extension is not installed. Do you want to install it? (y/n)"
    if ($phpServerUserInput -eq 'y') {
        # Install PHP Server extension using VS Code Marketplace
        code --install-extension $phpServerExtensionId
    } else {
        Write-Output "PHP Server extension installation cancelled."
    }
}

# Install and enable PHP Extensions Pack
$phpExtensionsPackExtensionId = "felixfbecker.php-pack"
if (IsVSCodeExtensionInstalled -extensionId $phpExtensionsPackExtensionId) {
    Write-Output "PHP Extensions Pack extension is already installed."
} else {
    # Prompt the user for PHP Extensions Pack installation
    $phpExtensionsPackUserInput = Read-Host -Prompt "PHP Extensions Pack extension is not installed. Do you want to install it? (y/n)"
    if ($phpExtensionsPackUserInput -eq 'y') {
        # Install PHP Extensions Pack extension using VS Code Marketplace
        code --install-extension $phpExtensionsPackExtensionId
    } else {
        Write-Output "PHP Extensions Pack extension installation cancelled."
    }
}

#Open Readme.txt 
$downloadPath = "https://raw.githubusercontent.com/Pixllucien/PHP-Installer-for-PMHS/refs/heads/main/README.txt"
$savePath ="$env:TEMP\Readme.txt"
Invoke-WebRequest -Uri $downloadPath -OutFile $savePath 
$checkProcess = Start-Process -FilePath "notepad.exe" -ArgumentList $savePath -PassThru
$checkProcess.WaitForExit() 

if(-Not (Test-Path $checkProcess)) {
    Remove-Item -Path $savePath -Force 
}




