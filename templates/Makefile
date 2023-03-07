community-image-streams.json:
	jq -f populate-template-community.jq \
		--slurpfile versions ubi8-versions.json \
		community-image-streams.json~ \
		> $@

.PHONY: community-image-streams.json
