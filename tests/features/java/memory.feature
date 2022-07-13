Feature: OPENJDK-559 JVM Memory tests

  @ubi9
  Scenario: Check default JVM max heap configuration
    Given container is started as uid 1000
    Then container log should contain -XX:MaxRAMPercentage=80.0

  @ubi9
  Scenario: Check configured JVM max heap configuration
    Given container is started with env
    | variable           | value  |
    | JAVA_MAX_MEM_RATIO | 90.0   |
    Then container log should contain -XX:MaxRAMPercentage=90.0

  @ubi9
  Scenario: Check default JVM initial heap configuration is unspecified
    Given container is started as uid 1000
    Then container log should not contain -XX:InitialRAMPercentage
    And  container log should not contain -Xms

  # Not the runtime images
  @ubi9/openjdk-11
  @ubi9/openjdk-17
  Scenario: Ensure Maven doesn't use MaxRAMPercentage=80
    Given s2i build https://github.com/jboss-openshift/openshift-examples from spring-boot-sample-simple
    Then s2i build log should match regex INFO Using MAVEN_OPTS.*-XX:MaxRAMPercentage=25.0$
