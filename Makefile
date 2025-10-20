IMAGE_NAME ?= procesos-estocasticos
CONTAINER_NAME ?= procesos-estocasticos-notebook
JUPYTER_PORT ?= 8888
WORKDIR ?= /workspace

.PHONY: build notebook shell stop clean

build:
	docker build -t $(IMAGE_NAME) .

notebook:
	docker run --rm -d \
		--name $(CONTAINER_NAME) \
		-p $(JUPYTER_PORT):8888 \
		-v $(PWD):$(WORKDIR) \
		-w $(WORKDIR) \
		$(IMAGE_NAME)
	@echo "JupyterLab running at http://localhost:$(JUPYTER_PORT)"

shell:
	docker run --rm -it \
		-p $(JUPYTER_PORT):8888 \
		-v $(PWD):$(WORKDIR) \
		-w $(WORKDIR) \
		$(IMAGE_NAME) /bin/bash

stop:
	-@docker stop $(CONTAINER_NAME)

clean:
	-@docker rm $(CONTAINER_NAME)
