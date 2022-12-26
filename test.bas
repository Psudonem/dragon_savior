Screen 13
f = FreeFile
filename$ = "map/screen1.txt"

Dim map(50, 50)
x = 0
y = 0
Open filename$ For Binary As #f
While Not EOF(f)
    char$ = Str$(LOF(f))
    Get #f, , char$
    Print char$;

    If char$ = "0" Then
        Print "omg !"
        map(x, y) = 0
        x = x + 1
    End If
    If char$ = "1" Then
        map(x, y) = 1
        x = x + 1
    End If
    If char$ = "|" Then

        x = 0
        y = y + 1
    End If


Wend
Close #f

Sleep
Cls

For y = 0 To 49
    For x = 0 To 49
        PSet (x, y), map(x, y) * 15
    Next x
Next y
Print "press  q to quit"

Do
Loop Until InKey$ = "q"
System
