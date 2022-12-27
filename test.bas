Screen 13, 0, 0, 1
f = FreeFile
On Error GoTo 10

Dim map(50, 50)

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





Do
    Cls

    For y = 0 To 10
        For x = 0 To 14
            If (x + camx >= 0) And (x + camx < 50) And (y + camy >= 0) And (y + camy < 50) Then
                Line (x * 16, y * 16)-(x * 16 + 16, y * 16 + 16), map(x + camx, (y + camy)) * 15, BF
                '        PSet (x, y), map(x, y) * 15
            End If
        Next x
    Next y
    Line (240, 0)-(240, 200), 15
    Locate 1, 32: Print "DRAGON"
    Locate 2, 32: Print "SAVIOR"
    'Print "press  q to quit"
    PCopy 0, 1
    _Delay .1

    dx = 0
    dy = 0
    k$ = InKey$
    Select Case k$
        Case "d":
            dx = 1

        Case "w":
            dy = -1
        Case "s":
            dy = 1
        Case "a":
            dx = -1
    End Select
    k$ = ""
    If map(px + dx, py + dy) = 0 Then
        map(px, py) = 0
        px = px + dx
        py = py + dy
        map(px, py) = 4
    End If
    camx = px - 7
    camy = py - 5
Loop Until InKey$ = "q"
System
