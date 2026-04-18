# Makefile for Haiku Tracker Add-on

NAME = OpenKonsole
VERSION = 1.0.0
PACKAGE_DIR := build/package
.PHONY: clean package


UNAME_M := $(shell uname -p)
ifeq ($(UNAME_M), x86)
	TYPE = SHARED
	SRCS = OpenKonsole.cpp
	LIBS = be tracker
	OPTIMIZE = FULL
	COMPILER_FLAGS = -Wall -fPIC
	include /boot/system/develop/etc/makefile-engine
    ARCH = x86_gcc2
    SIMD_FLAGS := -O2
else ifeq ($(UNAME_M), x86_64)
	CXX = g++ 
	CC = gcc
	CXXFLAGS = -Wall -O2
	LDFLAGS = -shared
	LIBS = -lbe -ltracker
    ARCH = x86_64
    SIMD_FLAGS := -O3
endif


all: build

build: 
	@echo "--------- Building $(NAME) $(ARCH) ---------"

	$(CXX) $(CXXFLAGS) $(LDFLAGS) $(NAME).cpp -o $(NAME) $(LIBS)
	xres -o $(NAME) icon.rsrc  
	mimeset -f $(NAME)



package:
ifeq ($(UNAME_M), x86_64)
	@[ -n "$(PACKAGE_DIR)" ] || { echo "PACKAGE_DIR is undefined"; exit 1; }
	rm -rf "./$(PACKAGE_DIR)"
	mkdir -p $(PACKAGE_DIR)
	sed -e 's/$$(NAME)/$(NAME)/g' -e 's/$$(VERSION)/$(VERSION)/g' -e 's/$$(ARCH)/$(ARCH)/' -e 's/$$(YEAR)/$(shell date +%Y)/' PackageInfo.tpl > $(PACKAGE_DIR)/.PackageInfo
	mkdir -p $(PACKAGE_DIR)/add-ons/Tracker
	rc -o icon.rsrc icon.rdef 
	xres -o $(NAME) icon.rsrc  
	mimeset -f $(NAME)	
	cp $(NAME) $(PACKAGE_DIR)/add-ons/Tracker/Open\ konsole
	package create -C $(PACKAGE_DIR) $(NAME)-$(VERSION)-1-$(ARCH).hpkg
else ifeq ($(UNAME_M), x86)
	@[ -n "$(PACKAGE_DIR)" ] || { echo "PACKAGE_DIR is undefined"; exit 1; }
	rm -rf "./$(PACKAGE_DIR)"
	mkdir -p $(PACKAGE_DIR)
	sed -e 's/$$(NAME)/$(NAME)/g' -e 's/$$(VERSION)/$(VERSION)/g' -e 's/$$(ARCH)/$(ARCH)/' -e 's/$$(YEAR)/$(shell date +%Y)/' PackageInfo.tpl > $(PACKAGE_DIR)/.PackageInfo
	mkdir -p $(PACKAGE_DIR)/add-ons/Tracker
	rc -o icon.rsrc icon.rdef 
	xres -o $(OBJ_DIR)/$(NAME) icon.rsrc  
	mimeset -f $(OBJ_DIR)/$(NAME)	
	cp $(OBJ_DIR)/$(NAME) $(PACKAGE_DIR)/add-ons/Tracker/Open\ konsole
	package create -C $(PACKAGE_DIR) $(NAME)-$(VERSION)-1-$(ARCH).hpkg
endif
	
clean:
	rm -f $(NAME)
	rm -f *.hpkg
	rm -fr objects*
	rm -fr build
