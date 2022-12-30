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
    enemydeath As Long
    flameball As Long
End Type


Type enemy
    ttl As Integer ' countdown timer decides how long it waits before the next move
    alive As Integer
End Type

Type flame
    xdir As Integer
    ydir As Integer
    status As Integer
    ttl As Integer
    power As Integer
End Type


Type gameType
    money As Integer
    enemies As Integer
    stamina As Integer
    ' switch not needed anymore
End Type
_Font 8

Dim sfx As sounds
Dim game As gameType

Dim enemies(50, 50) As enemy
Dim flames(50, 50) As flame

Cls
Print "please wait"
PCopy 0, 1
For x = 0 To 49
    For y = 0 To 49
        enemies(x, y).alive = 0
    Next y
Next x


game.money = 0
sfx.door = _SndOpen("audio\door.wav")
sfx.money = _SndOpen("audio\money.wav")
sfx.enemydeath = _SndOpen("audio\enemy_death.wav")
sfx.gameplay_music = _SndOpen("audio\dragon_savior_gameplay.wav")
sfx.flameball = _SndOpen("audio\flameBall.wav")

dragon& = _LoadImage("graphics\dragon.png")
bricks& = _LoadImage("graphics\bricks.png")
money& = _LoadImage("graphics\money.png")
hero& = _LoadImage("graphics\hero.png")
door& = _LoadImage("graphics\door.png")
flameSprite& = _LoadImage("graphics\flameball.png")
x = 0
y = 0
camx = 10
camy = 4
'$include:'world.bas'
For y = 0 To 49
    For x = 0 To 49
        Read g
        If g = 7 Then
            enemies(x, y).alive = 1
            enemies(x, y).ttl = 10
        ElseIf g <> 7 Then
            map(x, y) = g
        End If

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




'_SndLoop sfx.gameplay_music  'disabled for now
Do
    Cls

    For y = 0 To 10
        For x = 0 To 14
            If (x + camx >= 0) And (x + camx < 50) And (y + camy >= 0) And (y + camy < 50) Then
                e = 0
                m = map(x + camx, (y + camy))
                e = enemies(x + camx, (y + camy)).alive
                f = flames(x + camx, y + camy).status
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

                If e = 1 Then
                    _PutImage (x * 16, y * 16), hero&
                    GoSub enemyRun
                End If

                If f = 1 Then
                    _PutImage (x * 16, y * 16), flameSprite&
                    GoSub flameUpdate
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
        ' directional inputs
        Case 100:
            dx = 1

        Case 119:
            dy = -1
        Case 115:
            dy = 1
        Case 97:
            dx = -1


            ' shooting inputs
        Case 106: 'j
            fdx = -1
            fdy = 0
            GoSub fireBallSpawn
        Case 108: 'l
            fdx = 1
            fdy = 0
            GoSub fireBallSpawn

        Case 105: 'i
            fdy = -1
            fdx = 0
            GoSub fireBallSpawn
        Case 107: 'k
            fdy = 1
            fdx = 0
            GoSub fireBallSpawn
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



flameUpdate:
fx = x + camx
fy = y + camy
xdir = flames(fx, fy).xdir
ydir = flames(fx, fy).ydir

If map(fx, fy) = 1 Then
    flames(fx, fy).status = 0
    Return
End If



If flames(fx, fy).ttl = 0 Then

    flames(fx + xdir, fy + ydir).status = 1
    flames(fx + xdir, fy + ydir).xdir = xdir
    flames(fx + xdir, fy + ydir).ydir = ydir
    flames(fx + xdir, fy + ydir).ttl = 5
    flames(fx + xdir, fy + ydir).power = flames(fx, fy).power - 1
    flames(fx, fy).status = 0
    flames(fx, fy).power = 0
    If flames(fx + xdir, fy + ydir).power = 0 Then
        flames(fx + xdir, fy + ydir).status = 0
    End If
Else
    flames(fx, fy).ttl = flames(fx, fy).ttl - 1
End If

Return

fireBallSpawn:
'fx = x + camx
'fy = y + camy
flames(px + fdx, py + fdy).status = 1
flames(px + fdx, py + fdy).xdir = fdx
flames(px + fdx, py + fdy).ydir = fdy

flames(px + fdx, py + fdy).power = 5


_SndPlay sfx.flameball

'If map(fx, fy + 1) = 0 Then
'   enemies(fx, fy + 1).alive = 1
'flames(fx, fy).status = 1
'flames(fx, fy).xdir = 0
'flames(fx, fy).ydir = 1
'flames(fx, fy).ttl = 10
'End If


Return


enemyRun:
ex = x + camx
ey = y + camy
dx = Int(Rnd * 3) - 1
dy = 0
If dx = 0 Then
    dy = Int(Rnd * 3) - 1
End If

If flames(ex, ey).status = 1 Then
    _SndPlay sfx.enemydeath
    enemies(ex, ey).alive = 0
    enemies(ex, ey).ttl = 0
    flames(ex, ey).status = 0
    If Int(Rnd * 4) = 2 Then
        map(ex, ey) = 2
    End If
    Return
End If

If enemies(ex, ey).ttl = 0 Then
    If map(ex + dx, ey + dy) = 0 And enemies(ex + dx, ey + dy).alive = 0 Then
        enemies(ex + dx, ey + dy).alive = 1
        enemies(ex + dx, ey + dy).ttl = Int(Rnd * 10) + 25
        enemies(ex, ey).alive = 0
        enemies(ex, ey).ttl = 0


    End If
Else
    enemies(ex, ey).ttl = enemies(ex, ey).ttl - 1
End If

Return


marchForth:
map(px, py) = 0
px = px + dx
py = py + dy
map(px, py) = 4

Return
