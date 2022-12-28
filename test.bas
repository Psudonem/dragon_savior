$Resize:Stretch
Screen _NewImage(320, 200, 32), 0, 0, 1
f = FreeFile
On Error GoTo 10

Dim map(50, 50)
Dim dragon&

Dim keyhit&

Type sounds
    door As Long
    money As Long ' haha
    gameplay_music As Long
End Type


Type gameType
    money As Integer

End Type
_Font 8

Dim sfx As sounds
Dim game As gameType
game.money = 0
sfx.door = _SndOpen("audio\door.wav")
sfx.money = _SndOpen("audio\money.wav")
sfx.gameplay_music = _SndOpen("audio\dragon_savior_gameplay.wav")

dragon& = _LoadImage("graphics\dragon.png")
bricks& = _LoadImage("graphics\bricks.png")
money& = _LoadImage("graphics\money.png")
hero& = _LoadImage("graphics\hero.png")
door& = _LoadImage("graphics\door.png")
x = 0
y = 0
camx = 10
camy = 4
'$include:'world.bas'
For y = 0 To 49
    For x = 0 To 49
        Read g
        map(x, y) = g
    Next x
Next y




10


px = -1
py = -1
For y = 0 To 49
    For x = 0 To 49
        If map(x, y) = 4 Then
            camx = x - 7
            camy = y - 5
            px = x
            py = y
        End If
    Next x
Next y




_SndLoop sfx.gameplay_music
Do
    Cls

    For y = 0 To 10
        For x = 0 To 14
            If (x + camx >= 0) And (x + camx < 50) And (y + camy >= 0) And (y + camy < 50) Then
                m = map(x + camx, (y + camy))
                If m = 1 Then
                    'Line (x * 16, y * 16)-(x * 16 + 16, y * 16 + 16), _RGB(63, 63, 63), BF
                    '        PSet (x, y), map(x, y) * 15
                    _PutImage (x * 16, y * 16), bricks&
                ElseIf m = 4 Then
                    _PutImage (x * 16, y * 16), dragon&
                ElseIf m = 2 Then
                    'Line (x * 16, y * 16)-(x * 16 + 16, y * 16 + 16), _RGB(63, 63, 63), BF
                    _PutImage (x * 16, y * 16), money&
                ElseIf m = 3 Then
                    _PutImage (x * 16, y * 16), door&

                ElseIf m = 7 Then
                    _PutImage (x * 16, y * 16), hero&
                End If
            End If
        Next x
    Next y
    Line (240, 0)-(240, 200), 15
    Color _RGB(255, 255, 255)
    Locate 1, 32: Print "DRAGON"
    Locate 2, 32: Print "SAVIOR"
    Color _RGB(100, 255, 100)
    Locate 4, 32: Print "MONEY"
    Locate 5, 33: Print "$" + Str$(game.money)
    Color _RGB(255, 100, 100)
    Locate 6, 32: Print "POWER"
    'Print "press  q to quit"
    PCopy 0, 1
    _Delay .01

    dx = 0
    dy = 0
    keyhit& = _KeyHit
    'k$ = InKey$
    Select Case keyhit&
        Case 100:
            dx = 1

        Case 119:
            dy = -1
        Case 115:
            dy = 1
        Case 97:
            dx = -1
    End Select
    keyhit& = 0
    _KeyClear
    If map(px + dx, py + dy) = 0 Then
        GoSub marchForth
    ElseIf map(px + dx, py + dy) = 2 Then
        map(px + dx, py + dy) = 0
        game.money = game.money + 1
        _SndPlay sfx.money
        GoSub marchForth

    ElseIf map(px + dx, py + dy) = 3 Then
        map(px + dx, py + dy) = 0
        _SndPlay sfx.door
        GoSub marchForth
    End If
    camx = px - 7
    camy = py - 5
Loop Until InKey$ = "q"
System


marchForth:
map(px, py) = 0
px = px + dx
py = py + dy
map(px, py) = 4

Return
