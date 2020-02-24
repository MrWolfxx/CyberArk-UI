Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'

$user = $env:username
$Path = pwd
$userPath = "$Path\AppData\Users\$user"
$domainsPath = "$Path\AppData\Domains"
$imagesPath = "$Path\AppData\Images"

Function MessageWindow {
Param
(
[string]$Mensaje, 
[string]$Titulo, 
[System.Windows.Forms.MessageBoxButtons]$Botones, 
[System.Windows.Forms.MessageBoxIcon]$Icono
)
    return [System.Windows.Forms.MessageBox]::Show($Mensaje, $Titulo, $Botones, $Icono)
}

Function Watermarker
{
	if ($marker -eq "Domain") {
		if ($TextBoxUserDomain.Text -eq "Domain User") {
			$TextBoxUserDomain.Text = ""
			$TextBoxUserDomain.ForeColor = 'Black'
		}
		if ($TextBoxUserCyberArk.Text -eq "") {
			$TextBoxUserCyberArk.Text = "User Cyberark RDP"
			$TextBoxUserCyberArk.ForeColor = 'Gray'
		}
		if ($TextBoxUserSSH.Text -eq "") {
			$TextBoxUserSSH.Text = "User Cyberark SSH"
			$TextBoxUserSSH.ForeColor = 'Gray'
		} 
		if ($TextBoxUserVcenter.Text -eq "") {
			$TextBoxUserVcenter.Text = "User Cyberark Vcenter"
			$TextBoxUserVcenter.ForeColor = 'Gray'
		} 
	}
	if ($marker -eq "RDP") {    
		if ($TextBoxUserCyberArk.Text -eq "User Cyberark RDP") {
			$TextBoxUserCyberArk.Text = ""
			$TextBoxUserCyberArk.ForeColor = 'Black'
		}
		if ($TextBoxUserDomain.Text -eq "") {
			$TextBoxUserDomain.Text = "Domain User"
			$TextBoxUserDomain.ForeColor = 'Gray'
		}
		if ($TextBoxUserSSH.Text -eq "") {
			$TextBoxUserSSH.Text = "User Cyberark SSH"
			$TextBoxUserSSH.ForeColor = 'Gray'
		} 
		if ($TextBoxUserVcenter.Text -eq "") {
			$TextBoxUserVcenter.Text = "User Cyberark Vcenter"
			$TextBoxUserVcenter.ForeColor = 'Gray'
		} 
	}
	if ($marker -eq "SSH") {    
		if ($TextBoxUserSSH.Text -eq "User Cyberark SSH") {
			$TextBoxUserSSH.Text = ""
			$TextBoxUserSSH.ForeColor = 'Black'
		}
		if ($TextBoxUserDomain.Text -eq "") {
			$TextBoxUserDomain.Text = "Domain User"
			$TextBoxUserDomain.ForeColor = 'Gray'
		}
		if ($TextBoxUserCyberArk.Text -eq "") {
			$TextBoxUserCyberArk.Text = "User Cyberark RDP"
			$TextBoxUserCyberArk.ForeColor = 'Gray'
		} 
		if ($TextBoxUserVcenter.Text -eq "") {
			$TextBoxUserVcenter.Text = "User Cyberark Vcenter"
			$TextBoxUserVcenter.ForeColor = 'Gray'
		} 
	}
	if ($marker -eq "vc") {    
		if ($TextBoxUserVcenter.Text -eq "User Cyberark Vcenter") {
			$TextBoxUserVcenter.Text = ""
			$TextBoxUserVcenter.ForeColor = 'Black'
		}
		if ($TextBoxUserDomain.Text -eq "") {
			$TextBoxUserDomain.Text = "Domain User"
			$TextBoxUserDomain.ForeColor = 'Gray'
		}
		if ($TextBoxUserCyberArk.Text -eq "") {
			$TextBoxUserCyberArk.Text = "User Cyberark RDP"
			$TextBoxUserCyberArk.ForeColor = 'Gray'
		} 
		if ($TextBoxUserSSH.Text -eq "") {
			$TextBoxUserSSH.Text = "User Cyberark SSH"
			$TextBoxUserSSH.ForeColor = 'Gray'
		} 
	}
}


Function RegisterWindow
{
	$FormRegister = New-Object system.Windows.Forms.Form
	$FormRegister.StartPosition = $CenterScreen
	$FormRegister.FormBorderStyle = 'Fixed3D'
	$FormRegister.MaximizeBox = $false
	$FormRegister.Text = "USER SETTINGS"
	$Image2 = [system.drawing.image]::FromFile("$imagesPath\registro.jpg")
	$FormRegister.BackgroundImage = $Image2
	$FormRegister.BackgroundImageLayout = "None"
	$FormRegister.MaximizeBox = $false
	$FormRegister.Width = $Image2.Width
	$FormRegister.Height = $Image2.Height
	$TextBoxUserDomain.Font = $FontRegular
	$TextBoxUserCyberArk.Font = $FontRegular
	$TextBoxUserSSH.Font = $FontRegular
	$TextBoxUserVcenter.Font = $FontRegular
	$TextBoxUserCyberArk.Text = "User Cyberark RDP"
	$TextBoxUserDomain.Text = "Domain User"
	$TextBoxUserCyberArk.ForeColor = 'Gray'
	$TextBoxUserDomain.ForeColor = 'Gray'
	$TextBoxUserSSH.Text = "User Cyberark SSH"
	$TextBoxUserVcenter.Text = "User Cyberark Vcenter"
	$TextBoxUserSSH.ForeColor = 'Gray'
	$TextBoxUserVcenter.ForeColor = 'Gray'
	$FormRegister.Font = $FontBold
	$Icon2 = [system.drawing.icon]::ExtractAssociatedIcon("$imagesPath\cyber.ico")
	$FormRegister.Icon = $Icon2
	$FormRegister.Controls.Add($LabelAuthMethod)
	$FormRegister.Controls.Add($ButtonRegRadius)
	$FormRegister.Controls.Add($ButtonRegLDAP)
	$FormRegister.ShowDialog()
}

Function RegisterUsersWindow ($Registro)
{
	Watermarker
	if ($Registro -eq 1){
		$global:Registro= "1"
		$FormRegister.Controls.Remove($ButtonRegLDAP)
	}
	if ($Registro -eq 2){
		$global:Registro= "2"
		$FormRegister.Controls.Remove($ButtonRegRadius)
	}
	$FormRegister.Controls.Remove($LabelAuthMethod)
	$FormRegister.Controls.Add($TextBoxUserDomain)
	$FormRegister.Controls.Add($TextBoxUserCyberArk)
	$FormRegister.Controls.Add($TextBoxUserSSH)
	$FormRegister.Controls.Add($TextBoxUserVcenter)
	$FormRegister.Controls.Add($LabelEnterUsers)
	$FormRegister.Controls.Add($LabelUserRDP)
	$FormRegister.Controls.Add($LabelUserSSH)
	$FormRegister.Controls.Add($LabelUserVcenter)
	$FormRegister.Controls.Add($LabelUserDomain)
	$FormRegister.Controls.Add($ButtonSignIn)
}


Function RegisterUsersWindowOK ($Registro)
{   
	if ($TextBoxUserDomain.Text -eq "Domain User" -or [string]::IsNullOrWhitespace($TextBoxUserDomain.Text))
	{
		MessageWindow -Mensaje "Complete Domain User correctly!" -Titulo "ERROR" -Botones OK -Icono Error
	} else {
		$DomainUser=$TextBoxUserDomain.Text -replace " ","" -replace "\t",""
		$UserCyberArkRDP=$TextBoxUserCyberArk.Text -replace " ","" -replace "\t",""
		$UserCyberArkSSH=$TextBoxUserSSH.Text -replace " ","" -replace "\t",""
		$UserCyberArkVcenter=$TextBoxUserVcenter.Text -replace " ","" -replace "\t",""
		if ($Registro -eq 1) {$Autenticacion = "RADIUS"}
		if ($Registro -eq 2) {$Autenticacion = "LDAP"}
		if (Test-Path -path "$userPath\config") {$lastImage=((Get-Content "$userPath\config" | Select-String ImageProfile).ToString()).Split("=")[1]}
		Set-Content "$userPath\config" "Authentication=$Autenticacion"
		Add-Content "$userPath\config" "DomainUser=$DomainUser"
		if ($TextBoxUserCyberArk.Text -ne "User Cyberark RDP"){Add-Content "$userPath\config" "UserCyberArkRDP=$UserCyberArkRDP"} else {Add-Content "$userPath\config" "UserCyberArkRDP="}
		if ($TextBoxUserSSH.Text -ne "User Cyberark SSH"){Add-Content "$userPath\config" "UserCyberArkSSH=$UserCyberArkSSH"} else {Add-Content "$userPath\config" "UserCyberArkSSH="}
		if ($TextBoxUserVcenter.Text -ne "User Cyberark Vcenter"){Add-Content "$userPath\config" "UserCyberArkVcenter=$UserCyberArkVcenter"} else {Add-Content "$userPath\config" "UserCyberArkVcenter="}
		Add-Content "$userPath\config" "ImageProfile=$lastImage"
		$ComboBoxSSHUser.Items.Clear()
		$UsersSSH=((Get-Content "$userPath\config" | Select-String UserCyberArkSSH).ToString()).Split("=")[1].Split("|")
		foreach ($UserSSH in $UsersSSH) {
			$ComboBoxSSHUser.Items.Add($UserSSH)
		}
		$ComboBoxSSHUser.SelectedItem=$ComboBoxSSHUser.Items[0]
		MessageWindow -Mensaje "Users configured correctly!" -Titulo "Info" -Botones OK -Icono Information
		$FormRegister.Close()
		$FormCyberArk.Controls.Remove($ButtonRegisterUser)
		$FormCyberArk.Controls.Add($ButtonShowUser)
		$FormCyberArk.Controls.Add($LabelUserName)
		$FormCyberArk.Controls.Add($LabelUser)
		SwitchConnection $ListBoxConnections.SelectedItem
	}
} 



