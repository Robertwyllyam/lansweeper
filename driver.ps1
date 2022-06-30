# Checar se os drivers estão instalados

$driverName = (gwmi win32_videocontroller).Name
$processor = (gwmi win32_processor).name
$ip = (Get-NetIPAddress | Where-Object PrefixOrigin -eq "dhcp").IPAddress


$srv = "\\10.36.0.10\Suporte\RepoScritps_SD\LS"


if($ip.Split('.')[1] -ne "36"){

    
    $srv = "\\10.33.4.159\DefaultPackageShare$"

}else{


}

if(! (Test-Path C:\LansweeperLogs\Driver)){


    mkdir -Path "C:\LansweeperLogs\Driver\"

}



$log_init = "Comecei a executar pelo menos. $processor"

$log_init > c:\loginit.txt


#Verificar geração do processador

switch -Wildcard ($processor){
    
    "*650*"{$generation = "i5 650"}
    "*-8*"{$generation = "7th"}
    "*-7*"{$generation = "7th"}
    "*-6*"{$generation = "7th"}
    "*-6500*"{$generation = "7th"}
    "*-4*"{$generation = "4th"}
    "*-3*"{$generation = "3th"}
    "*-2*"{$generation = "2th"}   
    "*Duo*"{$generation = "Core2 Duo"}
    

}

$path = "$srv\Installers\Office\drivers\$generation\setup.exe"


$log += "$path


        $generation
    
"



"Caminho do srv $path"


if($driverName -like "*Basic Display*" -or $driverName -eq $null -or $driverName -eq "Citrix Indirect Display Adapter	"){

    
    
    if($generation -eq "7th"){
    
        cmd /c $path -s --report "C:\LansweeperLogs\Driver\log_driver.txt"

    }else{
    
        
        cmd /c $path -s -overwrite -report "C:\LansweeperLogs\Driver\"


    }


    
  



}else{
    
    $log += 
    
    "Já existe driver instalado nesta máquina!.
    
     Modelo: $processor

     Driver: $driveRName

     Geração: $generation


    "

    


}



$log > C:\LansweeperLogs\Driver\log_driver_deploy.txt