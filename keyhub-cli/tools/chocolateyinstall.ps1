$ErrorActionPreference = 'Stop';

$packageName= 'keyhub-cli'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = 'https://files.topicus-keyhub.com/manual/keyhub-cli-19.3.zip'
  checksum = '223E842013173C61305D924A8C90FAAC2844E642E17F6940AF4B48F120446531'
  checksumType = 'sha256'
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyZipPackage @packageArgs

## Unzips a file to the specified location - auto overwrites existing content
## - https://chocolatey.org/docs/helpers-get-chocolatey-unzip
# Get-ChocolateyUnzip @packageArgs -destination $toolsDir -fileFullPath $fileLocation 
# Install-ChocolateyPath -pathToInstall $toolsDir  -pathType 'Machine'
Install-BinFile -Name keyhub -Path $toolsDir/keyhub.cmd
