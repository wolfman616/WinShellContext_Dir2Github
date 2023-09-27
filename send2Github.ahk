#NoEnv ; (MW:2023) (MW:2023)
#NoTrayicon
SetBatchLines,-1
ListLines,Off
#Persistent
#Singleinstance,Force
a_scriptStartTime:= a_tickCount 
Setworkingdir,% (splitpath(A_AhkPath)).dir
; #IfTimeout,200 ;* DANGER * : Performance impact if set too low. *think about using this*.
DetectHiddenWindows,On
DetectHiddenText,	On
SetTitleMatchMode,2
SetTitleMatchMode,Slow
SetWinDelay,-1
coordMode,	ToolTip,Screen
coordmode,	Mouse,	Screen
msgbox % a_args[1]
ListLines,On
;(!a_args[1]? exitapp())

if(!a_args[1]) {
	; exitapp()
	target_dir:= "C:\Users\ninj\Desktop11\Icon_2_cmd.exe.ps1"
} else,msgbox,% target_dir:= a_args[1]
SplitPath,target_dir,reponame
msgbox,%  reponame
if(fileexist(target_dir . "\.git")) { 
if commitmsgRequest() {

	commitMessage:= commitmsgGet()
; (!commitMessage? commitMessage:= "Commit") 

		Run,%comspec% /c C:\Script\cmd\gitpush.bat %commitMessage%,% target_dir ; Execute the Git push script with the commit message as an argument
	} else {
		msgbox,% "u chose no" ; User chose not to enter a commit message
		run,%comspec% /c C:\Script\cmd\gitpush.bat,% target_dir
	}
} else {
	MsgBox,4,% "Release new github repo",% "Do you want to specify a title other than dir name for this Git repo?`n`nPress Yes to enter a new title or No to proceed with: " reponame 
	IfMsgBox,Yes, {
		InputBox,reponamenew
			,Enter repo name,Please enter your desired repo name here:,,256 ,108,,,,,Commit
		(reponamenew!="")? reponame:= reponamenew
	}
	msgbox % reponame
if commitmsgRequest() {
	commitMessage:= commitmsgGet()
		Run,%comspec% /c C:\Script\cmd\gitaddnew.bat %reponame% %commitMessage%,% target_dir ; Execute the Git push script with the commit message as an argument

} else,run,%comspec% /c C:\Script\cmd\gitaddnew.bat %reponame%,% target_dir
} return,


commitmsgRequest() {
	local
	MsgBox,4,,% "Do you want to specify a commit message for this Git push?`n`nPress Yes to enter a message or No to proceed without a message."
	IfMsgBox,Yes
		answer:= true
	return,answer
}

commitmsgGet() {
	InputBox,commitMsg ; Prompt the user for a commit message
	,% "Enter Commit Message",% "Please enter your commit message here:",,256 ,108,,,,,Commit
	return,commitMsg? commitMsg : " "
}	