Function ShowUserWindow 
{

	$FormRegister = New-Object system.Windows.Forms.Form
	$FormRegister.StartPosition = $CenterScreen
	$FormRegister.FormBorderStyle = 'Fixed3D'
	$FormRegister.MaximizeBox = $false
	$FormRegister.Text = "USER SETTINGS"
	$Image2 = [system.drawing.image]::FromFile("$imagesPath\registro.jpg")
	$FormRegister.BackgroundImage = $Image2
	$FormRegister.BackgroundImageLayout = "None"
	$Icon2 = [system.drawing.icon]::ExtractAssociatedIcon("$imagesPath\cyber.ico")
	$FormRegister.Icon = $Icon2
	$FormRegister.MaximizeBox = $false
	$FormRegister.Width = $Image2.Width
	$FormRegister.Height = $Image2.Height
	$FormRegister.Font = $FontBold
	$TextBoxUserDomain.Font = $FontRegular
	$TextBoxUserCyberArk.Font = $FontRegular
	$TextBoxUserSSH.Font = $FontRegular
	$TextBoxUserVcenter.Font = $FontRegular
	$TextBoxUserCyberArk.Text = ((Get-Content "$userPath\config" | Select-String UserCyberArkRDP).ToString()).Split("=")[1] -replace " ","" -replace "\t",""
	$TextBoxUserDomain.Text = ((Get-Content "$userPath\config" | Select-String DomainUser).ToString()).Split("=")[1] -replace " ","" -replace "\t",""
	$TextBoxUserSSH.Text = ((Get-Content "$userPath\config" | Select-String UserCyberArkSSH).ToString()).Split("=")[1] -replace " ","" -replace "\t",""
	$TextBoxUserVcenter.Text = ((Get-Content "$userPath\config" | Select-String UserCyberArkVcenter).ToString()).Split("=")[1] -replace " ","" -replace "\t",""
	if ([string]::IsNullOrWhitespace($TextBoxUserDomain.Text) -or $TextBoxUserDomain.Text -eq "Domain User"){$TextBoxUserDomain.ForeColor = 'Gray';$TextBoxUserDomain.Text="Domain User"} else {$TextBoxUserDomain.ForeColor = 'Black'}
	if ([string]::IsNullOrWhitespace($TextBoxUserCyberArk.Text) -or $TextBoxUserCyberArk.Text -eq "User Cyberark RDP"){$TextBoxUserCyberArk.ForeColor = 'Gray';$TextBoxUserCyberArk.Text="User Cyberark RDP"} else {$TextBoxUserCyberArk.ForeColor = 'Black'}
	if ([string]::IsNullOrWhitespace($TextBoxUserSSH.Text) -or $TextBoxUserSSH.Text -eq "User Cyberark SSH"){$TextBoxUserSSH.ForeColor = 'Gray';$TextBoxUserSSH.Text="User Cyberark SSH"} else {$TextBoxUserSSH.ForeColor = 'Black'}
	if ([string]::IsNullOrWhitespace($TextBoxUserVcenter.Text) -or $TextBoxUserVcenter.Text -eq "User Cyberark Vcenter"){$TextBoxUserVcenter.ForeColor = 'Gray';$TextBoxUserVcenter.Text="User Cyberark Vcenter"} else {$TextBoxUserVcenter.ForeColor = 'Black'}
	$Auth=((Get-Content "$userPath\config" | Select-String Authentication).ToString()).Split("=")[1] -replace " ","" -replace "\t",""
	if ($Auth -eq "LDAP") {
		$global:Registro= "2"
		$FormRegister.Controls.Add($ButtonRegLDAP)
	} else {
		$global:Registro= "1"
		$FormRegister.Controls.Add($ButtonRegRadius)
	}
	$lastImage=((Get-Content "$userPath\config" | Select-String ImageProfile).ToString()).Split("=")[1]
	if ($lastImage) {$imageSelectImage = [System.Drawing.Image]::FromFile($lastImage)} else {$imageSelectImage = [System.Drawing.Image]::FromFile("$imagesPath\notimage.jpg")}
	$LabelUserImageProfile.Image = $imageSelectImage
	$ButtonSelectImageUser.Image = $imageSelectImage
	if ((Get-Host | Select-Object -ExpandProperty Version).major -le 2){$FormRegister.Controls.Add($LabelUserImageProfile)} else {$FormRegister.Controls.Add($ButtonSelectImageUser)}
	$FormRegister.Controls.Add($TextBoxUserDomain)
	$FormRegister.Controls.Add($TextBoxUserCyberArk)
	$FormRegister.Controls.Add($TextBoxUserSSH)
	$FormRegister.Controls.Add($TextBoxUserVcenter)
	$FormRegister.Controls.Add($LabelEnterUsers)
	$FormRegister.Controls.Add($ButtonSignIn)
	$FormRegister.Controls.Add($ButtonSwitchAuth)
	$FormRegister.Controls.Add($ButtonSelectImageUser)
	$FormRegister.Controls.Add($LabelUserRDP)
	$FormRegister.Controls.Add($LabelUserSSH)
	$FormRegister.Controls.Add($LabelUserDomain)
	$FormRegister.Controls.Add($LabelUserVcenter)
	$FormRegister.Controls.Add($LabelEncryptPass)
	$FormRegister.Controls.Add($LabelConfigPSM)
	$FormRegister.Controls.Add($ButtonConfigPSM)
	$FormRegister.Controls.Add($ButtonConfigUsers)
	$FormRegister.Controls.Add($ButtonLocker)
	$FormRegister.ShowDialog()
}

