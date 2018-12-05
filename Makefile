VERSION = $(shell git describe --always)

.PHONY: run
run: 
	yarn start

.PHONY: build
build: clean
	yarn build
	make -C server release
	docker build -t dhogborg/off-peak:latest .

.PHONY: release
release: build
	docker tag dhogborg/off-peak:latest dhogborg/off-peak:$(VERSION)
	docker push dhogborg/off-peak:$(VERSION)

.PHONY: clean
clean:
	rm -rf build

.PHONY: deploy
deploy: build
	gcloud app deploy --project off-peak-224318 -v g-$(VERSION)