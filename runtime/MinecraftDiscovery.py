import os, sys
import json

def getMinecraftPath():
    winDir       = "~/AppData/Roaming/.minecraft"
    posixDir     = "~/.minecraft"
    macDir       = "~/.minecraft"
    
    if   sys.platform.startswith('linux'):
        return os.path.expanduser(posixDir)
    elif sys.platform.startswith('win'):
        return os.path.expanduser(winDir)
    elif sys.platform.startswith('darwin'):
        return os.path.expanduser(macDir)
    else:
        print "Cannot detect of version : %s. Please report to your closest sysadmin"%sys.platform
        sys.exit()

def getNativesKeyword():
    if   sys.platform.startswith('linux'):
        return "linux"
    elif sys.platform.startswith('win'):
        return "windows"
    elif sys.platform.startswith('darwin'):
        return "osx"
    else:
        print "Cannot detect of version : %s. Please report to your closest sysadmin"%sys.platform
        sys.exit()        

def checkMCDir(src, version):
    #We check that our version of MC is available for analysis
    if not os.path.exists(src) \
      or not os.path.exists(os.path.join(src, "versions")) \
      or not os.path.exists(os.path.join(src, "libraries")) \
      or not os.path.exists(os.path.join(os.path.join(src, "versions"), version)):
        print ("ERROR : You should run the launcher at least once before starting MCP")
        sys.exit()

def getJSONFilename(src, version):
    return os.path.join(os.path.join(src, "versions"), version, "%s.json"%version)

def checkCacheIntegrity(src, jsonfile, osKeyword):
    libraries = getLibraries(src, jsonfile, osKeyword)

    if libraries == None:
        return False

    for library in libraries.values():
        if not os.path.exists(os.path.join(src, library['filename'])):
            return False
    return True

def getLibraries(src, jsonfile, osKeyword):
    #We check the json exits
    if not os.path.exists(jsonfile):
        return None
        #print ("ERROR : json file %s not found."%jsonfile)
        #print ("You should run the launcher at least once before starting MCP")
        #sys.exit()
    
    #We parse the json file
    jsonFile = None    
    try:
        jsonFile = json.load(open(jsonfile))
    except Exception as e:
        print "Error while parsing the library JSON file : %s"%e
        sys.exit()
    
    mcLibraries  = jsonFile['libraries']
    outLibraries = {}
    
    for library in mcLibraries:
        libCononical = library['name'].split(':')[0]
        libSubdir    = library['name'].split(':')[1]
        libVersion   = library['name'].split(':')[2]
        libPath      = libCononical.replace('.', '/')
        extract      = False
        exclude     = []
    
        if 'natives' in library:
            libFilename = "%s-%s-%s.jar"%(libSubdir, libVersion, library['natives'][osKeyword])
        else:
            libFilename = "%s-%s.jar"%(libSubdir, libVersion)

        if 'extract' in library:
            extract = True
            if 'exclude' in library['extract']:
                exclude.extend(library['extract']['exclude'])
    
        libFullPath  = os.path.join(os.path.join(src, "libraries"), libPath, libSubdir, libVersion, libFilename)
        libRelativePath = os.path.join("libraries", libPath, libSubdir, libVersion, libFilename)
    
        #if not os.path.exists(libFullPath):
        #    print ("Error while trying to access libraries. Couldn't find %s"%libFullPath)
        #    sys.exit()

        outLibraries[libSubdir] = {'name':library['name'], 'filename':libRelativePath, 'extract':extract, 'exclude':exclude}

    return outLibraries