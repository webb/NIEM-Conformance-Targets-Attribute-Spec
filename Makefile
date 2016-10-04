
ifeq ($(IEAD_TOOLS_ROOT),)
$(error variable IEAD_TOOLS_ROOT is unset)
endif

-include tmp/dependencies.mk
-include tmp/params.mk

TEMPS = 

default: help

TEMPS += tmp/params.mk
tmp/params.mk: params.bash bin/params-sh-to-mk
	rm -f $@
	mkdir -p $(dir $@)
	bin/params-sh-to-mk $< > $@
	chmod -w $@

TEMPS += tmp/params.m4
tmp/params.m4: params.bash bin/params-sh-to-m4
	rm -f $@
	mkdir -p $(dir $@)
	bin/params-sh-to-m4 $< > $@
	chmod -w $@

# dir for building the release
RELEASE_DIR = tmp/$(RELEASE_NV)
RELEASE_ZIP = $(RELEASE_DIR).zip

# dir where the complete distro goes
DISTRO_DIR := tmp/release

PROCESS_DOC := $(IEAD_TOOLS_ROOT)/bin/process-doc

DOCNAME := ctas

DISTRO_FILES := \
	$(DISTRO_DIR)/$(RELEASE_NV).zip \
	$(DISTRO_DIR)/$(RELEASE_NV).html

RELEASE_FILES_LOCAL = \
	index.html \
	$(RELEASE_NV).html \
	xsd/conformanceTargets.xsd \
	xsl1/conformance-targets-utilities.xsl \
	xsl2/conformance-targets-utilities.xsl \

RELEASE_FILES := $(patsubst %,$(RELEASE_DIR)/%,$(RELEASE_FILES_LOCAL))

define m4 = 
rm -f $(2);
m4 -P tmp/params.m4 $(1) > $(2);
chmod -w $(2);
endef

# call with $(call CleanDirectory, dirName)
CleanDirectory = find $(1) -mindepth 1 -maxdepth 1 -print0 | xargs -0 rm -rf

help:
	@echo Targets:
	@echo " " help: show this help
	@echo " " release: build the complete release to tmp/release
	@echo " " all: generate all standard targets
	@echo " " html: make the local HTML version
	@echo " " all: make the local text version
	@echo " " clean: remove all generated items
	@echo " " test: run regression tests
	@echo " " depend: rebuild dependencies

all: text html

.PHONY: text
text: $(DOCNAME).txt

TEMPS += $(DOCNAME).txt
$(DOCNAME).txt: $(DOCNAME).xml $(DOC_TEXT_REQUIRED_FILES)
	$(PROCESS_DOC) -d -plaintext -in $< -out $@

.PHONY: html
html: $(DOCNAME).html

TEMPS += $(DOCNAME).html
$(DOCNAME).html: $(DOCNAME).xml $(DOC_HTML_REQUIRED_FILES)
	echo require: $^
	$(PROCESS_DOC) -html -in $< -out $@

TEMPS += index.html
index.html: index.html.m4 tmp/params.m4
	$(call m4,$<,$@)

TEMPS += $(DOCNAME).xml
$(DOCNAME).xml: $(DOCNAME).xml.m4 tmp/params.m4
	$(call m4,$<,$@)

tmp/$(RELEASE_NV).html: $(DOCNAME).html
	rm -f $@
	mkdir -p $(dir $@)
	cp $< $@
	chmod 644 $@

.PHONY: rebuild
rebuild: 
	$(MAKE) clean
	$(MAKE) all

PHONY: release
release: $(DISTRO_FILES)
	@echo Release files are in $$PWD/tmp/release

$(RELEASE_DIR)/index.html: index.html
	mkdir -p $(dir $@)
	install -D $< $@

$(RELEASE_DIR)/$(RELEASE_NV).html: $(DOCNAME).html
	mkdir -p $(dir $@)
	install -D $< $@

$(RELEASE_DIR)/xsd/conformanceTargets.xsd: xsd/conformanceTargets.xsd
	mkdir -p $(dir $@)
	install -D $< $@

$(RELEASE_DIR)/xsl1/conformance-targets-utilities.xsl: xsl1/conformance-targets-utilities.xsl
	mkdir -p $(dir $@)
	install -D $< $@

$(RELEASE_DIR)/xsl2/conformance-targets-utilities.xsl: xsl2/conformance-targets-utilities.xsl
	mkdir -p $(dir $@)
	install -D $< $@

tmp/$(RELEASE_NV).zip: $(RELEASE_FILES)
	rm -f $@
	cd tmp; \
		zip -9 -r $(RELEASE_NV).zip $(patsubst %,$(RELEASE_NV)/%,$(RELEASE_FILES_LOCAL))

tmp/release/$(RELEASE_NV).zip: tmp/$(RELEASE_NV).zip
	mkdir -p $(dir $@)
	install -D $< $@

tmp/release/$(RELEASE_NV).html: $(DOCNAME).html
	mkdir -p $(dir $@)
	install -D $< $@

TEMPS += xsd/conformanceTargets.xsd
xsd/conformanceTargets.xsd: xsd/conformanceTargets.xsd.m4 tmp/params.m4
	$(call m4,$<,$@)

TEMPS += xsl1/conformance-targets-utilities.xsl
xsl1/conformance-targets-utilities.xsl: xsl1/conformance-targets-utilities.xsl.m4 tmp/params.m4
	$(call m4,$<,$@)

TEMPS += xsl1/get-conformance-targets.xsl
xsl1/get-conformance-targets.xsl: xsl1/get-conformance-targets.xsl.m4 tmp/params.m4
	$(call m4,$<,$@)

TEMPS += xsl1/test-for-conformance-target.xsl
xsl1/test-for-conformance-target.xsl: xsl1/test-for-conformance-target.xsl.m4 tmp/params.m4
	$(call m4,$<,$@)

TEMPS += xsl2/conformance-targets-utilities.xsl
xsl2/conformance-targets-utilities.xsl: xsl2/conformance-targets-utilities.xsl.m4 tmp/params.m4
	$(call m4,$<,$@)

TEMPS += xsl2/get-conformance-targets.xsl
xsl2/get-conformance-targets.xsl: xsl2/get-conformance-targets.xsl.m4 tmp/params.m4
	$(call m4,$<,$@)

TEMPS += xsl2/test-for-conformance-target.xsl
xsl2/test-for-conformance-target.xsl: xsl2/test-for-conformance-target.xsl.m4 tmp/params.m4
	$(call m4,$<,$@)

.PHONY: test

test:
	@ bin/run-tests

.PHONY: depend

depend: tmp/dependencies.mk

TEMPS += tmp/dependencies.mk
tmp/dependencies.mk: $(DOCNAME).xml
	$(RM) $@
	$(PROCESS_DOC) -d -in $< -out $@ -makedepend 

.PHONY: clean
clean:
	$(call CleanDirectory, tmp)
	$(RM) $(wildcard tmp.*)
	find . -type f -name '*~' -delete
	rm -f $(TEMPS)

