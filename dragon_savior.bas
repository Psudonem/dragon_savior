$Resize:Stretch
Screen _NewImage(320, 200, 32), 0, 0, 1
Cls
Dim logo&
_Font 8
logo& = _LoadImage("graphics\logo.bmp")
tutorial& = _LoadImage("graphics\tutorial.png")
lore& = _LoadImage("graphics\lore.png")
titleMusic& = _SndOpen("audio\dragon_savior_title.wav")
dworld& = _SndOpen("audio\dragon world.wav")

k$ = ""
_SndVol titleMusic&, .1
_SndLoop titleMusic&
GoTo title

game:
_SndStop titleMusic&
_SndVol dworld&, .2
_SndPlay dworld&
Sleep
System


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

