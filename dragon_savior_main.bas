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
    getHurt As Long
    gameOver_music As Long
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
    power As Integer
    hp As Integer
    keys As Integer
    ' switch not needed anymore
End Type
_Font 8
level = 0

Dim sfx As sounds
Dim game As gameType

Dim enemies(50, 50) As enemy
Dim flames(50, 50) As flame
Dim projectiles(50, 50) As flame
Dim spikes(50, 50) As flame

Cls
Print "please wait"
PCopy 0, 1
For x = 0 To 49
    For y = 0 To 49
        enemies(x, y).alive = 0
    Next y
Next x


sfx.door = _SndOpen("audio\door.wav")
sfx.money = _SndOpen("audio\money.wav")
sfx.enemydeath = _SndOpen("audio\enemy_death.wav")
sfx.gameplay_music = _SndOpen("audio\dragon world.wav")
sfx.flameball = _SndOpen("audio\flameBall.wav")
sfx.getHurt = _SndOpen("audio\getHurt.wav")
sfx.gameOver_music = _SndOpen("audio\funk.wav")
' game over song will be funk.wav (famitracker)

last& = _LoadImage("graphics\lastimg.png")

dragon& = _LoadImage("graphics\dragon.png")
bricks& = _LoadImage("graphics\bricks.png")
money& = _LoadImage("graphics\money.png")
hero& = _LoadImage("graphics\hero.png")
door& = _LoadImage("graphics\door.png")
flameSprite& = _LoadImage("graphics\flameball.png")
projSprite& = _LoadImage("graphics\poisonrock.png")
spike& = _LoadImage("graphics\spike.png")
gameOver& = _LoadImage("graphics\gameOver.png")

endCard& = _LoadImage("graphics\endCard.png")

nextt& = _LoadImage("graphics\next.png")
logo& = _LoadImage("graphics\logo.bmp")
tutorial& = _LoadImage("graphics\tutorial.png")
lore& = _LoadImage("graphics\lore.png")
titleMusic& = _SndOpen("audio\dragon_savior_title.wav")


endMusic& = _SndOpen("audio\talk the talk.wav")

'$include:'world.bas'
'$include:'world2.bas'
'$include:'world3.bas'

'https://youtu.be/-vqQGdh2KmM

_SndVol titleMusic&, .1
_SndLoop titleMusic&

'GoTo ending
GoTo title
game:

_SndStop titleMusic&
GoTo restartgame
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



_SndVol sfx.gameplay_music, .1
_SndLoop sfx.gameplay_music 'disabled for now
Do
    Cls
    If game.hp < 1 Then GoTo gameOver

    For y = 0 To 10
        For x = 0 To 14
            If (x + camx >= 0) And (x + camx < 50) And (y + camy >= 0) And (y + camy < 50) Then
                e = 0
                m = map(x + camx, (y + camy))
                e = enemies(x + camx, (y + camy)).alive
                f = flames(x + camx, y + camy).status
                p = projectiles(x + camx, y + camy).status
                s = spikes(x + camx, y + camy).status
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

                ElseIf m = 9 Then
                    _PutImage (x * 16, y * 16), nextt&
                End If




                If e = 1 Then
                    _PutImage (x * 16, y * 16), hero&
                    GoSub enemyRun
                End If

                If f = 1 Then
                    _PutImage (x * 16, y * 16), flameSprite&
                    GoSub flameUpdate
                End If

                If p = 1 Then
                    _PutImage (x * 16, y * 16), projSprite&
                    GoSub projUpdate
                End If

                If s = 1 Then
                    _PutImage (x * 16, y * 16), spike&
                    GoSub spikeUpdate
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
    'Color _RGB(255, 100, 100)
    'Locate 7, 32: Print "POWER"
    'Locate 8, 33: Print "" + Str$(game.power)

    Color _RGB(255, 10, 100)
    Locate 10, 32: Print "HEALTH"
    Locate 11, 33: Print "" + Str$(game.hp)


    Color _RGB(100, 100, 100)
    Locate 13, 32: Print "LEVEL"
    Locate 14, 33: Print "" + Str$(level + 1)


    'Print "press  q to quit"

    Line (0, 0)-(15 * 16, 11 * 16), _RGB(255, 255, 255), B
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


    If map(px + dx, py + dy) = 9 Then
        level = level + 1
        GoTo restartgame
    End If
    If map(px + dx, py + dy) = 0 Then
        GoSub marchForth
    ElseIf map(px + dx, py + dy) = 2 Then
        map(px + dx, py + dy) = 0
        game.money = game.money + 1
        _SndVol sfx.money, 0.3
        _SndPlay sfx.money
        GoSub marchForth

    ElseIf map(px + dx, py + dy) = 3 Then
        map(px + dx, py + dy) = 0
        _SndVol sfx.door, .2
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


