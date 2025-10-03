# Day1-Foundation – DHCPD App

## Structure
- `apps/kustomization.yml` – aggregates child apps
- `apps/dhcpd/*` – dhcpd manifests
- `tests/` – validation pods

## Flow
1. `day0-bootstrap` installs Argo + repo creds.
2. `day1-foundation` App-of-Apps syncs `dhcpd`.
3. `dhcpd` Application uses **two repos**:
   - `day1-foundation` → manifests
   - `dhcpd-config` → raw `dhcpd.conf`
4. Kustomize builds a ConfigMap → mounted into the pod.
5. If `dhcpd.conf` changes, Argo notices drift → rollout triggered.

## Config updates
- Edit `dhcpd-config/dhcpd.conf`.
- Commit/push → Argo resyncs and restarts pod with new config.

## Tests
- Apply `tests/dhcpd-test-pod.yml`.
- Pod should request a DHCP lease from dhcpd.

## Operational Notes
- Run **one dhcpd per broadcast domain**.
- To cover more VLANs: deploy more instances or use `dhcrelay`.
- Security: runs with minimal capabilities, hostNetwork only.
