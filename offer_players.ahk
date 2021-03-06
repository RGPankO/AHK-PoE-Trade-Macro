#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%


ConfigINI=%A_scriptdir%\Config.ini
ifnotexist,%ConfigINI%
{
    IniWrite,inward brains polo SocietyOfKobes rg_      , %ConfigINI% ,IgnoreList	, Conf_SkipPlayers
	IniWrite,!j	,	%ConfigINI%,	Settings       		, Conf_HKPlayerList
	IniWrite,!k	,	%ConfigINI%,	Settings       		, Conf_HKStart
	IniWrite,!l	,	%ConfigINI%,	Settings       		, Conf_HKIgnoreList
	IniWrite,!a	,	%ConfigINI%,	Settings       		, Conf_HKPause
}


PlayersList := ""
TradeMsg := ""
IniRead, SkipPlayers, Config.ini, IgnoreList, Conf_SkipPlayers


; Hotkey part start

IniRead, vSetupKey, Config.ini, Settings, Conf_HKPlayerList
Hotkey, % vSetupKey, SetupThing

IniRead, vStartKey, Config.ini, Settings, Conf_HKStart
Hotkey, % vStartKey, StartThing

IniRead, vPauseKey, Config.ini, Settings, Conf_HKPause
Hotkey, % vPauseKey, PauseThing

IniRead, vIgnoreKey, Config.ini, Settings, Conf_HKIgnoreList
Hotkey, % vIgnoreKey, IgnoreThing

Return ; Hotkey part end




SetupThing:  ;  Key to setup trade spam & Key to break the loop
If BreakLoop = 0
{

    BreakLoop = 1
    MsgBox Stopped!

} else {

    Gui, Add, Text, x12 y20 w80 h30, PlayersList:
    Gui, Add, Text, x12 y100 w80 h30, Trade Message: 
    Gui, Add, Edit, x122 y20 w400 h60 vPlayersList, %PlayersList%
    Gui, Add, Edit, x122 y100 w400 h60 vTradeMsg, %TradeMsg%
    Gui, Add, Button, x12 y170 w40 h30 , OK
    Gui, Add, Button, x52 y170 w40 h30 , Cancel
    Gui, Show, x600 y400 h200 w600, GuiSize
}

Return


; ignore list add/remove
IgnoreThing:
Gui, Add, Text, x12 y20 w80 h30, PlayersList:
Gui, Add, Edit, x12 y60 w400 h60 vSkipPlayers, %SkipPlayers%
Gui, Add, Button, x12 y170 w50 h30 , Confirm
Gui, Add, Button, x62 y170 w40 h30 , Cancel
Gui, Show, x600 y400 h200 w500, GuiSize

return



ButtonConfirm: 
Gui, Submit ; Save all the information in the GUI (The variables)
Gui, Destroy ; Destroy the GUI to get it out of the way
IniWrite,%SkipPlayers%, %ConfigINI% ,IgnoreList	, Conf_SkipPlayers

Return

ButtonOK: 
Gui, Submit ; Save all the information in the GUI (The variables)
Gui, Destroy ; Destroy the GUI to get it out of the way
Return


ButtonCancel: 
Gui, Destroy
Return

GuiClose:
Gui, Destroy
Return



; pause script
PauseThing:
Pause, Toggle, 1
If (A_IsPaused) {
    TrayTip , Trade spam, Script is paused!, 4
} else {
    TrayTip , Trade spam, Script is unpaused!, 4
}

return





StartThing:
BreakLoop = 0
players_array := StrSplit(PlayersList, A_Space) 
Loop % players_array.MaxIndex()
{
    if (BreakLoop = 1)
        break 

    SkipPlayer = 0
    PlayerName := players_array[A_Index]

    SkipPlayers_array := StrSplit(SkipPlayers, A_Space) 
    Loop % SkipPlayers_array.MaxIndex()
    {
        SkipPlayerName := SkipPlayers_array[A_Index]
        IfInString, PlayerName, %SkipPlayerName%
        {
            SkipPlayer = 1
        }
    }

    if (SkipPlayer = 1)
        continue 

    Send, {Enter}
	Send ^{a}

    if A_Index >= 1
        Sleep, ran(750, 800)

    Send, @%PlayerName% %TradeMsg%

    if (BreakLoop = 1)
        break 

    Sleep, ran(750, 800)

    if (BreakLoop = 1)
        break 
        
    Send, {Enter}
}
BreakLoop = 1
return




ran(min, max)
 {
   random, ran, min, max
   return ran
 }
return