function desinstalarOffice($versao){

    if($versao -eq '2019'){
    
            
        \\srvlansweeper\DefaultPackageShare$\Installers\Office\2019\Desinstalar\setup.exe /configure \\srvlansweeper\DefaultPackageShare$\Installers\Office\2019\Desinstalar\config.xml
            

    }elseif($versao -eq '2016'){
    
        
        \\srvlansweeper\Office\2016\setup.exe /uninstall Standard /config \\srvlansweeper\Office\2016\config_uninstall.xml

    }elseif($versao -eq '2013'){
    
    
        \\srvlansweeper\Office\2013\setup.exe /uninstall Standard /config \\srvlansweeper\Office\2013\config_uninstall.xml


    }elseif($versao -eq '2010'){
    
        \\srvlansweeper\Office\2010\setup.exe /uninstall Standard /config \\srvlansweeper\Office\2010\config_uninstall.xml
        

    }else{
    
        return 'Nenhuma versão detectada na máquina'

    }



}

## Destruir todos los processos del office antes :D"

Get-Process | ? {($_.ProcessName -like '*office*' -or $_.ProcessName -like '*word*' -or $_.ProcessName -like '*excel*' -or $_.ProcessName -like '*outlook*' -or $_.ProcessName -like '*powerp*')} | Stop-Process -Force -Confirm:$false

## Buscar se existe Office no Registro


$32bit = Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, UninstallString

$64bit = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, UninstallString

$total = $64bit + $32bit

$versao

$query = ($total | ? DisplayName -like 'Microsoft Office Standard*')[0].DisplayName




$versao = switch -Wildcard ($query){

    '*2016*' {'2016'}
    '*2019*' {'2019'}
    '*2013*' {'2013'}
    '*2010*' {'2010'}
}


$64bit > C:\64bit.txt
$query > C:\query.txt
$versao > C:\versao.txt
$32bit > C:\32bit.txt

$exec = desinstalarOffice $versao

$exec > C:\log_ls_office.txt