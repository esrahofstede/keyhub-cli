$ErrorActionPreference = 'Stop';

$packageName= 'keyhub-cli'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = 'https://files.topicus-keyhub.com/manual/keyhub-cli-15.1.zip'
  checksum = 'FBD72088D24CD8D562E15F5BE7E4EAB5246AFB8EBC4BAD0D5C7D4FEDCDFE5B18'
  checksumType = 'sha256'
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyZipPackage @packageArgs

## Unzips a file to the specified location - auto overwrites existing content
## - https://chocolatey.org/docs/helpers-get-chocolatey-unzip
# Get-ChocolateyUnzip @packageArgs -destination $toolsDir -fileFullPath $fileLocation 
Install-ChocolateyPath -pathToInstall $toolsDir  -pathType 'Machine'
