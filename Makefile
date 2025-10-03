KUSTOMIZE ?= kustomize
KCTX ?= default

.PHONY: build-dhcpd
build-dhcpd:
	$(KUSTOMIZE) build apps/dhcpd --load-restrictor=LoadRestrictionsNone | tee /dev/stderr >/dev/null

.PHONY: dryrun-dhcpd
dryrun-dhcpd:
	$(KUSTOMIZE) build apps/dhcpd --load-restrictor=LoadRestrictionsNone | kubectl --context $(KCTX) apply --dry-run=server -f -

.PHONY: smoketest
smoketest:
	kubectl apply -f apps/dhcpd/tests/dhcpd-test-pod.yml