spikeUpdate:
sx = x + camx
sy = y + camy
xdir = spikes(sx, sy).xdir
ydir = spikes(sx, sy).ydir

If sx = px And sy = py Then
    _SndVol sfx.getHurt, .4
    _SndPlay sfx.getHurt
    game.hp = game.hp - 10
    spikes(sx, sy).status = 0
    Return
End If
If spikes(sx, sy).ttl = 0 Then
    'spikes(sx,sy)
    If map(sx, sy) > 0 Then
        xdir = xdir * -1
        ydir = ydir * -1
    End If

    If spikes(sx + xdir, sy + ydir).status = 1 Then
        xdir = xdir * -1
        ydir = ydir * -1

    End If

    If spikes(sx + xdir, sy + ydir).status = 0 Then
        spikes(sx + xdir, sy + ydir).status = 1
        spikes(sx + xdir, sy + ydir).xdir = xdir
        spikes(sx + xdir, sy + ydir).ydir = ydir
        spikes(sx + xdir, sy + ydir).ttl = 10
        spikes(sx, sy).status = 0
    End If
Else
    spikes(sx, sy).ttl = spikes(sx, sy).ttl - 1
End If

Return




projUpdate:
zx = x + camx
zy = y + camy
xdir = projectiles(zx, zy).xdir
ydir = projectiles(zx, zy).ydir


If px = zx And py = zy Then
    _SndVol sfx.getHurt, .4
    _SndPlay sfx.getHurt

    game.hp = game.hp - 1
    projectiles(zx, zy).status = 0

End If
If map(zx, zy) = 1 Then
    projectiles(zx, zy).status = 0
    Return
End If

If projectiles(zx, zy).ttl = 0 Then
    projectiles(zx + xdir, zy + ydir).status = 1
    projectiles(zx + xdir, zy + ydir).xdir = xdir
    projectiles(zx + xdir, zy + ydir).ydir = ydir
    projectiles(zx + xdir, zy + ydir).ttl = 7
    projectiles(zx + xdir, zy + ydir).power = projectiles(zx + xdir, zy + ydir).power - 1
    projectiles(zx, zy).status = 0
    projectiles(zx, zy).power = 0
    If projectiles(zx + xdir, zy + ydir).power = 0 Then
        projectiles(zx + xdir, zy + ydir).status = 0
    End If
Else
    projectiles(zx, zy).ttl = projectiles(zx, zy).ttl - 1
End If

Return


fireBallSpawn:
'fx = x + camx
'fy = y + camy
flames(px + fdx, py + fdy).status = 1
flames(px + fdx, py + fdy).xdir = fdx
flames(px + fdx, py + fdy).ydir = fdy

flames(px + fdx, py + fdy).power = 5

_SndVol sfx.flameball, .3
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


If px = ex And py = ey Then
    _SndVol sfx.getHurt, .4
    _SndPlay sfx.getHurt

    game.hp = game.hp - 2
    game.power = game.power + 1
    enemies(ex, ey).alive = 0

