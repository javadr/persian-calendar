module = "pcalendar"

sourcefiles  = {"pcalendar.sty"}
installfiles = {"*.sty"}

-- the package output is plain numbers, so one engine is enough
checkengines = {"xetex"}
stdengine    = "xetex"
checkruns    = 1
