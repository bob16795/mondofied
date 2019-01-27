import tkinter
import os
import subprocess

top = tkinter.Tk()
home = os.path.expanduser('~')
os.environ['SDL_VIDEO_CENTERED'] = '1'

Topbar = tkinter.IntVar()
Bartype = tkinter.IntVar()
Gapps = tkinter.IntVar()
def update(lol = Gapps.get()):
    with open('main.conf','r') as infile:
        with open("out.txt", "w") as outfile:
            for line in infile:
                new_line = line.replace("__barpos__", str(Topbar.get()))
                new_line = new_line.replace("__bar__", str(Bartype.get()))
                new_line = new_line.replace("__gapps__", str(lol))
                outfile.write(new_line)

Frame_Topbar = tkinter.Frame(top)
Topbar_c = tkinter.Checkbutton(Frame_Topbar, text = "Top Bar", variable = Topbar, \
                               onvalue = 1, offvalue = 0, command = update)

Frame_Bartype = tkinter.Frame(top)
BarType0_r = tkinter.Radiobutton(Frame_Bartype, text="Selected window", variable=Bartype, value=0,
                                 command=update)
BarType1_r = tkinter.Radiobutton(Frame_Bartype, text="All windows", variable=Bartype, value=1,
                                 command=update)
Gapps_s = tkinter.Scale( top, variable = Gapps, from_ = 0, to = 40, \
                        command = update )

Frame_Topbar.pack()
Topbar_c.pack(side = tkinter.LEFT)


Frame_Bartype.pack()
BarType0_r.pack(side = tkinter.LEFT)
BarType1_r.pack(side = tkinter.LEFT)
Gapps_s.pack()

top.mainloop()

subprocess.call(["mondo", "-fu", "dwm"])
print("updated mondo")
