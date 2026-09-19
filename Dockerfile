FROM public.ecr.aws/e1h7x4a2/plow-cloud-agents:base-ef0019372ff8bca593611b31ebd2e08f9f1458ff@sha256:a8a2f97ad78b8192d80a984dce81d3bf5a9a883d18cb7b677704913a09b56aee

COPY LICENSE /usr/share/licenses/place-hunt-hermes-agent/

# Identity: only what is specific to this agent. plow-init writes the home's
# SOUL.md on every boot as the base persona followed by this file. Do not COPY
# anything to /var/lib/hermes/SOUL.md — it is overwritten at boot.
COPY --chown=0:0 persona.md /opt/hermes/plow-seed/persona.md
RUN chmod 0644 /opt/hermes/plow-seed/persona.md

# Seed place-hunt (and property-hunt compatibility alias) into both
# /var/lib/hermes/skills/ and /opt/hermes/skills/
COPY --chown=10000:10000 skill/ /var/lib/hermes/skills/productivity/place-hunt/
COPY --chown=10000:10000 skill/ /var/lib/hermes/skills/productivity/property-hunt/
COPY --chown=10000:10000 skill/ /opt/hermes/skills/productivity/place-hunt/
COPY --chown=10000:10000 skill/ /opt/hermes/skills/productivity/property-hunt/
