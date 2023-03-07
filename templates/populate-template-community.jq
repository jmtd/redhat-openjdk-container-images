# Input should be a complete ImageStream definition, or carcass
# we will replace the .items array by expanding itemTemplate
# within each we will expand tagTemplate

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

# input should be a version "1.13"
# (this is applied with map)
def fillinTagTemplate($tagTemplate):
  . as $in
  | $tagTemplate
  | setpath(["name"]; $in)
  | setpath(["annotations","version"]; $in)
  | setpath(["from","name"]; $tagTemplate.from.name + $in)
  ;

def itemTemplate:
{
    "kind": "ImageStream",
    "apiVersion": "image.openshift.io/v1",
    "metadata": {
        "name": "ubi8-openjdk-8",
        "annotations": {
            "openshift.io/display-name": "Red Hat OpenJDK 1.8 (UBI8)",
            "openshift.io/provider-display-name": "Red Hat, Inc."
        }
    },
    "spec": {
        "tags": []
    }
}
;

# input should be a tag structure list [{...}]
def fillItemTemplate($itemTemplate):
  . as $in
  | $itemTemplate
  | setpath(["spec","tags"]; $in)
  ;

# fill out the top-level template
# expects 
def fillListTemplate($topLevelTemplate):
  .
  ;

. | setpath(["items"]; [$versions
                       | map(fillinTagTemplate(tagTemplate))
                       | fillItemTemplate(itemTemplate])
           )

# items has become a dict, not a list of dicts, list, which is not right
