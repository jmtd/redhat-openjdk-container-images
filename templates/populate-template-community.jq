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
        "name": "XXX",
        "annotations": {
            "openshift.io/display-name": "XXX",
            "openshift.io/provider-display-name": "Red Hat, Inc."
        }
    },
    "spec": {
        "tags": []
    }
}
;

# input should be a tag structure list [{...}]
def fillItemTemplate($itemTemplate; $jdk):
  . as $in
  | $itemTemplate
  | setpath(["spec","tags"]; $in)
  | setpath(["metadata","name"]; "ubi8-openjdk-" + $jdk)
  | setpath(["metadata","annotations","openshift.io/display-name"]; "Red Hat OpenJDK "+$jdk+" (UBI8)")
  ;

# fill out the top-level template
# expects 
def fillListTemplate($topLevelTemplate):
  .
  ;

. | setpath(["items"]; [
#       ["1.13", ...          [{name:"1.13",...                          [{metadata:{name:ubi8-openjdk-8}}]
        ($versions[0].jdk8  | map(fillinTagTemplate(tagTemplate;"8"))  | fillItemTemplate(itemTemplate; "8")),
        ($versions[0].jdk11 | map(fillinTagTemplate(tagTemplate;"11")) | fillItemTemplate(itemTemplate; "11")),
        ($versions[0].jdk17 | map(fillinTagTemplate(tagTemplate;"17")) | fillItemTemplate(itemTemplate; "17"))
        ])
# TODO:
# itemTemplate "java"
