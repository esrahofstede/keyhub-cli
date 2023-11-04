﻿$ErrorActionPreference = 'Stop';

$packageName= 'keyhub-cli'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = 'https://files.topicus-keyhub.com/manual/keyhub-cli-29.zip'
  checksum = 'D19D5DFD48F79908655CDE9F85882E56D306FF6D8F9A356E8962C5205D026ED9'
  checksumType = 'sha256'
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyZipPackage @packageArgs

## Unzips a file to the specified location - auto overwrites existing content
## - https://chocolatey.org/docs/helpers-get-chocolatey-unzip
# Get-ChocolateyUnzip @packageArgs -destination $toolsDir -fileFullPath $fileLocation 
# Install-ChocolateyPath -pathToInstall $toolsDir  -pathType 'Machine'
Install-BinFile -Name keyhub -Path $toolsDir/keyhub.cmd
