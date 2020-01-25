$ErrorActionPreference = 'Stop';


$packageName= 'keyhub-cli'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  url           = 'https://keyhub.topicusonderwijs.nl/docs/keyhub-cli-15.1.zip' # download url, HTTPS preferred

  checksum      = '78F0EBBDEE778EC10883BE9A08C902737D4A70AFB2CC1F4F6EA26574480476D6'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = '78F0EBBDEE778EC10883BE9A08C902737D4A70AFB2CC1F4F6EA26574480476D6'
  checksumType64= 'sha256'
}

# https://chocolatey.org/docs/helpers-install-chocolatey-zip-package
Install-ChocolateyZipPackage @packageArgs

## Unzips a file to the specified location - auto overwrites existing content
## - https://chocolatey.org/docs/helpers-get-chocolatey-unzip
# Get-ChocolateyUnzip @packageArgs -destination $toolsDir -fileFullPath $fileLocation 
Install-ChocolateyPath -pathToInstall $toolsDir  -pathType 'Machine'