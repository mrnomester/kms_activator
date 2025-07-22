# Функция для проверки прав администратора
function Test-IsAdmin {
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($identity)
    return $principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}

# Проверяем, запущен ли скрипт с правами администратора
if (-not (Test-IsAdmin)) {
    Write-Host "Скрипт не запущен с правами администратора. Перезапускаем с повышенными правами..."
    
    # Получаем полный путь к текущему скрипту
    $scriptPath = $MyInvocation.MyCommand.Definition
    
    # Запускаем скрипт с повышенными правами
    Start-Process -FilePath "powershell.exe" -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`"" -Verb RunAs
    exit
}

irm https://get.activated.win | iex