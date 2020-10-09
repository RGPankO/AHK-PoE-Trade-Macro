#NoEnv
#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

PlayersList := "MisterOne MisterTwo MFStoner"
ItemName := ""
OfferPrice := ""
SkipPlayers := "inward brains SocietyOfKobes"

!g::
PlayersList := ""
InputBox, PlayersList , Please provide players list, Please provide players list, , 500, 500
return

!h::
ItemName := ""
InputBox, ItemName , Please provide Item Name, Please provide Item name, , 500, 500
return

!j::
OfferPrice := ""
InputBox, OfferPrice , Please provide Offer Price, Please provide Offer Price, , 500, 500
return

;!a::
;Send, %PlayersList%
;return

; Key to break the loop
!a::
BreakLoop = 1
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

    if A_Index >= 1
        Sleep, 750

    
    

    Send, @%PlayerName% %ItemName% %OfferPrice% 

    if (BreakLoop = 1)
        break 

    Sleep, 750

    if (BreakLoop = 1)
        break 
        
    Send, {Enter}
}
return
