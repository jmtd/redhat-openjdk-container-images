community-image-streams2.json:
	jq -f populate-template-community.jq \
		--slurpfile versions ubi8-versions.json \
		community-image-streams.json \
		> $@

.PHONY: community-image-streams2.json

example:
	echo '{ "foo":"hug","bar":"you"}' | jq --slurpfile moo ubi8-versions.json '.foo=$moo'
