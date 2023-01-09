##
## ScriptNeo
## by gutosie
##
from Components.ActionMap import ActionMap
from Components.MenuList import MenuList
from os import listdir
from Plugins.Plugin import PluginDescriptor
from Screens.Console import Console
from Screens.Screen import Screen
import os
import sys
from os import system
from Tools.Directories import fileExists, SCOPE_PLUGINS

def getCPUtype():
    cpu = 'UNKNOWN'
    if os.path.exists('/proc/cpuinfo'):
        with open('/proc/cpuinfo', 'r') as f:
            lines = f.read()
            f.close()
        if lines.find('ARMv7') != -1:
            cpu = "ARMv7"
        elif lines.find('mips') != -1:
            cpu = "MIPS"
        elif lines.find('sh4') != -1:
            cpu = "sh4"            
        if os.path.exists('/proc/stb/info/model'):
            with open('/proc/stb/info/model', 'r') as f:
                lines = f.read()
                f.close()            
            if lines.find('nbox') != -1:
                cpu = "nbox"
    return cpu
    
def getCPU():
        if getCPUtype() == "nbox":
                os.system('mv /usr/lib/enigma2/python/Plugins/Extensions/NeoScript/neodir/fullwgetsh4 /usr/bin/fullwget')    
        elif getCPUtype() == "ARMv7":
                os.system('mv /usr/lib/enigma2/python/Plugins/Extensions/NeoScript/neodir/fullwgetarm /usr/bin/fullwget')
        elif getCPUtype() == "MIPS":
                os.system('mv /usr/lib/enigma2/python/Plugins/Extensions/NeoScript/neodir/fullwgetmips /usr/bin/fullwget')                
        elif getCPUtype() == "sh4":
                os.system('mv /usr/lib/enigma2/python/Plugins/Extensions/NeoScript/neodir/fullwgetsh4 /usr/bin/fullwget')
		
        os.system('chmod 755 /usr/bin/fullwget; rm -r /usr/lib/enigma2/python/Plugins/Extensions/NeoScript/neodir')
        
class ScriptNeo(Screen):
        skin = """
	<screen position="center,center" size="900,390" title="Updatel list" >
            <widget name="list" render="Listbox" itemHeight="50" font="Regular;40" position="center,center" zPosition="1" size="870,370" scrollbarMode="showOnDemand" transparent="1">
            <convert type="StringList" font="Regular;70" />
          </widget>
	</screen>"""
	
        os.system('chmod 755 /usr/lib/enigma2/python/Plugins/Extensions/NeoScript/script/*.sh')
        if not fileExists('/usr/bin/fullwget') and fileExists('/usr/lib/enigma2/python/Plugins/Extensions/NeoScript/neodir'):
            getCPU()
        elif fileExists('/usr/lib/enigma2/python/Plugins/Extensions/NeoScript/neodir'):
            os.system('chmod 755 /usr/bin/fullwget; rm -r /usr/lib/enigma2/python/Plugins/Extensions/NeoScript/neodir')
        else:
            pass
            
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
			
def main(session, **kwargs):
	session.open(ScriptNeo)

def startList(menuid):
    if menuid != 'mainmenu':
        return []
    else:
        return [(_('Aktualizacja listy tv'),
          main,
          'tvlist',
          None)]

from Plugins.Plugin import PluginDescriptor

def Plugins(**kwargs):
    list = [PluginDescriptor(name='List Tv Updater', description='Installing List', where=PluginDescriptor.WHERE_MENU, fnc=startList), PluginDescriptor(name='List Tv Updater', description=_('Installing List'), icon='listtv.png', where=PluginDescriptor.WHERE_PLUGINMENU, fnc=main)]
    list.append(PluginDescriptor(name=_('List Tv Updater'), where=PluginDescriptor.WHERE_EXTENSIONSMENU, fnc=main))
    return list
