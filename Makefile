# Python version
PYTHON= python3
HEADLESS= TRUE
PROCESS = 8
RESULTS_FOLDER= Results/
SCENARIOS_FOLDER= Tests/
VENV= .venv

# Os detection
ifeq ($(shell uname -s),Linux)
	OS_NAME= LINUX
	PYTHON= $(VENV)/bin/python
	PIP= $(VENV)/bin/pip
else ifeq ($(shell uname -s),Darwin)
	OS_NAME= MAC_OS
	PYTHON= $(VENV)/bin/python
	PIP= $(VENV)/bin/pip
else
	OS_NAME= WINDOWS
	PYTHON= $(VENV)\Scripts\python.exe
	PIP= $(VENV)\Scripts\pip.exe
endif

# Defines the default target that `make` will to try to make, or in the case of a phony target, execute the specified commands
.PHONY: install chrome
# This target is executed whenever we just type `make`
.DEFAULT_GOAL = help

help:
	@echo "---------------HELP-----------------"
	@echo "To install the project type : make install"
	@echo "To update chrome webdriver (chrome is required) : make update-chromedriver"
	@echo "To run test with local resources type : make test TEST=TAGS-XXXXX HEADLESS=FALSE"
	@echo "To run several tests in parallel type : make ptest TEST=TAGS-XXXXX PROCESS=8"
	@echo "To open test results type : make open-log / make open-report"
	@echo "To clean all log types : make clean-all"
	@echo "------------------------------------"

os:
	@echo $(OS_NAME)

### TO RESET LOCAL INSTALLATION ############################
### WARNING ON UBUNTU WE NEED ONE VERSION KEEP INSTALLED ###
#
# Deleting the frameworks :
# sudo rm -rf /Library/Frameworks/Python.framework/Versions/[version number] replacing [version number] with 3.10 in your case.
#
# Removing symbolic links to list the broken symbolic links :
# ls -l /usr/local/bin | grep '../Library/Frameworks/Python.framework/Versions/[version number]'
#
# And to remove these links :
# cd /usr/local/bin
# ls -l /usr/local/bin | grep '../Library/Frameworks/Python.framework/Versions/[version number]' | awk '{print $9}' | tr -d @ | xargs rm*
#
# Remove all pip packages :
# pip freeze | xargs pip uninstall -y
#
###################################

clean-venv:
ifeq ($(OS_NAME),WINDOWS)
	@powershell -Command "if (Test-Path '$(VENV)') { Remove-Item -Path '$(VENV)' -Recurse -Force }"
else
	rm -rf $(VENV)
endif

install: clean-venv
ifeq ($(OS_NAME),MAC_OS)
	@echo "OS detection : Mac OS X platform"
	brew update && brew install wget curl unzip python@3.10
	python3.10 -m venv $(VENV)
else ifeq ($(OS_NAME),LINUX)
	@echo "OS detection : GNU/Linux platform"
	sudo apt-get update && sudo apt-get install -y wget curl unzip python3.10 python3-pip python3.10-venv
	python3.10 -m venv $(VENV)
else
	choco install -y python3 --version=3.10.11 --force
	py -m venv $(VENV)
endif
	$(PYTHON) -m pip install --upgrade pip
	make upgrade-pylibs
	make install-rfbrowser

upgrade-pylibs:
	$(PIP) install -r requirements.txt

install-chromedriver:
ifeq ($(OS_NAME),MAC_OS)
	@echo "OS detection : Mac OS X platform"
	@bash install-chrome-mac.sh
else ifeq ($(OS_NAME),LINUX)
	@echo "OS detection : GNU/Linux platform"
	@bash install-chrome-linux.sh
endif

install-rfbrowser:
ifeq ($(OS_NAME),LINUX)
	source .venv/bin/activate
	rfbrowser init
else ifeq ($(OS_NAME),MAC_OS)
	source .venv/bin/activate
	rfbrowser init
else
	$(VENV)\Scripts\rfbrowser.exe init
endif

tidy:
	$(PYTHON) -m robotidy .

# Run test(s)
test: $(PYTHON)
	$(PYTHON) -m robot -v HEADLESS:${HEADLESS} -i ${TEST} -d ${RESULTS_FOLDER} ${SCENARIOS_FOLDER}

ptest: $(PYTHON)
	$(PYTHON) -m pabot --processes ${PROCESS} --pabotlib -x result.xml -v HEADLESS:${HEADLESS} -i ${TEST} -d ${RESULTS_FOLDER} ${SCENARIOS_FOLDER}

clean-sc:
	rm -rf Results/*.png

clean-all:
	rm -rf Results/*

open-log:
ifeq ($(OS_NAME),darwin)
	@echo "OS detection : Mac OS X platform"
	open -a "Google Chrome" Results/log.html
else ifeq ($(OS_NAME),linux)
	@echo "OS detection : GNU/Linux platform"
	google-chrome  Results/log.html
endif

open-report:
ifeq ($(OS_NAME),darwin)
	@echo "OS detection : Mac OS X platform"
	open -a "Google Chrome" Results/report.html
else ifeq ($(OS_NAME),linux)
	@echo "OS detection : GNU/Linux platform"
	google-chrome  Results/report.html
endif