Function EncryptPass
{
	$File = "$user.pass"
	$Password = Get-Credential -Credential "Enter Password or PIN"
	if ($PassWord)
	{
		$Password = $Password.GetNetworkCredential().Password
		$Password = "$Password" | ConvertTo-SecureString -AsPlainText -Force
		$Password | ConvertFrom-SecureString | Out-File "$userPath\$File"
		MessageWindow -Mensaje "Password encrypted correctly" -Titulo "Info" -Botones OK -Icono Information
	} else {
		if (Test-Path -path "$userPath\$File") {
			Add-Type -AssemblyName PresentationCore,PresentationFramework
			$ButtonType = [System.Windows.MessageBoxButton]::YesNoCancel
			$MessageIcon = [System.Windows.MessageBoxImage]::Warning
			$MessageBody = "Password encrypted found! Do you want delete it?"
			$MessageTitle = "Warning"
			$Result = [System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
			if ($Result -eq "Yes")
			{
				rm -Force "$userPath\$File"
				MessageWindow -Mensaje "Password deleted correctly" -Titulo "Info" -Botones OK -Icono Information
			}
		}
	}
}


Function SelectImage 
{
    $OpenFile = New-Object System.Windows.Forms.OpenFileDialog
    $OpenFile.initialDirectory = "$userPath"
	$OpenFile.filter = "*.JPG;*.JPEG;*.PNG)|*.JPG;*.JPEG;*.PNG"
    $OpenFile.ShowDialog() | Out-Null
	$File = $OpenFile.filename
	if ($File) {ResizeImage $File}
}

Function ResizeImage ($File)
{
	
	if (!(Test-Path -path "$userPath\images")) {mkdir "$userPath\images"}
	
	$image = [System.Drawing.Image]::FromFile($File)
	
	$ImageWidth = 100
	$ImageHeight = 100
	$Quality = 100
	
	$ImageEncoder = [System.Drawing.Imaging.Encoder]::Quality
	$encoderParams = New-Object System.Drawing.Imaging.EncoderParameters(1)
	$encoderParams.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter($ImageEncoder, $Quality)
	
	$random=Get-Random
	
	if ($File -like "*.png")
	{
		$Codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where {$_.MimeType -eq 'image/png'}
		$OutputFile="$userPath"+"\images\"+$user+$random+".png"
	} else {
		$Codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where {$_.MimeType -eq 'image/jpeg'}
		$OutputFile="$userPath"+"\images\"+$user+$random+".jpg"
	}
	
	$bmpResized = New-Object System.Drawing.Bitmap($ImageWidth, $ImageHeight)
	$graph = [System.Drawing.Graphics]::FromImage($bmpResized)
	$graph.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
	
	$graph.Clear([System.Drawing.Color]::White)
	$graph.DrawImage($image, 0, 0, $ImageWidth, $ImageHeight)
	
	$bmpResized.Save("$OutputFile", $Codec, $($encoderParams))
	$bmpResized.Dispose()
	$image.Dispose()
	$imageSelectImage = [System.Drawing.Image]::FromFile("$OutputFile")
	$ButtonShowUser.Image = $imageSelectImage
	$ButtonSelectImageUser.Image = $imageSelectImage
	$lastImage=((Get-Content "$userPath\config" | Select-String ImageProfile).ToString()).Split("=")[1]
	(Get-Content "$userPath\config").Replace("ImageProfile=$lastImage","ImageProfile=$OutputFile") | Set-Content "$userPath\config"
}


Function AddServer
{
	$FormCyberArk.Controls.Remove($ButtonAddDomain)
    $FormCyberArk.Controls.Remove($ComboBoxServers)
    $FormCyberArk.Controls.Remove($ListBoxPCI)
    $FormCyberArk.Controls.Remove($ListBoxWinSCP)
    $FormCyberArk.Controls.Remove($ButtonConnectOK)
    $TextBoxAddServers.Font = $FontRegular
    $FormCyberArk.Controls.Add($TextBoxAddServers)
    $FormCyberArk.Controls.Add($ButtonAddServersOK)
	$Servers=Get-Content "$domainsPath\$conexion\$Dominio" | ? {$_.trim() -ne "" } | sort | Get-Unique
	$TextBoxAddServers.Text="$Servers" -replace " ","`r`n"
}

Function AddDomain
{
	$FormCyberArk.Controls.Remove($ButtonAddServers)
    $FormCyberArk.Controls.Remove($ComboBoxServers)
	$FormCyberArk.Controls.Remove($ListBoxDomains)
    $FormCyberArk.Controls.Remove($ListBoxPCI)
    $FormCyberArk.Controls.Remove($ListBoxWinSCP)
    $FormCyberArk.Controls.Remove($ButtonConnectOK)
    $TextBoxAddServers.Font = $FontRegular
	$TextBoxAddDomain.Font = $FontRegular
    $FormCyberArk.Controls.Add($TextBoxAddDomain)
	$FormCyberArk.Controls.Add($TextBoxAddServers)
    $FormCyberArk.Controls.Add($ButtonAddDomainOK)
	$TextBoxAddServers.Text=""
}

Function AddServersOK ($Servidor, $Dominio)
{
    if ([string]::IsNullOrWhitespace($TextBoxAddServers.Text)) 
	{
		MessageWindow -Mensaje "Complete the field correctly!" -Titulo "ERROR" -Botones OK -Icono Error
	} else {
		cp -Path "$domainsPath\$conexion\$Dominio" -Destination "$domainsPath\$conexion\$Dominio.old"
		$Servidor=($Servidor -replace " ","").ToLower()
        Set-Content "$domainsPath\$conexion\$Dominio" $Servidor 
		$content = Get-Content "$domainsPath\$conexion\$Dominio" | ? {$_.trim() -ne "" } | sort | Get-Unique
		$content | set-content "$domainsPath\$conexion\$Dominio"
		$Server=Compare-Object -ReferenceObject (Get-Content "$domainsPath\$conexion\$Dominio") -DifferenceObject (Get-Content "$domainsPath\$conexion\$Dominio.old") | select -ExpandProperty InputObject | select -Last 1
		rm -Force "$domainsPath\$conexion\$Dominio.old"
        MessageWindow -Mensaje "List of servers modified correctly" -Titulo "Info" -Botones OK -Icono Information
		SwitchDomain $conexion $Dominio $Server
		$TextBoxAddServers.Text = ""
    }
}

Function AddDomainOK ($Servidor, $Dominio)
{
     if ([string]::IsNullOrWhitespace($TextBoxAddDomain.Text))
	{
		MessageWindow -Mensaje "Complete the field correctly!" -Titulo "ERROR" -Botones OK -Icono Error
		
	} else {
        if (Test-Path -path "$domainsPath\$conexion\$Dominio")
		{
			Add-Type -AssemblyName PresentationCore,PresentationFramework
			$ButtonType = [System.Windows.MessageBoxButton]::YesNoCancel
			$MessageIcon = [System.Windows.MessageBoxImage]::Warning
			$MessageBody = "The specified domain already exists. If you continue, it will be removed. Are you sure to continue?"
			$MessageTitle = "Warning"
			$Result = [System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)
			if ($Result -eq "Yes")
			{
				rm -Force "$domainsPath\$conexion\$Dominio"
				MessageWindow -Mensaje " Domain $Dominio removed!" -Titulo "Info" -Botones OK -Icono Information
			}
		} else {
		
			$Dominio=($Dominio -replace " ","").ToLower()
			New-Item -Path "$domainsPath\$conexion\$Dominio" -ItemType File
			
			if (!([string]::IsNullOrWhitespace($TextBoxAddServers.Text)))
			{
				$Servidor=($Servidor -replace " ","").ToLower()
				Add-Content "$domainsPath\$conexion\$Dominio" $Servidor 
				$content = Get-Content "$domainsPath\$conexion\$Dominio" | ? {$_.trim() -ne "" } | sort | Get-Unique
				$content | set-content "$domainsPath\$conexion\$Dominio"
			}
			MessageWindow -Mensaje " Domain added correctly!" -Titulo "Info" -Botones OK -Icono Information
		}
		$FormCyberArk.Controls.Remove($TextBoxAddDomain)
		$FormCyberArk.Controls.Remove($TextBoxAddServers)
		$FormCyberArk.Controls.Remove($ButtonAddDomainOK)
		$FormCyberArk.Controls.Add($ListBoxDomains)
		$FormCyberArk.Controls.Add($ComboBoxServers)
		$FormCyberArk.Controls.Add($ButtonConnectOK)
		SwitchConnection $conexion
		$ListBoxDomains.selecteditem=$Dominio
		SwitchDomain $conexion $Dominio
		$TextBoxAddDomain.Text = ""
		$TextBoxAddServers.Text = ""
    }
}


Function createTemplateRDP
{
$TemplateRDP = @"
use multimon:i:0
session bpp:i:32
winposstr:s:0,1,40,40,1900,1000
compression:i:1
keyboardhook:i:2
audiocapturemode:i:0
videoplaybackmode:i:1
connection type:i:7
networkautodetect:i:1
bandwidthautodetect:i:1
displayconnectionbar:i:1
enableworkspacereconnect:i:0
disable wallpaper:i:0
allow font smoothing:i:0
allow desktop composition:i:0
disable full window drag:i:1
disable menu anims:i:1
disable themes:i:0
disable cursor setting:i:0
bitmapcachepersistenable:i:1
audiomode:i:0
redirectprinters:i:0
redirectcomports:i:0
redirectsmartcards:i:1
redirectclipboard:i:1
redirectposdevices:i:0
autoreconnection enabled:i:1
authentication level:i:2
prompt for credentials:i:0
negotiate security layer:i:1
remoteapplicationmode:i:0
shell working directory:s:
gatewayhostname:s:
gatewayusagemethod:i:4
gatewaycredentialssource:i:4
gatewayprofileusagemethod:i:0
promptcredentialonce:i:0
gatewaybrokeringtype:i:0
use redirection server name:i:0
rdgiskdcproxy:i:0
kdcproxyname:s:
enablecredsspsupport:i:0
"@
$TemplateRDP | Out-File "$Path\AppData\Templates\RDP.rdp"
}


Function Main
{
	if (!(Test-Path -path "$Path\AppData")) {mkdir "$Path\AppData" | Out-Null}
	if (!(Test-Path -path "$Path\AppData\Config")) {mkdir "$Path\AppData\Config" | Out-Null}
	if (!(Test-Path -path "$Path\AppData\Templates")) {mkdir "$Path\AppData\Templates" | Out-Null;createTemplateRDP}
	if (!(Test-Path -path "$imagesPath")) {MessageWindow -Mensaje "Images not found in ""$imagesPath"". Please, check it" -Titulo "ERROR" -Botones OK -Icono Error;exit 1}
	if (!(Test-Path -path "$Path\AppData\Users")) {mkdir "$Path\AppData\Users" | Out-Null}
	if (!(Test-Path -path "$Path\AppData\PuTTy")) {mkdir "$Path\AppData\PuTTy" | Out-Null}
	if (!(Test-Path -path "$userPath")) {mkdir "$userPath" | Out-Null}
	if (!(Test-Path -path "$userPath\RDP")) {mkdir "$userPath\RDP" | Out-Null}
	if (!(Test-Path -path "$domainsPath")) {mkdir "$domainsPath" | Out-Null}
	if (!(Test-Path -path "$domainsPath\WINDOWS")) {mkdir "$domainsPath\WINDOWS" | Out-Null}
	if (!(Test-Path -path "$domainsPath\UNIX")) {mkdir "$domainsPath\UNIX" | Out-Null}
	if (!(Test-Path -path "$domainsPath\VCENTER")) {mkdir "$domainsPath\VCENTER" | Out-Null}
	$ListBoxConnections.Font = $FontRegular
	$ListBoxConnections.Items.Add("WINDOWS")
	$ListBoxConnections.Items.Add("UNIX")
	$ListBoxConnections.Items.Add("VCENTER")
	$ListBoxConnections.Items.Add("RECENT")
	$ListBoxWinSCP.Items.Add("SSH")
	$ListBoxWinSCP.Items.Add("WinSCP")
	$ListBoxPCI.Items.Add("INTRANET")
	$ListBoxPCI.Items.Add("PCI")
	$ListBoxPCI.Items.Add("DMZ")
	$ComboBoxResolution.Items.Add("FullScreen")
	$ComboBoxResolution.Items.Add("1800x900")
	$ComboBoxResolution.Items.Add("1280x900")
	$ComboBoxResolution.Items.Add("1024x768")
	$ComboBoxResolution.Items.Add("800x600")
	$ComboBoxResolution.Items.Add("AutoSize")
	$ComboBoxResolution.SelectedItem="FullScreen"
	$FormCyberArk.Controls.Add($LabelResolution)
	$FormCyberArk.Controls.Add($ListBoxConnections)
	$ListBoxConnections.SelectedItem = $ListBoxConnections.Items[0]
	SwitchConnection $ListBoxConnections.SelectedItem
}


Function Connection ($Dominio,$Servidor,$PCI,$Tipo)
{
	if ((Test-Path -path "$userPath\config") -and ($Servidor))
	{	
		if (!(Test-Path -path "$Path\AppData\Config\ConfigPSM")) {ConfigPSM;return}
		if ($conexion -ne "RECENT") {if (!$ComboBoxSSHUser.SelectedItem){MessageWindow -Mensaje "The specified user is not in the list of users. Please, add it to make the connection." -Titulo "ERROR" -Botones OK -Icono Error;return}}
		$Authentication = ((Get-Content "$userPath\config" | Select-String authentication).ToString()).Split("=")[1] -replace " ","" -replace "\t",""
		$DomainUser = ((Get-Content "$userPath\config" | Select-String DomainUser).ToString()).Split("=")[1] -replace " ","" -replace "\t",""
		$PSMINTRANET=((Get-Content "$Path\AppData\Config\ConfigPSM" | Select-String PSM-INTRANET).ToString()).Split("=")[1] -replace " ","" -replace "\t",""
		$PSMPCI=((Get-Content "$Path\AppData\Config\ConfigPSM" | Select-String PSM-PCI).ToString()).Split("=")[1] -replace " ","" -replace "\t",""
		$PSMPINTRANET=((Get-Content "$Path\AppData\Config\ConfigPSM" | Select-String PSMP-INTRANET).ToString()).Split("=")[1] -replace " ","" -replace "\t",""
		$PSMPPCI=((Get-Content "$Path\AppData\Config\ConfigPSM" | Select-String PSMP-PCI).ToString()).Split("=")[1] -replace " ","" -replace "\t",""
		$userConnection = $ComboBoxSSHUser.SelectedItem
		
		Switch ($PCI)
		{
			INTRANET {$psm = "$PSMINTRANET"}
			DMZ {$psm = "$PSMINTRANET"}
			PCI {$psm = "$PSMPCI"}
		}
		
		if (!$psm) {ConfigPSM;return}
		
		if (Test-Path -path "$userPath\$user.pass") {
			$Password = Get-Content "$userPath\$user.pass" | ConvertTo-SecureString
			$Usuario = "$DomainUser"
			$Credenciales = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $Usuario,$Password
			$pass = $Credenciales.GetNetworkCredential().Password
		}
		
		if ($Authentication -eq "RADIUS")
		{
			if (Test-Path -path "$userPath\$user.pass")
			{
				$Credentials=Get-Credential -Credential "Enter Token"
				if (!$Credentials){return}
				$passSSH = $pass+$Credentials.GetNetworkCredential().Password
				$PassRDP = "$passSSH" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
			} else {
				$Credentials=Get-Credential -Credential "Enter PIN&Token"
				if (!$Credentials){return}
				$passSSH = $Credentials.GetNetworkCredential().Password
				$PassRDP = "$passSSH" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
			}
		} else {
			$passSSH = $pass
			$PassRDP = "$pass" | ConvertTo-SecureString -AsPlainText -Force | ConvertFrom-SecureString
		}
		
		if ($conexion -ne "RECENT") 
		{
			$ServerFile = "$Servidor-$Tipo-$userConnection.rdp"
			$Template="$Path\AppData\Templates\RDP.rdp"
			if (!(Test-Path -path "$Template")) {createTemplateRDP}
			
			Switch ($Tipo)
			{
				RDP {$userConnection="$userConnection@$Dominio"}
				SSH 
				{
					$ServerFile = "$Servidor-$Tipo-$userConnection.rdp"
					Switch ($PCI)
					{
						INTRANET {$psm = "$PSMPINTRANET"}
						DMZ {$psm = "$PSMPINTRANET"}
						PCI {$psm = "$PSMPPCI"}
					}
					if (!$psm) {ConfigPSM;return}
					$userConnection="$userConnection"
					if (Test-Path -path "$Path\AppData\PuTTy\PuTTy.exe")
					{
						$ServerFile = "$Servidor-PuTTy-$userConnection"
						Set-Content "$userPath\RDP\$ServerFile" "$DomainUser@$userConnection@$Servidor.$Dominio@$psm"
						if ($passSSH) {Start-Process -WindowStyle Normal "$Path\AppData\PuTTy\PuTTy.exe" -ArgumentList "$DomainUser@$userConnection@$Servidor.$Dominio@$psm -pw $passSSH"
						} else {Start-Process -WindowStyle Normal "$Path\AppData\PuTTy\PuTTy.exe" -ArgumentList "$DomainUser@$userConnection@$Servidor.$Dominio@$psm"}
						return
					}
				}
				iDRACWebAgent {$userConnection="$userConnection"}
				IMMWebAgent {$userConnection="$userConnection"}
				WinSCP {$userConnection="$userConnection";$ServerFile = "$Servidor-$Tipo-$userConnection.rdp"}
				VSPHERE {$userConnection="$userConnection@$Dominio"}
				VSPHERE-WEB {$userConnection="$userConnection@$Dominio"}
			}
			
			if ($ComboBoxResolution.SelectedItem -ne "AutoSize" -and $ComboBoxResolution.SelectedItem -ne "FullScreen")
			{
				if (!$ComboBoxResolution.SelectedItem) {$desktopwidth = 1920;$desktopheigh = 1080;$ScreenMode=2} else {
					$desktopwidth = ($ComboBoxResolution.SelectedItem).split("x")[0]
					$desktopheigh = ($ComboBoxResolution.SelectedItem).split("x")[1]
					$ScreenMode = 1
				}
			} else {
				$desktopwidth = 1920
				$desktopheigh = 1080
				$ScreenMode = 2
				if ($ComboBoxResolution.SelectedItem -eq "AutoSize"){$AutoSize = 1;$ScreenMode = 1;$desktopwidth = 1800;$desktopheigh = 900}
			}
			
			type "$Template" > "$userPath\RDP\$ServerFile"
			Write-Output "screen mode id:i:$ScreenMode" | Out-File "$userPath\RDP\$ServerFile" -Append
			Write-Output "desktopwidth:i:$desktopwidth" | Out-File "$userPath\RDP\$ServerFile" -Append
			Write-Output "desktopheight:i:$desktopheigh" | Out-File "$userPath\RDP\$ServerFile" -Append
			if ($AutoSize -eq 1) {Write-Output "smart sizing:i:1" | Out-File "$userPath\RDP\$ServerFile" -Append}
			if ($Tipo -eq "SSH") {Write-Output "drivestoredirect:s:" | Out-File "$userPath\RDP\$ServerFile" -Append} else {Write-Output "drivestoredirect:s:*" | Out-File "$userPath\RDP\$ServerFile" -Append}
			Write-Output "username:s:$DomainUser" | Out-File "$userPath\RDP\$ServerFile" -Append
			Write-Output "full address:s:$psm" | Out-File "$userPath\RDP\$ServerFile" -Append
			Write-Output "alternate shell:s:psm /u $userConnection /a $Servidor.$Dominio /c psm-$Tipo" | Out-File "$userPath\RDP\$ServerFile" -Append
			if ($PassRDP) {Write-Output "password 51:b:$PassRDP" | Out-File "$userPath\RDP\$ServerFile" -Append}
		} else {
			if ($Servidor -like "*-PuTTy-*")
			{
				$ConnectionPutty=Get-Content "$userPath\RDP\$Servidor"
				if ($passSSH) {Start-Process -WindowStyle Normal "$Path\AppData\PuTTy\putty.exe" -ArgumentList "$ConnectionPutty -pw $passSSH"} else {
					Start-Process -WindowStyle Normal "$Path\AppData\PuTTy\putty.exe" -ArgumentList "$ConnectionPutty"
				}
				return
			} else {
				$ServerFile = "$Servidor.rdp"
				if ($PassRDP) {Write-Output "password 51:b:$PassRDP" | Out-File "$userPath\RDP\$ServerFile" -Append}
			}
		}
		& "$userPath\RDP\$ServerFile"
	} else {
		if (!(Test-Path -path "$userPath\config"))
		{
			RegisterWindow
			if ((Test-Path -path "$userPath\config")) {
				$FormCyberArk.Controls.Remove($ButtonRegisterUser)
				$FormCyberArk.Controls.Add($ButtonShowUser)
				$FormCyberArk.Controls.Add($LabelUserName)
				$FormCyberArk.Controls.Add($LabelUser)
			} else {
				$FormCyberArk.Controls.Remove($ButtonShowUser)
				$FormCyberArk.Controls.Remove($LabelUserName)
				$FormCyberArk.Controls.Remove($LabelUser)
				$FormCyberArk.Controls.Add($ButtonRegisterUser)
			}
		} else {
			MessageWindow -Mensaje "The specified server is not in the list of servers. Please, add it to make the connection." -Titulo "ERROR" -Botones OK -Icono Error
			SwitchDomain $conexion $Dominio
		}
	}
}



Function ShowItems
{
	if (Test-Path -path "$userPath\config") {
		$FormCyberArk.Controls.Add($ButtonShowUser)
		$FormCyberArk.Controls.Add($LabelUserName)
		$FormCyberArk.Controls.Add($LabelUser)
		$lastImage=((Get-Content "$userPath\config" | Select-String ImageProfile).ToString()).Split("=")[1]
		if ($lastImage)
		{
			$imageButton = [System.Drawing.Image]::FromFile("$lastImage")
		} else {
			$imageButton = [System.Drawing.Image]::FromFile("$imagesPath\notimage.jpg")
		}
		$ButtonShowUser.Image = $imageButton
	} else {$FormCyberArk.Controls.Add($ButtonRegisterUser);$FormCyberArk.Controls.Remove($ButtonShowUser);$FormCyberArk.Controls.Remove($LabelUserName);$FormCyberArk.Controls.Remove($LabelUser)}
	if ($conexion -ne "RECENT")
	{
		$FormCyberArk.Controls.Remove($LabelServersRecent)
		$FormCyberArk.Controls.Remove($ComboBoxRecent)
		$FormCyberArk.Controls.Remove($ButtonConnectRecentOK)
		$FormCyberArk.Controls.Remove($ListBoxPCI)
		$FormCyberArk.Controls.Remove($TextBoxAddDomain)
		$FormCyberArk.Controls.Remove($TextBoxAddServers)
		$FormCyberArk.Controls.Remove($ButtonAddServers)
		$FormCyberArk.Controls.Remove($ButtonAddServersOK)  
		$FormCyberArk.Controls.Remove($ButtonAddDomainOK)
		$FormCyberArk.Controls.Add($ButtonAddDomain)
		$FormCyberArk.Controls.Add($LabelConnections)
		$FormCyberArk.Controls.Add($LabelLogoConnection)
		$FormCyberArk.Controls.Add($LabelDomains)
		$FormCyberArk.Controls.Add($ListBoxDomains)
		$FormCyberArk.Controls.Add($LabelServers)
		$FormCyberArk.Controls.Add($ComboBoxServers)
		$FormCyberArk.Controls.Add($ButtonConnectOK)  
		$FormCyberArk.Controls.Add($LabelResolution)
		$FormCyberArk.Controls.Add($ComboBoxResolution)
		$FormCyberArk.Controls.Add($LabelComboBoxUserSSH)
		$FormCyberArk.Controls.Add($ComboBoxSSHUser)
	} else {
		$FormCyberArk.Controls.Remove($LabelDomains)
		$FormCyberArk.Controls.Remove($ListBoxDomains)
		$FormCyberArk.Controls.Remove($LabelServers)
		$FormCyberArk.Controls.Remove($ComboBoxServers)
		$FormCyberArk.Controls.Remove($ListBoxPCI)
		$FormCyberArk.Controls.Remove($TextBoxAddDomain)
		$FormCyberArk.Controls.Remove($TextBoxAddServers)
		$FormCyberArk.Controls.Remove($ButtonAddServers)
		$FormCyberArk.Controls.Remove($ButtonAddDomain)
		$FormCyberArk.Controls.Remove($ButtonAddServersOK)
		$FormCyberArk.Controls.Remove($ButtonAddDomainOK)
		$FormCyberArk.Controls.Remove($ButtonConnectOK)
		$FormCyberArk.Controls.Remove($LabelResolution)
		$FormCyberArk.Controls.Remove($ComboBoxResolution)
		$FormCyberArk.Controls.Remove($LabelComboBoxUserSSH)
		$FormCyberArk.Controls.Remove($ComboBoxSSHUser)
		$FormCyberArk.Controls.Add($LabelServersRecent)
		$FormCyberArk.Controls.Add($ComboBoxRecent)
		$FormCyberArk.Controls.Add($ButtonConnectRecentOK)
	}
	if (!$ComboBoxSSHUser.Items) {$ComboBoxSSHUser.Text = "Enter User"} else {$ComboBoxSSHUser.SelectedItem = $ComboBoxSSHUser.Items[0]}
	$ListBoxPCI.SelectedItem = $ListBoxPCI.Items[0]
    $TextBoxAddServers.Text = ""
    $ListBoxDomains.Font = $FontRegular
    $ComboBoxServers.Font = $FontRegular
    $ComboBoxRecent.Font = $FontRegular
    $ComboBoxResolution.Font = $FontRegular
    $ListBoxPCI.Font = $FontRegular
	$LabelComboBoxUserSSH.Font = $FontBold
	$ComboBoxSSHUser.Font = $FontRegular
    $ListBoxWinSCP.Font = $FontRegular
	$LabelUserName.Font = $FontBold
	$LabelUser.Font = $FontBold
	$FormCyberArk.Controls.Remove($ListBoxPCI)
	$FormCyberArk.Controls.Remove($ListBoxWinSCP)
    DeleteListBoxDomains
    if ($ComboBoxServers.Items) {DeleteComboBoxServers}
    if ($ComboBoxRecent.Items) {DeleteComboBoxRecent}
}

Function CompleteListBoxDomains
{
    $dominios = get-childitem "$domainsPath\$conexion" | Sort-Object
    foreach ($dominio in $dominios) {
		$ListBoxDomains.Items.Add("$dominio")
    }
    $ComboBoxServers.Text = "Select domain"
}

Function DeleteListBoxDomains
{
	$ListBoxDomains.Items.Clear()
}


Function CompleteComboBoxServers
{
    $servidores = Get-Content "$domainsPath\$conexion\$Dominio" | ? {$_.trim() -ne "" } | sort | Get-Unique
    if ($servidores)
	{
		foreach ($servidor in $servidores) {
			$servidor = $servidor.ToLower()
			$ComboBoxServers.Items.Add("$servidor")
			$servidor | % {$ComboBoxServers.AutoCompleteCustomSource.AddRange($_) }
		}
		$ComboBoxServers.SelectedItem = $ComboBoxServers.Items[0]
		if ($Server) {$ComboBoxServers.SelectedItem = $Server}
	} else {
		$ComboBoxServers.Text="Add servers"
	}
}

Function DeleteComboBoxServers
{
    $ComboBoxServers.Items.Clear()
    $ComboBoxServers.AutoCompleteCustomSource.Clear()
}

Function DeleteComboBoxRecent
{
    $ComboBoxRecent.Items.Clear()
    $ComboBoxRecent.AutoCompleteCustomSource.Clear()
}

Function SwitchConnection ($conexion)
{
    ShowItems
	switch ($conexion)
	{
		WINDOWS {
			$global:conexion= "WINDOWS"
			CompleteListBoxDomains
			$ListBoxWinSCP.Items.Clear()
			$ListBoxWinSCP.Items.Add("RDP")
			$ListBoxWinSCP.Items.Add("IMMWebAgent")
			$ListBoxWinSCP.Items.Add("iDRACWebAgent")
			$ListBoxWinSCP.SelectedItem="RDP"
			$ComboBoxSSHUser.Items.Clear();
			$UsersSSH=((Get-Content "$userPath\config" | Select-String UserCyberArkRDP).ToString()).Split("=")[1].Split("|")
			foreach ($UserSSH in $UsersSSH) {
				$ComboBoxSSHUser.Items.Add($UserSSH)
			}
			if (!$ComboBoxSSHUser.Items) {$ComboBoxSSHUser.Text = "Enter User"} else {$ComboBoxSSHUser.SelectedItem = $ComboBoxSSHUser.Items[0]}
		}
		UNIX {
			$global:conexion= "UNIX"
			CompleteListBoxDomains
			$ListBoxWinSCP.Items.Clear()
			$ListBoxWinSCP.Items.Add("SSH")
			$ListBoxWinSCP.Items.Add("WinSCP")
			$ListBoxWinSCP.Items.Add("IMMWebAgent")
			$ListBoxWinSCP.Items.Add("iDRACWebAgent")
			$ListBoxWinSCP.SelectedItem="SSH"
			$ComboBoxSSHUser.Items.Clear();
			$UsersSSH=((Get-Content "$userPath\config" | Select-String UserCyberArkSSH).ToString()).Split("=")[1].Split("|")
			foreach ($UserSSH in $UsersSSH) {
				$ComboBoxSSHUser.Items.Add($UserSSH)
			}
			if (!$ComboBoxSSHUser.Items) {$ComboBoxSSHUser.Text = "Enter User"} else {$ComboBoxSSHUser.SelectedItem = $ComboBoxSSHUser.Items[0]}
		} 
		VCENTER {
			$global:conexion= "vcenter"
			CompleteListBoxDomains
			$ListBoxWinSCP.Items.Clear()
			$ListBoxWinSCP.Items.Add("VSPHERE")
			$ListBoxWinSCP.Items.Add("VSPHERE-WEB")
			$ListBoxWinSCP.SelectedItem="VSPHERE"
			$ComboBoxSSHUser.Items.Clear();
			$UsersSSH=((Get-Content "$userPath\config" | Select-String UserCyberArkVcenter).ToString()).Split("=")[1].Split("|")
			foreach ($UserSSH in $UsersSSH) {
				$ComboBoxSSHUser.Items.Add($UserSSH)
			}
			if (!$ComboBoxSSHUser.Items) {$ComboBoxSSHUser.Text = "Enter User"} else {$ComboBoxSSHUser.SelectedItem = $ComboBoxSSHUser.Items[0]}
		}
		default {
			$FormCyberArk.Controls.Remove($ListBoxWinSCP)
			$ListBoxWinSCP.Items.Clear()
			$ListBoxWinSCP.Items.Add("RECENT")
			$ListBoxWinSCP.SelectedItem="RECENT"
			$global:conexion= "RECENT"
			$imageLogoConnection = [System.Drawing.Image]::FromFile("$imagesPath\$conexion.jpg")
			$LabelLogoConnection.Image = $imageLogoConnection
			$dominios = Get-ChildItem -Path "$userPath\RDP" | Sort-Object
			foreach ($dominio in $dominios) 
			{
				$dominio=[System.IO.Path]::GetFileNameWithoutExtension("$dominio")
				[void] $ComboBoxRecent.Items.Add("$dominio")
				$dominio | % {$ComboBoxRecent.AutoCompleteCustomSource.AddRange($_)}
			}
			if (!$ComboBoxRecent.Items) {$ComboBoxRecent.Text = "No connections"} else {$ComboBoxRecent.SelectedItem = $ComboBoxRecent.Items[0]}
		}
	}
	$image=$ListBoxWinSCP.SelectedItem
	$imageLogoConnection = [System.Drawing.Image]::FromFile("$imagesPath\$image.jpg")
    $LabelLogoConnection.Image = $imageLogoConnection
	$ListBoxDomains.SelectedItem=$ListBoxDomains.Items[0]
	$Dominio=$ListBoxDomains.SelectedItem
	SwitchDomain $conexion $Dominio
}


Function SwitchDomain
{
if (!(Test-Path -path "$userPath\config")) {$FormCyberArk.Controls.Remove($ButtonShowUser);$FormCyberArk.Controls.Remove($LabelUserName);$FormCyberArk.Controls.Remove($LabelUser);$FormCyberArk.Controls.Add($ButtonRegisterUser)} else {$FormCyberArk.Controls.Remove($ButtonRegisterUser);$FormCyberArk.Controls.Add($ButtonShowUser);$FormCyberArk.Controls.Add($LabelUserName);$FormCyberArk.Controls.Add($LabelUser)}
	if ($ListBoxDomains.selecteditem -eq "$Dominio") {
		$FormCyberArk.Controls.Remove($TextBoxAddServers)
		$FormCyberArk.Controls.Add($ButtonAddDomain)
		$FormCyberArk.Controls.Add($ComboBoxServers)
		DeleteComboBoxServers
		CompleteComboBoxServers $Server
		$FormCyberArk.Controls.Add($ListBoxWinSCP)
		$FormCyberArk.Controls.Add($ButtonAddServers)
		if ($Dominio -eq "mp.int")
		{
			$ListBoxPCI.SelectedItem = $ListBoxPCI.Items[1]
		} else {
			$ListBoxPCI.SelectedItem = $ListBoxPCI.Items[0]
		}
		$FormCyberArk.Controls.Remove($ButtonAddServersOK)
		$FormCyberArk.Controls.Add($ListBoxPCI)
		$FormCyberArk.Controls.Add($ButtonConnectOK)
	}
}

Function SwitchWinSCP
{
	$logo=$ListBoxWinSCP.SelectedItem
	$imageLogoConnection = [System.Drawing.Image]::FromFile("$imagesPath\$logo.jpg")
	$LabelLogoConnection.Image = $imageLogoConnection
}

Function SwitchAuth
{
	$autenticacion = ((Get-Content "$userPath\config" | Select-String authentication).ToString()).Split("=")[1] -replace " ","" -replace "\t",""
	if ($autenticacion -eq "LDAP")
	{
		$autenticacionNew="RADIUS"
		$FormRegister.Controls.Remove($ButtonRegLDAP)
		$FormRegister.Controls.Add($ButtonRegRadius)
		$global:Registro= "1"
	} else {
		$autenticacionNew="LDAP"
		$FormRegister.Controls.Remove($ButtonRegRadius)
		$FormRegister.Controls.Add($ButtonRegLDAP)
		$global:Registro= "2"
	}
	(Get-Content "$userPath\config") -replace "Authentication=$autenticacion","Authentication=$autenticacionNew" | Set-Content "$userPath\config"
}


Function ConfigPSM
{
	$FormConfigPSM = New-Object system.Windows.Forms.Form
	$FormConfigPSM.StartPosition = $CenterScreen
	$FormConfigPSM.FormBorderStyle = 'Fixed3D'
	$FormConfigPSM.MaximizeBox = $false
	$FormConfigPSM.Text = "CONFIG PSM"
	$ImageConfigPSM = [system.drawing.image]::FromFile("$imagesPath\configPSMForm.jpg")
	$FormConfigPSM.BackgroundImage = $ImageConfigPSM
	$FormConfigPSM.Width = $ImageConfigPSM.Width
	$FormConfigPSM.Height = $ImageConfigPSM.Height
	$FormConfigPSM.BackgroundImageLayout = "None"
	$FormConfigPSM.MaximizeBox = $false
	$TextBoxPSMINT.Font = $FontRegular
	$TextBoxPSMPCI.Font = $FontRegular
	$TextBoxPSMPINT.Font = $FontRegular
	$TextBoxPSMPPCI.Font = $FontRegular
	$LabelPSMINT.Font = $FontBold
	$LabelPSMPCI.Font = $FontBold
	$LabelPSMPPCI.Font = $FontBold
	$LabelPSMPINT.Font = $FontBold
	$FormConfigPSM.Font = $FontBold
	$IconConfigPSM = [system.drawing.icon]::ExtractAssociatedIcon("$imagesPath\cyber.ico")
	$FormConfigPSM.Icon = $IconConfigPSM
	if (!(Test-Path -path "$Path\AppData\Config\ConfigPSM")) {
		Add-Content "$Path\AppData\Config\ConfigPSM" "PSM-INTRANET="
		Add-Content "$Path\AppData\Config\ConfigPSM" "PSM-PCI="
		Add-Content "$Path\AppData\Config\ConfigPSM" "PSMP-INTRANET="
		Add-Content "$Path\AppData\Config\ConfigPSM" "PSMP-PCI="
	}
	$PSMINTRANET=((Get-Content "$Path\AppData\Config\ConfigPSM" | Select-String PSM-INTRANET).ToString()).Split("=")[1]
	$PSMPCI=((Get-Content "$Path\AppData\Config\ConfigPSM" | Select-String PSM-PCI).ToString()).Split("=")[1]
	$PSMPINTRANET=((Get-Content "$Path\AppData\Config\ConfigPSM" | Select-String PSMP-INTRANET).ToString()).Split("=")[1]
	$PSMPPCI=((Get-Content "$Path\AppData\Config\ConfigPSM" | Select-String PSMP-PCI).ToString()).Split("=")[1]
	$TextBoxPSMINT.Text=$PSMINTRANET
	$TextBoxPSMPCI.Text=$PSMPCI
	$TextBoxPSMPINT.Text=$PSMPINTRANET
	$TextBoxPSMPPCI.Text=$PSMPPCI
	$FormConfigPSM.Controls.Add($TextBoxPSMINT)
	$FormConfigPSM.Controls.Add($TextBoxPSMPCI)
	$FormConfigPSM.Controls.Add($TextBoxPSMPINT)
	$FormConfigPSM.Controls.Add($TextBoxPSMPPCI)
	$FormConfigPSM.Controls.Add($LabelPSMINT)
	$FormConfigPSM.Controls.Add($LabelPSMPCI)
	$FormConfigPSM.Controls.Add($LabelPSMPPCI)
	$FormConfigPSM.Controls.Add($LabelPSMPINT)
	$FormConfigPSM.Controls.Add($ButtonConfigPSMOK)
	$FormConfigPSM.ShowDialog()
}

Function ConfigPSMOK
{
	$PSMINTRANET=$TextBoxPSMINT.Text -replace " ",""
	$PSMPCI=$TextBoxPSMPCI.Text -replace " ",""
	$PSMPINTRANET=$TextBoxPSMPINT.Text -replace " ",""
	$PSMPPCI=$TextBoxPSMPPCI.Text -replace " ",""
	Set-Content "$Path\AppData\Config\ConfigPSM" "PSM-INTRANET=$PSMINTRANET"
	Add-Content "$Path\AppData\Config\ConfigPSM" "PSM-PCI=$PSMPCI"
	Add-Content "$Path\AppData\Config\ConfigPSM" "PSMP-INTRANET=$PSMPINTRANET"
	Add-Content "$Path\AppData\Config\ConfigPSM" "PSMP-PCI=$PSMPPCI"
	MessageWindow -Mensaje "Config PSM update correctly" -Titulo "Info" -Botones OK -Icono Information
	$FormConfigPSM.Close()
}




$LabelEncryptPass = New-Object System.Windows.Forms.Label
$LabelEncryptPass.Location = New-Object System.Drawing.Size(250,375)
$LabelEncryptPass.AutoSize = $True
$LabelEncryptPass.Text = "ENCRYPT PASS"
$LabelEncryptPass.BackColor = "Transparent"

$LabelConfigPSM = New-Object System.Windows.Forms.Label
$LabelConfigPSM.Location = New-Object System.Drawing.Size(50,375)
$LabelConfigPSM.AutoSize = $True
$LabelConfigPSM.Text = "CONFIG PSM"
$LabelConfigPSM.BackColor = "Transparent"

$LabelEnterUsers = New-Object System.Windows.Forms.Label
$LabelEnterUsers.Location = New-Object System.Drawing.Size(630,270)
$LabelEnterUsers.AutoSize = $True
$LabelEnterUsers.Text = "ENTER USERS"
$LabelEnterUsers.BackColor = "Transparent"

$LabelUserNameLocation=652-($user.Length * 2)
if($user.Length -gt 15){$LabelUserNameLocation=652-($user.Length * 3)}
if($user.Length -lt 6){$LabelUserNameLocation=660-($user.Length)}
$LabelUserName = New-Object System.Windows.Forms.Label
$LabelUserName.Location = New-Object System.Drawing.Size($LabelUserNameLocation,105)
$LabelUserName.AutoSize = $True
$LabelUserName.Text = "$user"
$LabelUserName.BackColor = "Transparent"

$LabelUser = New-Object System.Windows.Forms.Label
$LabelUser.Location = New-Object System.Drawing.Size(625,80)
$LabelUser.AutoSize = $True
$LabelUser.Text = "USERNAME:"
$LabelUser.BackColor = "Transparent"

$LabelAuthMethod = New-Object System.Windows.Forms.Label
$LabelAuthMethod.Location = New-Object System.Drawing.Size(520,100)
$LabelAuthMethod.AutoSize = $True
$LabelAuthMethod.Text = "SELECT AUTHENTICATION METHOD"
$LabelAuthMethod.BackColor = "Transparent"
 
$LabelLogoConnection = New-Object System.Windows.Forms.Label
$LabelLogoConnection.Location = New-Object System.Drawing.Size(50,215)
$LabelLogoConnection.Size = New-Object System.Drawing.Size(150,150)
$LabelLogoConnection.BackColor = "Transparent"

$LabelUserImageProfile = New-Object System.Windows.Forms.Label
$LabelUserImageProfile.Location = New-Object System.Drawing.Size(620,20)
$LabelUserImageProfile.Size = New-Object System.Drawing.Size(100,100)
$LabelUserImageProfile.BackColor = "Transparent"

$LabelUserDomain = New-Object System.Windows.Forms.Label
$LabelUserDomain.Location = New-Object System.Drawing.Size(465,300)
$LabelUserDomain.BackColor = "Transparent"
$imageUserDomain = [System.Drawing.Image]::FromFile("$imagesPath\domainUser.jpg")
$LabelUserDomain.Image = $imageUserDomain
$LabelUserDomain.Width = $imageUserDomain.Width
$LabelUserDomain.Height = $imageUserDomain.Height

$LabelUserRDP = New-Object System.Windows.Forms.Label
$LabelUserRDP.Location = New-Object System.Drawing.Size(465,360)
$LabelUserRDP.BackColor = "Transparent"
$imageUserRDP = [System.Drawing.Image]::FromFile("$imagesPath\rdpUser.jpg")
$LabelUserRDP.Image = $imageUserRDP
$LabelUserRDP.Width = $imageUserRDP.Width
$LabelUserRDP.Height = $imageUserRDP.Height

$LabelUserSSH = New-Object System.Windows.Forms.Label
$LabelUserSSH.Location = New-Object System.Drawing.Size(685,300)
$LabelUserSSH.BackColor = "Transparent"
$imageUserSSH = [System.Drawing.Image]::FromFile("$imagesPath\sshUser.jpg")
$LabelUserSSH.Image = $imageUserSSH
$LabelUserSSH.Width = $imageUserSSH.Width
$LabelUserSSH.Height = $imageUserSSH.Height

$LabelUserVcenter = New-Object System.Windows.Forms.Label
$LabelUserVcenter.Location = New-Object System.Drawing.Size(685,360)
$LabelUserVcenter.BackColor = "Transparent"
$imageUserVcenter = [System.Drawing.Image]::FromFile("$imagesPath\vcenterUser.jpg")
$LabelUserVcenter.Image = $imageUserVcenter
$LabelUserVcenter.Width = $imageUserVcenter.Width
$LabelUserVcenter.Height = $imageUserVcenter.Height

$LabelPSMINT = New-Object System.Windows.Forms.Label
$LabelPSMINT.Location = New-Object System.Drawing.Size(100,175)
$LabelPSMINT.AutoSize = $True
$LabelPSMINT.BackColor = "Transparent"
$LabelPSMINT.Text = "PSM-INTRANET"

$LabelPSMPCI = New-Object System.Windows.Forms.Label
$LabelPSMPCI.Location = New-Object System.Drawing.Size(100,250)
$LabelPSMPCI.AutoSize = $True
$LabelPSMPCI.BackColor = "Transparent"
$LabelPSMPCI.Text = "PSM-PCI"

$LabelPSMPINT = New-Object System.Windows.Forms.Label
$LabelPSMPINT.Location = New-Object System.Drawing.Size(350,175)
$LabelPSMPINT.AutoSize = $True
$LabelPSMPINT.BackColor = "Transparent"
$LabelPSMPINT.Text = "PSMP-INTRANET"

$LabelPSMPPCI = New-Object System.Windows.Forms.Label
$LabelPSMPPCI.Location = New-Object System.Drawing.Size(350,250)
$LabelPSMPPCI.AutoSize = $True
$LabelPSMPPCI.BackColor = "Transparent"
$LabelPSMPPCI.Text = "PSMP-PCI"

$LabelConnections = New-Object System.Windows.Forms.Label
$LabelConnections.Location = New-Object System.Drawing.Size(180,210)
$LabelConnections.AutoSize = $True
$LabelConnections.Text = "CONNECTIONS"
$LabelConnections.BackColor = "Transparent"

$LabelDomains = New-Object System.Windows.Forms.Label
$LabelDomains.Location = New-Object System.Drawing.Size(380,210)
$LabelDomains.AutoSize = $True
$LabelDomains.Text = "DOMAINS"
$LabelDomains.BackColor = "Transparent"
 
$LabelServers = New-Object System.Windows.Forms.Label
$LabelServers.Location = New-Object System.Drawing.Size(580,210)
$LabelServers.AutoSize = $True
$LabelServers.Text = "SERVERS"
$LabelServers.BackColor = "Transparent"

$LabelServersRecent = New-Object System.Windows.Forms.Label
$LabelServersRecent.Location = New-Object System.Drawing.Size(450,210)
$LabelServersRecent.AutoSize = $True
$LabelServersRecent.Text = "SERVERS"
$LabelServersRecent.BackColor = "Transparent"

$LabelResolution = New-Object System.Windows.Forms.Label
$LabelResolution.Location = New-Object System.Drawing.Size(180,370)
$LabelResolution.AutoSize = $True
$LabelResolution.Text = "RESOLUTION"
$LabelResolution.BackColor = "Transparent"

$LabelComboBoxUserSSH = New-Object System.Windows.Forms.Label
$LabelComboBoxUserSSH.Location = New-Object System.Drawing.Size(770,370)
$LabelComboBoxUserSSH.AutoSize = $True
$LabelComboBoxUserSSH.Text = "USERS"
$LabelComboBoxUserSSH.BackColor = "Transparent"

$ListBoxDomains = New-Object System.Windows.Forms.Listbox
$ListBoxDomains.Location = new-object System.Drawing.Size(380,250)
$ListBoxDomains.Size = New-Object System.Drawing.Size(140,200)
$ListBoxDomains.Text = 'Please make a selection from the list below:'
$ListBoxDomains.SelectionMode = 'One'
$ListBoxDomains.Add_Click({$Dominio=$ListBoxDomains.SelectedItem; SwitchDomain $conexion $Dominio})
$ListBoxDomains.Add_KeyUp({if (($_.KeyCode -eq "Left") -or ($_.KeyCode -eq "Right") -or ($_.KeyCode -eq "Up") -or ($_.KeyCode -eq "Down")){$Dominio=$ListBoxDomains.SelectedItem; SwitchDomain $conexion $Dominio}})

$ListBoxPCI = New-Object System.Windows.Forms.Listbox
$ListBoxPCI.Location = new-object System.Drawing.Size(580,320)
$ListBoxPCI.Size = New-Object System.Drawing.Size(140,50)
$ListBoxPCI.Text = 'Please make a selection from the list below:'
$ListBoxPCI.SelectionMode = 'One'

$ListBoxWinSCP = New-Object System.Windows.Forms.Listbox
$ListBoxWinSCP.Location = new-object System.Drawing.Size(580,400)
$ListBoxWinSCP.Size = New-Object System.Drawing.Size(140,50)
$ListBoxWinSCP.Text = 'Please make a selection from the list below:'
$ListBoxWinSCP.SelectionMode = 'One'
$ListBoxWinSCP.Add_Click({$Tipo=$ListBoxWinSCP.SelectedItem;SwitchWinSCP $conexion $Tipo})
$ListBoxWinSCP.Add_KeyUp({if (($_.KeyCode -eq "Left") -or ($_.KeyCode -eq "Right") -or ($_.KeyCode -eq "Up") -or ($_.KeyCode -eq "Down")){$Tipo=$ListBoxWinSCP.SelectedItem;SwitchWinSCP $conexion $Tipo}})

$ListBoxConnections = New-Object System.Windows.Forms.Listbox
$ListBoxConnections.Location = new-object System.Drawing.Size(180,250)
$ListBoxConnections.Size = New-Object System.Drawing.Size(140,80)
$ListBoxConnections.Text = 'Please make a selection from the list below:'
$ListBoxConnections.SelectionMode = 'One'
$ListBoxConnections.Add_Click({$conexion=($ListBoxConnections.SelectedItem).ToLower();SwitchConnection $conexion})
$ListBoxConnections.Add_KeyUp({if (($_.KeyCode -eq "Left") -or ($_.KeyCode -eq "Right") -or ($_.KeyCode -eq "Up") -or ($_.KeyCode -eq "Down")){$conexion=($ListBoxConnections.SelectedItem).ToLower();SwitchConnection $conexion}})

$TextBoxPSMINT = New-Object System.Windows.Forms.TextBox
$TextBoxPSMINT.Location = New-Object System.Drawing.Size(100,200)
$TextBoxPSMINT.Size = New-Object System.Drawing.Size(175,100)
$TextBoxPSMINT.BackColor ="White"
$TextBoxPSMINT.Text = ""

$TextBoxPSMPCI = New-Object System.Windows.Forms.TextBox
$TextBoxPSMPCI.Location = New-Object System.Drawing.Size(100,275)
$TextBoxPSMPCI.Size = New-Object System.Drawing.Size(175,100)
$TextBoxPSMPCI.BackColor ="White"
$TextBoxPSMPCI.Text = ""

$TextBoxPSMPINT = New-Object System.Windows.Forms.TextBox
$TextBoxPSMPINT.Location = New-Object System.Drawing.Size(350,200)
$TextBoxPSMPINT.Size = New-Object System.Drawing.Size(175,100)
$TextBoxPSMPINT.BackColor ="White"
$TextBoxPSMPINT.Text = ""

$TextBoxPSMPPCI = New-Object System.Windows.Forms.TextBox
$TextBoxPSMPPCI.Location = New-Object System.Drawing.Size(350,275)
$TextBoxPSMPPCI.Size = New-Object System.Drawing.Size(175,100)
$TextBoxPSMPPCI.BackColor ="White"
$TextBoxPSMPPCI.Text = ""

$TextBoxIMMUser = New-Object System.Windows.Forms.TextBox
$TextBoxIMMUser.Location = New-Object System.Drawing.Size(100,200)
$TextBoxIMMUser.Size = New-Object System.Drawing.Size(175,100)
$TextBoxIMMUser.BackColor ="White"
$TextBoxIMMUser.Text = ""

$TextBoxiDracUser = New-Object System.Windows.Forms.TextBox
$TextBoxiDracUser.Location = New-Object System.Drawing.Size(100,275)
$TextBoxiDracUser.Size = New-Object System.Drawing.Size(175,100)
$TextBoxiDracUser.BackColor ="White"
$TextBoxiDracUser.Text = ""

$TextBoxDMZUser = New-Object System.Windows.Forms.TextBox
$TextBoxDMZUser.Location = New-Object System.Drawing.Size(350,200)
$TextBoxDMZUser.Size = New-Object System.Drawing.Size(175,100)
$TextBoxDMZUser.BackColor ="White"
$TextBoxDMZUser.Text = ""

$TextBoxPCIUser = New-Object System.Windows.Forms.TextBox
$TextBoxPCIUser.Location = New-Object System.Drawing.Size(350,275)
$TextBoxPCIUser.Size = New-Object System.Drawing.Size(175,100)
$TextBoxPCIUser.BackColor ="White"
$TextBoxPCIUser.Text = ""

$TextBoxUserDomain = New-Object System.Windows.Forms.TextBox
$TextBoxUserDomain.Location = New-Object System.Drawing.Size(515,310)
$TextBoxUserDomain.Size = New-Object System.Drawing.Size(150,100)
$TextBoxUserDomain.BackColor ="White"
$TextBoxUserDomain.Text = ""
$TextBoxUserDomain.Add_Click({$marker="Domain";Watermarker $marker})
$TextBoxUserDomain.Add_KeyUp({if ($_.KeyCode -eq "Tab"){$marker="Domain";Watermarker $marker}})

$TextBoxUserCyberArk = New-Object System.Windows.Forms.TextBox
$TextBoxUserCyberArk.Location = New-Object System.Drawing.Size(515,370)
$TextBoxUserCyberArk.Size = New-Object System.Drawing.Size(150,100)
$TextBoxUserCyberArk.BackColor ="White"
$TextBoxUserCyberArk.Text = ""
$TextBoxUserCyberArk.Add_Click({$marker="RDP";Watermarker $marker})
$TextBoxUserCyberArk.Add_KeyUp({if ($_.KeyCode -eq "Tab"){$marker="RDP";Watermarker $marker}})

$TextBoxUserSSH = New-Object System.Windows.Forms.TextBox
$TextBoxUserSSH.Location = New-Object System.Drawing.Size(735,310)
$TextBoxUserSSH.Size = New-Object System.Drawing.Size(150,100)
$TextBoxUserSSH.BackColor ="White"
$TextBoxUserSSH.Text = ""
$TextBoxUserSSH.Add_Click({$marker="SSH";Watermarker $marker})
$TextBoxUserSSH.Add_KeyUp({if ($_.KeyCode -eq "Tab"){$marker="SSH";Watermarker $marker}})

$TextBoxUserVcenter = New-Object System.Windows.Forms.TextBox
$TextBoxUserVcenter.Location = New-Object System.Drawing.Size(735,370)
$TextBoxUserVcenter.Size = New-Object System.Drawing.Size(150,100)
$TextBoxUserVcenter.BackColor ="White"
$TextBoxUserVcenter.Text = ""
$TextBoxUserVcenter.Add_Click({$marker="vc";Watermarker $marker})
$TextBoxUserVcenter.Add_KeyUp({if ($_.KeyCode -eq "Tab"){$marker="vc";Watermarker $marker}})

$TextBoxAddServers = New-Object System.Windows.Forms.TextBox
$TextBoxAddServers.Location = New-Object System.Drawing.Size(580,250)
$TextBoxAddServers.Size = New-Object System.Drawing.Size(140,195)
$TextBoxAddServers.BackColor ="White"
$TextBoxAddServers.Text = ""
$TextBoxAddServers.MultiLine = $true 
$TextBoxAddServers.ScrollBars = "Vertical" 

$TextBoxAddDomain = New-Object System.Windows.Forms.TextBox
$TextBoxAddDomain.Location = New-Object System.Drawing.Size(380,250)
$TextBoxAddDomain.Size = New-Object System.Drawing.Size(140,195)
$TextBoxAddDomain.BackColor ="White"
$TextBoxAddDomain.Text = ""
$TextBoxAddDomain.MultiLine = $false 

$ComboBoxServers = New-Object System.Windows.Forms.ComboBox
$ComboBoxServers.Location = New-Object System.Drawing.Size(580,250)
$ComboBoxServers.Size = New-Object System.Drawing.Size(140,300)
$ComboBoxServers.AutoCompleteSource = 'CustomSource'
$ComboBoxServers.AutoCompleteMode='SuggestAppend'

$ComboBoxRecent = New-Object System.Windows.Forms.ComboBox
$ComboBoxRecent.Location = New-Object System.Drawing.Size(450,250)
$ComboBoxRecent.Size = New-Object System.Drawing.Size(225,300)
$ComboBoxRecent.AutoCompleteSource = 'CustomSource'
$ComboBoxRecent.AutoCompleteMode='SuggestAppend'

$ComboBoxResolution = New-Object System.Windows.Forms.ComboBox
$ComboBoxResolution.Location = New-Object System.Drawing.Size(180,400)
$ComboBoxResolution.Size = New-Object System.Drawing.Size(140,25)
$ComboBoxResolution.AutoCompleteSource = 'CustomSource'
$ComboBoxResolution.AutoCompleteMode='SuggestAppend'

$ComboBoxSSHUser = New-Object System.Windows.Forms.ComboBox
$ComboBoxSSHUser.Location = New-Object System.Drawing.Size(770,400)
$ComboBoxSSHUser.Size = New-Object System.Drawing.Size(125,25)
$ComboBoxSSHUser.AutoCompleteSource = 'CustomSource'
$ComboBoxSSHUser.AutoCompleteMode='SuggestAppend'

$ButtonRegRadius = New-Object System.Windows.Forms.Button
$ButtonRegRadius.Location = New-Object System.Drawing.Size(470,160)
$imageRegRadius = [System.Drawing.Image]::FromFile("$imagesPath\radius.jpg")
$ButtonRegRadius.Image = $imageRegRadius
$ButtonRegRadius.Width = $imageRegRadius.Width
$ButtonRegRadius.Height = $imageRegRadius.Height
$ButtonRegRadius.BackColor ="LightGray"
$ButtonRegRadius.ForeColor = 'LightGray'
$ButtonRegRadius.Add_Click({$Registro=1;RegisterUsersWindow $Registro})

$ButtonSwitchAuth = New-Object System.Windows.Forms.Button
$ButtonSwitchAuth.Location = New-Object System.Drawing.Size(645,175)
$imageSwitchAuth = [System.Drawing.Image]::FromFile("$imagesPath\switch.jpg")
$ButtonSwitchAuth.Image = $imageSwitchAuth
$ButtonSwitchAuth.Width = $imageSwitchAuth.Width
$ButtonSwitchAuth.Height = $imageSwitchAuth.Height
$ButtonSwitchAuth.BackColor ="LightGray"
$ButtonSwitchAuth.ForeColor = 'LightGray'
$ButtonSwitchAuth.Add_Click({SwitchAuth})

$ButtonRegLDAP = New-Object System.Windows.Forms.Button
$ButtonRegLDAP.Location = New-Object System.Drawing.Size(720,160)
$imageRegLDAP = [System.Drawing.Image]::FromFile("$imagesPath\ldap.jpg")
$ButtonRegLDAP.Image = $imageRegLDAP
$ButtonRegLDAP.Width = $imageRegLDAP.Width
$ButtonRegLDAP.Height = $imageRegLDAP.Height
$ButtonRegLDAP.BackColor ="LightGray"
$ButtonRegLDAP.ForeColor = 'LightGray'
$ButtonRegLDAP.Add_Click({$Registro=2;RegisterUsersWindow $Registro})

$ButtonConnectOK = New-Object System.Windows.Forms.Button
$ButtonConnectOK.Location = New-Object System.Drawing.Size(770,250)
$ButtonConnectOK.Size = New-Object System.Drawing.Size(60,60)
$imageConnectOK = [System.Drawing.Image]::FromFile("$imagesPath\ok.jpg")
$ButtonConnectOK.Image = $imageConnectOK
$ButtonConnectOK.BackColor ="LightGray"
$ButtonConnectOK.ForeColor = 'LightGray'
$ButtonConnectOK.Add_Click({$Dominio=$ListBoxDomains.SelectedItem;$Servidor=$ComboBoxServers.SelectedItem;$PCI=$ListBoxPCI.SelectedItem;$Tipo=$ListBoxWinSCP.SelectedItem;Connection $Dominio $Servidor $PCI $Tipo})


$ButtonConnectRecentOK = New-Object System.Windows.Forms.Button
$ButtonConnectRecentOK.Location = New-Object System.Drawing.Size(770,250)
$ButtonConnectRecentOK.Size = New-Object System.Drawing.Size(60,60)
$imageConnectRecentOK = [System.Drawing.Image]::FromFile("$imagesPath\ok.jpg")
$ButtonConnectRecentOK.Image = $imageConnectRecentOK
$ButtonConnectRecentOK.BackColor ="LightGray"
$ButtonConnectRecentOK.ForeColor = 'LightGray'
$ButtonConnectRecentOK.Add_Click({$Dominio=$ListBoxDomains.SelectedItem;$Servidor=$ComboBoxRecent.SelectedItem;$PCI=$ListBoxPCI.SelectedItem;$Tipo=$ListBoxWinSCP.SelectedItem;Connection $Dominio $Servidor $PCI $Tipo})

$ButtonRegisterUser = New-Object System.Windows.Forms.Button
$ButtonRegisterUser.Location = New-Object System.Drawing.Size(750,50)
$ButtonRegisterUser.Size = New-Object System.Drawing.Size(100,100)
$imageRegisterUser = [System.Drawing.Image]::FromFile("$imagesPath\user.jpg")
$ButtonRegisterUser.Image = $imageRegisterUser
$ButtonRegisterUser.BackColor ="LightGray"
$ButtonRegisterUser.ForeColor = 'LightGray'
$ButtonRegisterUser.Add_Click({RegisterWindow})

$ButtonShowUser = New-Object System.Windows.Forms.Button
$ButtonShowUser.Location = New-Object System.Drawing.Size(750,50)
$ButtonShowUser.Size = New-Object System.Drawing.Size(100,100)
$imageShowUser = [System.Drawing.Image]::FromFile("$imagesPath\notimage.jpg")
$ButtonShowUser.Image = $imageShowUser
$ButtonShowUser.BackColor ="LightGray"
$ButtonShowUser.ForeColor = 'LightGray'
$ButtonShowUser.Add_Click({ShowUserWindow})

$ButtonSignIn = New-Object System.Windows.Forms.Button
$ButtonSignIn.Location = New-Object System.Drawing.Size(600,425)
$imageSignIn = [System.Drawing.Image]::FromFile("$imagesPath\singin.jpg")
$ButtonSignIn.Image = $imageSignIn
$ButtonSignIn.Width = $imageSignIn.Width
$ButtonSignIn.Height = $imageSignIn.Height
$ButtonSignIn.BackColor ="LightGray"
$ButtonSignIn.ForeColor = 'LightGray'
$ButtonSignIn.Add_Click({RegisterUsersWindowOK $Registro})

$ButtonAddServers = New-Object System.Windows.Forms.Button
$ButtonAddServers.Location = New-Object System.Drawing.Size(685,205)
$imageAddServers = [System.Drawing.Image]::FromFile("$imagesPath\add.jpg")
$ButtonAddServers.Width = $imageAddServers.Width
$ButtonAddServers.Height = $imageAddServers.Height
$ButtonAddServers.Image = $imageAddServers
$ButtonAddServers.BackColor ="LightGray"
$ButtonAddServers.ForeColor = 'LightGray'
$ButtonAddServers.Add_Click({$Dominio=$ListBoxDomains.SelectedItem;AddServer $Dominio})

$ButtonAddDomain = New-Object System.Windows.Forms.Button
$ButtonAddDomain.Location = New-Object System.Drawing.Size(485,205)
$imageAddDomain = [System.Drawing.Image]::FromFile("$imagesPath\add.jpg")
$ButtonAddDomain.Width = $imageAddDomain.Width
$ButtonAddDomain.Height = $imageAddDomain.Height
$ButtonAddDomain.Image = $imageAddDomain
$ButtonAddDomain.BackColor ="LightGray"
$ButtonAddDomain.ForeColor = 'LightGray'
$ButtonAddDomain.Add_Click({AddDomain})


$ButtonSelectImageUser = New-Object System.Windows.Forms.Button
$ButtonSelectImageUser.Location = New-Object System.Drawing.Size(620,20)
$ButtonSelectImageUser.Size = New-Object System.Drawing.Size(100,100)
$ButtonSelectImageUser.BackColor ="LightGray"
$ButtonSelectImageUser.ForeColor = 'LightGray'
$ButtonSelectImageUser.Add_Click({SelectImage})

$ButtonLocker = New-Object System.Windows.Forms.Button
$ButtonLocker.Location = New-Object System.Drawing.Size(285,400)
$imageLocker = [System.Drawing.Image]::FromFile("$imagesPath\locker.jpg")
$ButtonLocker.Width = $imageLocker.Width
$ButtonLocker.Height = $imageLocker.Height
$ButtonLocker.Image = $imageLocker
$ButtonLocker.BackColor ="LightGray"
$ButtonLocker.ForeColor = 'LightGray'
$ButtonLocker.Add_Click({EncryptPass})

$ButtonAddServersOK = New-Object System.Windows.Forms.Button
$ButtonAddServersOK.Location = New-Object System.Drawing.Size(770,250)
$ButtonAddServersOK.Size = New-Object System.Drawing.Size(60,60)
$imageAddServersOK = [System.Drawing.Image]::FromFile("$imagesPath\ok.jpg")
$ButtonAddServersOK.Image = $imageAddServersOK
$ButtonAddServersOK.BackColor ="LightGray"
$ButtonAddServersOK.ForeColor = 'LightGray'
$ButtonAddServersOK.Add_Click({$Servidor=$TextBoxAddServers.Text;$Dominio=$ListBoxDomains.SelectedItem;AddServersOK $Servidor $Dominio})

$ButtonAddDomainOK = New-Object System.Windows.Forms.Button
$ButtonAddDomainOK.Location = New-Object System.Drawing.Size(770,250)
$ButtonAddDomainOK.Size = New-Object System.Drawing.Size(60,60)
$imageAddDomainOK = [System.Drawing.Image]::FromFile("$imagesPath\ok.jpg")
$ButtonAddDomainOK.Image = $imageAddDomainOK
$ButtonAddDomainOK.BackColor ="LightGray"
$ButtonAddDomainOK.ForeColor = 'LightGray'
$ButtonAddDomainOK.Add_Click({$Servidor=$TextBoxAddServers.Text;$Dominio=$TextBoxAddDomain.Text;AddDomainOK $Servidor $Dominio})

$ButtonConfigPSM = New-Object System.Windows.Forms.Button
$ButtonConfigPSM.Location = New-Object System.Drawing.Size(75,400)
$imageConfigPSM = [System.Drawing.Image]::FromFile("$imagesPath\configPSM.jpg")
$ButtonConfigPSM.Width = $imageConfigPSM.Width
$ButtonConfigPSM.Height = $imageConfigPSM.Height
$ButtonConfigPSM.Image = $imageConfigPSM
$ButtonConfigPSM.BackColor ="LightGray"
$ButtonConfigPSM.ForeColor = 'LightGray'
$ButtonConfigPSM.Add_Click({ConfigPSM})

$ButtonConfigPSMOK = New-Object System.Windows.Forms.Button
$ButtonConfigPSMOK.Location = New-Object System.Drawing.Size(215,350)
$imageConfigPSMOK = [System.Drawing.Image]::FromFile("$imagesPath\singin.jpg")
$ButtonConfigPSMOK.Width = $imageConfigPSMOK.Width
$ButtonConfigPSMOK.Height = $imageConfigPSMOK.Height
$ButtonConfigPSMOK.Image = $imageConfigPSMOK
$ButtonConfigPSMOK.BackColor ="LightGray"
$ButtonConfigPSMOK.ForeColor = 'LightGray'
$ButtonConfigPSMOK.Add_Click({ConfigPSMOK})

$FormCyberArk = New-Object system.Windows.Forms.Form
$CenterScreen = [System.Windows.Forms.FormStartPosition]::CenterScreen;
$FormCyberArk.StartPosition = $CenterScreen
$FormCyberArk.Text = "CYBERARK"
$ImageFormCyberArk = [system.drawing.image]::FromFile("$imagesPath\fondo.jpg")
$FormCyberArk.BackgroundImage = $ImageFormCyberArk
$FormCyberArk.BackgroundImageLayout = "None"
$FormCyberArk.FormBorderStyle = 'Fixed3D'
$FormCyberArk.MaximizeBox = $false
$FormCyberArk.Width = $ImageFormCyberArk.Width
$FormCyberArk.Height = $ImageFormCyberArk.Height
$FormCyberArk.BackColor = "White"
$FontBold = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Bold)
$FontRegular = New-Object System.Drawing.Font("Times New Roman",12,[System.Drawing.FontStyle]::Regular)
$FormCyberArk.Font = $FontBold
$Icon = [system.drawing.icon]::ExtractAssociatedIcon("$imagesPath\cyber.ico")
$FormCyberArk.Icon = $Icon

$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0)
Main
$FormCyberArk.ShowDialog()
