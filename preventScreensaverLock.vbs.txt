' Script simulating keyboard interaction every 5 seconds to prevent the machine from going idle.
Dim WshShell
Set WshShell = WScript.CreateObject("WScript.Shell")
Do While 1 < 100
WScript.Sleep 5000 ' 5-second WAIT
WshShell.SendKeys "{SCROLLLOCK}"
WScript.Sleep 1000 ' one-second delay
WshShell.SendKeys "{SCROLLLOCK}"
Loop
