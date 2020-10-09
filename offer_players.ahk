#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

PlayersList := ""
TradeMsg := ""
SkipPlayers := "inward brains polo SocietyOfKobes"


!g::  ;  Key to setup trade spam & Key to break the loop
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



; Key to pasue script
!a::
Pause, Toggle, 1
If (A_IsPaused) {
    TrayTip , Trade spam, Script is paused!, 4
} else {
    TrayTip , Trade spam, Script is unpaused!, 4
}

return



!k::
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
return




ran(min, max)
 {
   random, ran, min, max
   return ran
 }