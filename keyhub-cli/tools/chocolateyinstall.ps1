$ErrorActionPreference = 'Stop';

$packageName= 'keyhub-cli'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = 'https://files.topicus-keyhub.com/manual/keyhub-cli-32.zip'
  checksum = 'B46F1356AE545E844881DA1DFCD349764E92C1F4822BD4937E4AC54AA4D509FC'
  checksumType = 'sha256'
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyZipPackage @packageArgs

## Unzips a file to the specified location - auto overwrites existing content
## - https://chocolatey.org/docs/helpers-get-chocolatey-unzip
# Get-ChocolateyUnzip @packageArgs -destination $toolsDir -fileFullPath $fileLocation 
# Install-ChocolateyPath -pathToInstall $toolsDir  -pathType 'Machine'
Install-BinFile -Name keyhub -Path $toolsDir/keyhub.cmd