End If



dx = Int(Rnd * 3) - 1
dy = 0
If dx = 0 Then
    dy = Int(Rnd * 3) - 1
End If

If flames(ex, ey).status = 1 Then
    _SndVol sfx.enemydeath, 0.3
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
        If Int(Rnd * 10) = 1 Then
            projectiles(ex, ey).status = 1
            projectiles(ex, ey).xdir = dx * -1
            projectiles(ex, ey).ydir = dy * -1
            projectiles(ex, ey).ttl = 15
            projectiles(ex, ey).power = 15
        End If

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


gameOver:
_SndStop sfx.gameplay_music
_SndVol sfx.gameOver_music, .3
_SndLoop sfx.gameOver_music
Do
    Cls
    _PutImage (0, 0), gameOver&
    Color _RGB(255, 100, 255)
    Print
    Print "r - retry"
    Print
    Print "q - quit"
    k$ = InKey$
    Select Case k$
        Case "r"
            _SndStop sfx.gameOver_music
            GoTo restartgame
        Case "q"
            System
    End Select
    PCopy 0, 1
Loop



restartgame:

For y = 0 To 49
    For x = 0 To 49
        map(x, y) = 0
        spikes(x, y).status = 0
        enemies(x, y).alive = 0
    Next x
Next y

game.money = 0
game.hp = 20
game.power = 10

x = 0
y = 0
camx = 10
camy = 4
If level = 0 Then Restore level1
If level = 1 Then Restore level2
If level = 2 Then Restore level3
If level = 3 Then GoTo ending
On Error GoTo 10
For y = 0 To 49
    For x = 0 To 49
        Read g

        If g = 8 Then
            spikes(x, y).status = 1
            spikes(x, y).ttl = 10
            xdir = Int(Rnd * 3) - 1
            ydir = 0
            If xdir = 0 Then ydir = (-1) ^ (Int(Rnd * 2))
            spikes(x, y).xdir = xdir
            spikes(x, y).ydir = ydir
        ElseIf g = 7 Then
            enemies(x, y).alive = 1
            enemies(x, y).ttl = 10

        Else
            map(x, y) = g
        End If

    Next x


Next y
GoTo 10

















title:
Do
    Cls
    _PutImage (0, 0), logo&
    Print
    Print " PUSH P TO PLAY!"
    Print " PUSH T FOR TUTORIAL!"
    Locate 19, 25: Print "K. JASEY"
    Locate 20, 25: Print "2022"
    PCopy 0, 1
    _Delay .1

    k$ = InKey$
Loop Until k$ <> ""

Select Case k$
    Case "p"
        GoTo game
    Case "t"
        GoTo tutorial
End Select
GoTo title



tutorial:
Do
    Cls
    _PutImage (0, 0), tutorial&
    PCopy 0, 1
    _Delay .1
Loop Until InKey$ = " "

Do
    Cls
    _PutImage (0, 0), lore&
    PCopy 0, 1
    _Delay .1
Loop Until InKey$ = "p"



GoTo game







ending:
_SndStop sfx.gameplay_music
_SndStop titleMusic&
_SndVol endMusic&, .3
_SndLoop endMusic&
Do
    Cls
    _PutImage (0, 0), endCard&
    PCopy 0, 1
    _Delay .1
Loop Until InKey$ <> ""

Color _RGB(0, 255, 255)
Do
    Cls
    _PutImage (0, 0), last&
    Print
    Print " GAME CODE CONCEPT AND ASSETS BY "
    Print
    Print "  KAI JASEY"
    Print
    Print " SPECIAL THANKS TO"
    Print
    Print "  NATHAN NESTOR"
    Print
    Print
    Print
    Print
    Print
    Print
    Print
    Print "  PROJECT DURATION:"
    Print
    Print "  DEC 25-31, 2022"

    PCopy 0, 1
    _Delay .1
Loop


System

