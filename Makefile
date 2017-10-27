
TAG = amarburg/matlab-runtime:latest

build: MCR_R2017b_glnxa64_installer.zip
	docker build . --tag ${TAG}

force_build: MCR_R2017b_glnxa64_installer.zip
	docker build . --tag ${TAG} --no-cache

MCR_R2017b_glnxa64_installer.zip:
	wget -nv http://ssd.mathworks.com/supportfiles/downloads/R2017b/deployment_files/R2017b/installers/glnxa64/MCR_R2017b_glnxa64_installer.zip


help:
	@echo "make build              Build the image"
	@echo "make force_build        Build the image with --no-cache"


.PHONY: build force_build help
