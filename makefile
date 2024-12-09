.PHONY: build
build:
	go build -o output/bin/car cmd/car/main/main.go

.PHONY: gen
gen:
	go get -u ./...
	go mod tidy
	go generate ./...
	go test -v ./...

.PHONY: image
image:
	docker build --push -t njpowell/car .

.PHONY: helm
helm:
	helm install car ./charts/car

.PHONY: uhelm
uhelm:
	helm uninstall car

.PHONY: ksecret
ksecret:
	kubectl create secret generic ngrok --from-literal=NGROK_AUTHTOKEN=$(NGROK_AUTHTOKEN)