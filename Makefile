PY?=python3
PELICAN?=pelican
PELICANOPTS=

BASEDIR=$(CURDIR)
THEMEDIR=$(BASEDIR)/theme
CSSDIR=$(THEMEDIR)/static/css
SCSSDIR=$(THEMEDIR)/styling
INPUTDIR=$(BASEDIR)/content
OUTPUTDIR=$(BASEDIR)/output
PLUGINSDIR=$(BASEDIR)/plugins
CONFFILE=$(BASEDIR)/pelicanconf.py
PUBLISHCONF=$(BASEDIR)/publishconf.py

# pelican plugins
I18N_SUBSITES_DIR=$(PLUGINSDIR)/i18n_subsites

# pip3 (python3-pip) on Ubuntu 20.04 gives following warning while installing requirements.txt:
# WARNING: The scripts pelican, pelican-import, pelican-quickstart and pelican-themes are installed in '${HOME}/.local/bin' which is not on PATH.
export PATH := ${PATH}:${HOME}/.local/bin


DEBUG ?= 0
ifeq ($(DEBUG), 1)
	PELICANOPTS += -D
endif

RELATIVE ?= 0
ifeq ($(RELATIVE), 1)
	PELICANOPTS += --relative-urls
endif

default: devserver

help:
	@echo 'Makefile for a pelican Web site                                           '
	@echo '                                                                          '
	@echo 'Usage:                                                                    '
	@echo '   make html                           (re)generate the web site          '
	@echo '   make clean                          remove the generated files         '
	@echo '   make regenerate                     regenerate files upon modification '
	@echo '   make publish                        generate using production settings '
	@echo '   make serve [PORT=8000]              serve site at http://localhost:8000'
	@echo '   make serve-global [SERVER=0.0.0.0]  serve (as root) to $(SERVER):80    '
	@echo '   make devserver [PORT=8000]          serve and regenerate together      '
	@echo '                                                                          '
	@echo 'Set the DEBUG variable to 1 to enable debugging, e.g. make DEBUG=1 html   '
	@echo 'Set the RELATIVE variable to 1 to enable relative urls                    '
	@echo '                                                                          '

html: scss
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

clean:
	[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)

regenerate: scss
	$(PELICAN) -r $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)

serve:
ifdef PORT
	$(PELICAN) -l $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -p $(PORT)
else
	$(PELICAN) -l $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
endif

serve-global:
ifdef SERVER
	$(PELICAN) -l $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -p $(PORT) -b $(SERVER)
else
	$(PELICAN) -l $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -p $(PORT) -b 0.0.0.0
endif


devserver: scss hans
	@echo "\033[92mCreating sites and Run dev server ...\033[0m"
ifdef PORT
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS) -p $(PORT)
else
	$(PELICAN) -lr $(INPUTDIR) -o $(OUTPUTDIR) -s $(CONFFILE) $(PELICANOPTS)
endif

publish: scss hans
	$(PELICAN) $(INPUTDIR) -o $(OUTPUTDIR) -s $(PUBLISHCONF) $(PELICANOPTS)

scss:
	@echo "\033[92mCreating CSS ...\033[0m"
	[ -d $(CSSDIR) ] || mkdir -p $(CSSDIR)
	$(PY) -mscss < $(SCSSDIR)/style.scss -I $(SCSSDIR) -o $(CSSDIR)/style.css

download:
	# download pelican i18n_subsites plugin
	@echo "\033[92mDownloading pelican i18n_subsites plugin ...\033[0m"
	[ ! -d $(I18N_SUBSITES_DIR) ] || rm -rf $(I18N_SUBSITES_DIR)
	mkdir -p $(I18N_SUBSITES_DIR)
	wget -P $(I18N_SUBSITES_DIR) https://raw.githubusercontent.com/getpelican/pelican-plugins/master/i18n_subsites/__init__.py
	wget -P $(I18N_SUBSITES_DIR) https://raw.githubusercontent.com/getpelican/pelican-plugins/master/i18n_subsites/i18n_subsites.py

s2t:
	@# https://stackoverflow.com/a/21335519
	@echo "\033[92mReplace Simplified Chinese terms with Traditional Chinese terms ...\033[0m"
	@find $(INPUTDIR) -type f -exec sed -i 's/雜志/雜誌/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/准備/準備/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/盡管/儘管/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/摩诃/摩訶/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/答復/答覆/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/淩晨/凌晨/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/輪回/輪迴/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/借口/藉口/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/回向/迴向/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/稱贊/稱讚/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/征兆/徵兆/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/仿佛/彷彿/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/輕松/輕鬆/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/想象/想像/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/細致/細緻/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/放松/放鬆/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/標准/標準/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/喻伽/瑜伽/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/瞄准/瞄準/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/涅磐/涅槃/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/沖擊/衝擊/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/標簽/標籤/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/沖動/衝動/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/治愈/治癒/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/游方/遊方/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/反複/反覆/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/其余/其餘/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/注解/註解/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/真谛/真諦/g' {} \;
	@find $(INPUTDIR) -type f -exec sed -i 's/烹饪/烹飪/g' {} \;

hans:
	@echo "\033[92mCreating Simplified Chinese sub-site from Traditional Chinese site ...\033[0m"
	cd $(CURDIR)/hans; make

rmhans:
	@echo "\033[92mRemoving Simplified Chinese sub-site ...\033[0m"
	find $(INPUTDIR) -type f -name \*%zh-hans.rst -delete


.PHONY: html help clean regenerate serve serve-global devserver publish download scss hans
