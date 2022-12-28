$Resize:Stretch
Screen _NewImage(320, 200, 32), 0, 0, 1
Cls
Dim logo&
logo& = _LoadImage("graphics\logo.bmp")

GoSub title

System


title:
Do
    Cls
    _PutImage (0, 0), logo&
    Print "PUSH SPACE TO PLAY!"
    Locate 9, 25: Print "K. JASEY"
    Locate 10, 25: Print "2022"
    PCopy 0, 1
    _Delay .1

Loop Until InKey$ = " "
Return


' old code
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

    k$ = InKey$
    If k$ = "d" Then px = px + 8
    If k$ = "a" Then px = px - 8
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

