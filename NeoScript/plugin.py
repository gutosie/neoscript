##
## ScriptNeo
## by gutosie
##
from enigma import getDesktop
from Components.ActionMap import ActionMap
from Components.MenuList import MenuList
from os import listdir
from Plugins.Plugin import PluginDescriptor
from Screens.Console import Console
from Screens.Screen import Screen
import os
from os import system
from Tools.Directories import fileExists

############################################

def getDS():
    s = getDesktop(0).size()
    return (s.width(), s.height())

def isFHD():
    desktopSize = getDS()
    return desktopSize[0] == 1920

def isHD():
    desktopSize = getDS()
    return desktopSize[0] >= 1280 and desktopSize[0] < 1920

def isUHD():
    desktopSize = getDS()
    return desktopSize[0] >= 1920 and desktopSize[0] < 3840


def getCPUtype():
    cpu = 'UNKNOWN'
    if os.path.exists('/proc/cpuinfo'):
        with open('/proc/cpuinfo', 'r') as f:
            lines = f.read()
            f.close()
        if lines.find('ARMv7') != -1:
            cpu = 'ARMv7'
        elif lines.find('mips') != -1:
            cpu = 'MIPS'
        elif lines.find('sh4') != -1:
            cpu = 'SH4'            
    return cpu

def getCPU():
    if not fileExists('/usr/bin/fullwget'):
        if getCPUtype() == 'MIPS':
                os.system('mv /usr/lib/enigma2/python/Plugins/Extensions/NeoScript/neodir/fullwgetmips /usr/bin/fullwget')
        elif getCPUtype() == "ARMv7":
                os.system('mv /usr/lib/enigma2/python/Plugins/Extensions/NeoScript/neodir/fullwgetarm /usr/bin/fullwget')
        elif getCPUtype() == "SH4":
                os.system('mv /usr/lib/enigma2/python/Plugins/Extensions/NeoScript/neodir/fullwgetsh4 /usr/bin/fullwget')
	os.system('chmod 755 /usr/bin/fullwget')
    else:
        pass
        
class ScriptNeo(Screen):
    if isFHD():
	skin = """
	<screen position="center,center" size="1000,750" title="Updatel list" >
            <widget name="list" render="Listbox" itemHeight="50" font="Regular;40" position="25,80" zPosition="1" size="950,650" scrollbarMode="showOnDemand" transparent="1">
            <convert type="StringList" font="Regular;70" />
          </widget>
	</screen>"""
    else:
	skin = """
	<screen position="center,center" size="700,340" title="NeoScript" >
		<widget name="list" position="center,center" size="680,320" zPosition="1" font="Regular;24" transparent="1" 
scrollbarMode="showOnDemand" />
	</screen>"""


        #---------------------------------------------
        os.system('chmod 755 /usr/lib/enigma2/python/Plugins/Extensions/NeoScript/script/*.sh')
        getCPU()
        #---------------------------------------------
        
	def __init__(self, session, args=None):
		Screen.__init__(self, session)
		self.session = session
		
		self["list"] = MenuList([])
		self["actions"] = ActionMap(["OkCancelActions"], {"ok": self.run, "cancel": self.close}, -1)
		
		self.onLayoutFinish.append(self.loadScriptList)

	def loadScriptList(self):
		try:
			list = listdir("/usr/lib/enigma2/python/Plugins/Extensions/NeoScript/script/")
			list.sort()
			list = [x[:-3] for x in list if x.endswith('.sh')]
		except:
			list = []
		
		self["list"].setList(list)

	def run(self):
		try:
			script = self["list"].getCurrent()
		except:
			script = None
		
		if script is not None:
			title = script
			script = "/usr/lib/enigma2/python/Plugins/Extensions/NeoScript/script/%s.sh" % script
			
			self.session.open(Console, title, cmdlist=[script])

############################################

def main(session, **kwargs):
	session.open(ScriptNeo)

def startSetup(menuid):
    if menuid != 'mainmenu':
        return []
    else:
        return [(_('Aktualizacja listy'),
          main,
          'tvlist',
          None)]


def Plugins(**kwargs):
    return [PluginDescriptor(name='Satellite list PL', description=_('HB list PL'), where=PluginDescriptor.WHERE_MENU, fnc=startSetup)]
 
 
