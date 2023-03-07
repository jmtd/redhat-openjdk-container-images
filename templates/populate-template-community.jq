# Input should be a complete ImageStream definition, or carcass
# we will replace the .items array by expanding itemTemplate
# within each we will expand tagTemplate

def tagTemplate:
{
    "name": "XXX",
    "annotations": {
        "openshift.io/display-name": "XXX",
        "description": "XXX",
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
        "name": "registry.access.redhat.com/ubi8/openjdk-"
    }
}
;

# input should be a version "1.13"
# (this is applied with map)
def fillinTagTemplate($tagTemplate; $jdk):
  . as $in
  | $tagTemplate
  | setpath(["name"]; $in)
  | setpath(["annotations","version"]; $in)
  | setpath(["annotations","description"]; "Build and run Java applications using Maven and OpenJDK "+$jdk+" upon UBI8.")
  | setpath(["annotations", "openshift.io/display-name"]; "Red Hat OpenJDK " + $jdk + " (UBI8)")
  | setpath(["from","name"]; $tagTemplate.from.name + $jdk + ":" + $in)
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

. | setpath(["items"];
        $versions[0].jdk8                         # ["1.13", ...
        | map(fillinTagTemplate(tagTemplate;"8")) # [{name:"1.13",...
        | [fillItemTemplate(itemTemplate)]        # [{metadata:{name:ubi8-openjdk-8}}]
        )
# TODO:
# itemTemplate "ubi8-openjdk-11"
# itemTemplate "ubi8-openjdk-17"
# itemTemplate "java"
# keys jdk8, 11, 17 in the input,
