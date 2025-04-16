# 设置语言为英文（美国）
$env:LANG = "en_US.UTF-8"
$env:LC_ALL = "en_US.UTF-8"
$env:LC_MESSAGES = "en_US.UTF-8"

# 设置字符集为 UTF-8
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'
$PSDefaultParameterValues['Set-Content:Encoding'] = 'utf8'
$PSDefaultParameterValues['Add-Content:Encoding'] = 'utf8'

$env:HTTP_PROXY = "http://127.0.0.1:7890"
$env:HTTPS_PROXY = "http://127.0.0.1:7890"
$env:NO_PROXY = "localhost,127.0.0.1"

# # 获取配置文件目录
# $profileDirectory = Split-Path -Path $PROFILE

# # 构建 "Modules" 目录的完整路径
# $modulesPath = Join-Path -Path $profileDirectory -ChildPath "Modules"

# # 确保 "Modules" 目录存在，如果不存在则创建它
# if (!(Test-Path -Path $modulesPath -PathType Container)) {
#     New-Item -ItemType Directory -Path $modulesPath -Force | Out-Null
# }

# # 获取现有的 PSModulePath
# $existingPSModulePath = $env:PSModulePath

# # 检查新的 Modules 路径是否已经存在于 PSModulePath 中，避免重复
# if ($existingPSModulePath -notcontains $modulesPath) {
#     # 构建新的 PSModulePath 字符串
#     $env:PSModulePath = "$modulesPath$([System.IO.Path]::PathSeparator)$existingPSModulePath"
# }

# # 可选：打印新的 PSModulePath 以进行验证
# Write-Host "PSModulePath updated to: $($env:PSModulePath)"

function wingot {
  param (
      [Parameter(ValueFromRemainingArguments = $true)]
      $options
  )

  # Microsoft.Winget.Client.exe @options --proxy http://127.0.0.1:7890
  winget @options --proxy http://127.0.0.1:7890
}

function makelink {
  param (
    [string]$Source,
    [string]$Destination
  )

  try {
    New-Item -ItemType SymbolicLink -Path $Destination -Target $Source -Force
    # Write-Host "Successfully created symbolic link: '$Destination' -> '$Source'"
  }
  catch {
    Write-Error "Failed to create symbolic link: $($_.Exception.Message)"
  }
}

# enable completion in current shell, use absolute path because PowerShell Core not respect $env:PSModulePath
Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion"
Import-Module posh-git
Import-Module git-aliases -DisableNameChecking
