
%:
	$(eval p := $(subst /, , $*))
	$(eval os := $(shell basename $(CURDIR)))
	$(eval target := $(word 1, $(p))-$(word 2, $(p)))
	$(eval builder := $(word 3, $(p)))
	$(eval builders := $(shell jq '.builders[] | .type' $(target).json | tr -d '"'))
	$(eval outputdir := $(CURDIR)/output/$(os)-$(target))
	find $(CURDIR)/output/ -maxdepth 1 -name '$(os)-$(target)-*' -type d -print0 | xargs -0 -I {} /bin/rm -r "{}"
	@echo building $(os)-$(target)
ifdef $(builder)
	ACKER_LOG="yes" PACKER_CONFIG=$(CURDIR)/.packerconfig PACKER_LOG_PATH=$(CURDIR)/logs/$(builder)-$(target).log packer build -only=$(builder) $(target).json
else
	$(foreach builder,$(builders), PACKER_LOG="yes" PACKER_CONFIG=$(CURDIR)/.packerconfig PACKER_LOG_PATH=$(CURDIR)/logs/$(builder)-$(target).log packer build -only=$(builder) $(target).json;)
endif

