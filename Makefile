# Makefile for Haiku Tracker Add-on

NAME = OpenKonsole
VERSION = 1.0.1
PACKAGE_DIR := build/package



UNAME_M := $(shell uname -m)
ifeq ($(UNAME_M), BePC)
	CXX = g++
	CC = gcc
	CXXFLAGS = -Wall -O3
	LDFLAGS = -shared
	LIBS = -lbe -ltracker
	ARCH = x86_gcc2
	LD_OPTIMIZE = -Wl,--gc-sections
	is32bit = _x86
	DEFINES += -DIS_HAIKU_32BIT
else
	CXX = g++ 
	CC = gcc
	CXXFLAGS = -Wall -O3
	LDFLAGS = -shared
	LIBS = -lbe -ltracker
	ARCH = x86_64
	LD_OPTIMIZE = -Wl,--gc-sections
endif

DEFINES := $(DEFINES)

all: build package

build: 
	@echo "--------- Building $(NAME) $(ARCH) ---------"
	$(CXX) -o $(NAME) $(CXXFLAGS) $(DEFINES) $(LDFLAGS) $(LIBS) $(LD_OPTIMIZE) $(NAME).cpp
	xres -o $(NAME) icon.rsrc  
	mimeset -f $(NAME)

package:
	@[ -n "$(PACKAGE_DIR)" ] || { echo "PACKAGE_DIR is undefined"; exit 1; }
	rm -rf "./$(PACKAGE_DIR)"
	mkdir -p $(PACKAGE_DIR)
	sed -e 's/$$(NAME)/$(NAME)/g' -e 's/$$(is32bit)/$(is32bit)/g' -e 's/$$(VERSION)/$(VERSION)/g' -e 's/$$(ARCH)/$(ARCH)/' -e 's/$$(YEAR)/$(shell date +%Y)/' PackageInfo.tpl > $(PACKAGE_DIR)/.PackageInfo
	mkdir -p $(PACKAGE_DIR)/add-ons/Tracker
	rc -o icon.rsrc icon.rdef 
	xres -o $(NAME) icon.rsrc  
	mimeset -f $(NAME)	
	cp $(NAME) $(PACKAGE_DIR)/add-ons/Tracker/Open\ konsole
	package create -C $(PACKAGE_DIR) $(NAME)-$(VERSION)-1-$(ARCH).hpkg
	
clean:
	rm -f $(NAME) $(NAME)-$(VERSION)-1-$(ARCH).hpkg
	rm -fr objects*
	rm -fr build
	
.PHONY: all build package clean
