
LUA := lua

ifndef DESTDIR
  DESTDIR := /usr/local
endif
LIBDIR  := $(DESTDIR)/share/lua/5.1

install:
	cp src/OAuth.lua $(LIBDIR)

uninstall:
	rm -f $(LIBDIR)/OAuth.lua

export LUA_PATH=;;src/?.lua;unittest/?.lua

test:
	$(LUA) unittest/run.lua
