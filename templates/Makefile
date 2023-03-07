community-image-streams2.json:
	jq -f populate-template-community.jq \
		--slurpfile versions json-data-2.json \
		--slurpfile outerTemplate community-image-streams.json \
		json-data-2.json > $@

.PHONY: community-image-streams2.json

example:
	echo '{ "foo":"hug","bar":"you"}' | jq --slurpfile moo json-data-2.json '.foo=$moo'
