On Error GoTo 10
'$include:'world.bas'
Dim map(50, 50)
Screen 13
For y = 0 To 49
    For x = 0 To 49
        Read g
        map(x, y) = g
        Line (x * 16, y * 16)-(x * 16 + 16, y * 16 + 16), g * 15, BF
    Next x
Next y


10
Sleep
System
