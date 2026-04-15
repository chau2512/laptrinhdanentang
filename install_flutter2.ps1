$toolingDir = "e:\laptrinhdanentang\tooling"
if (-Not (Test-Path $toolingDir)) {
    New-Item -ItemType Directory -Force -Path $toolingDir
}

# Download and extract MinGit
$gitZip = "$env:TEMP\mingit.zip"
if (-Not (Test-Path "$toolingDir\git\cmd\git.exe")) {
    Write-Host "Downloading MinGit..."
    Invoke-WebRequest -Uri "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/MinGit-2.44.0-64-bit.zip" -OutFile $gitZip
    Write-Host "Extracting MinGit..."
    Expand-Archive -Path $gitZip -DestinationPath "$toolingDir\git" -Force
}

# Download and extract Flutter
$flutterZip = "$env:TEMP\flutter.zip"
if (-Not (Test-Path "$toolingDir\flutter\bin\flutter.bat")) {
    Write-Host "Downloading Flutter..."
    Invoke-WebRequest -Uri "https://storage.googleapis.com/flutter_infra_release/releases/stable/windows/flutter_windows_3.24.3-stable.zip" -OutFile $flutterZip
    Write-Host "Extracting Flutter..."
    Expand-Archive -Path $flutterZip -DestinationPath "$toolingDir" -Force
}

# Add to user PATH permanently
$userPath = [Environment]::GetEnvironmentVariable("Path", "User")
$addPath = "$toolingDir\git\cmd;$toolingDir\flutter\bin"
if ($userPath -notlike "*$toolingDir*") {
    [Environment]::SetEnvironmentVariable("Path", "$userPath;$addPath", "User")
}

Write-Host "Installation Complete."
