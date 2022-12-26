$Resize:Stretch
Screen 13, 0, 0, 1
Cls
Dim brick(64)
Dim map(50, 50) As Integer


Restore brick

For y = 0 To 7
    For x = 0 To 7
        Read g
        PSet (x, y), g
    Next x
Next y

Get (0, 0)-(7, 7), brick()

PCopy 0, 1
px = 0
py = 0

Do
    Cls

    Put (px, py), brick()
    x = x + 1
    PCopy 0, 1
    _Delay .1
Loop


brick:
Data 04,04,04,15,04,04,04,15
Data 04,04,04,15,04,04,04,15
Data 04,04,04,15,04,04,04,15
Data 15,15,15,15,15,15,15,15
Data 15,04,04,04,15,04,04,04
Data 15,04,04,04,15,04,04,04
Data 15,04,04,04,15,04,04,04
Data 15,15,15,15,15,15,15,15

