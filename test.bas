Screen 13
f = FreeFile
filename$ = "map/screen1.txt"

Dim map(50, 50)
x = 0
y = 0
camx = 0
camy = 0
Open filename$ For Binary As #f
While Not EOF(f)
    char$ = Str$(LOF(f))
    Get #f, , char$

    'Print char$;

    For i = 0 To 4
        Print x, y
        c$ = Mid$(char$, i, 1)

        If x > 49 Then
            x = 0
            y = y + 1
        End If


        If c$ = "5" Then

            map(x, y) = 5
            x = x + 1
        End If


        If c$ = "4" Then

            map(x, y) = 4
            x = x + 1
        End If

        If c$ = "0" Then

            map(x, y) = 0
            x = x + 1
        End If

        If c$ = "1" Then
            map(x, y) = 1
            x = x + 1

        ElseIf c$ = "|" Then

            x = 0
            y = y + 1
        End If

    Next i


Wend
Close #f

Sleep
Do
    Cls

    For y = 0 To 10
        For x = 0 To 14
            Line (x * 16, y * 16)-(x * 16 + 16, y * 16 + 16), map(x + camx, y + camy) * 15, BF
            '        PSet (x, y), map(x, y) * 15
        Next x
    Next y
    'Print "press  q to quit"
    _Delay 1
    camy = camy + 1

Loop Until InKey$ = "q"
System
