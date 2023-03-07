def tagTemplate:
{
    "name": "XXX",
    "annotations": {
        "openshift.io/display-name": "Red Hat OpenJDK 1.8 (UBI8)",
        "description": "Build and run Java applications using Maven and OpenJDK 1.8 upon UBI8.",
        "iconClass": "icon-rh-openjdk",
        "tags": "builder,java,openjdk,ubi8",
        "sampleRepo": "https://github.com/jboss-openshift/openshift-quickstarts",
        "sampleContextDir": "undertow-servlet",
        "version": "XXX"
    },
    "referencePolicy": {
        "type": "Local"
    },
    "from": {
        "kind": "DockerImage",
        "name": "registry.access.redhat.com/ubi8/openjdk-8:"
    }
}
;
def fillin($tagTemplate):
  . as $in
  | $tagTemplate
  | setpath(["name"]; $in.name)
  | setpath(["annotations","version"]; $in.name)
  | setpath(["from","name"]; $tagTemplate.from.name + $in.name)
  ;

map(fillin(tagTemplate))
