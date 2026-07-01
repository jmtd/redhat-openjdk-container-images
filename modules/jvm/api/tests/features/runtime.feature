@ubi8
@openjdk-els
Feature: OpenJDK Runtime tests 

  Scenario: Check JAVA_OPTS overrides defaults (OPENJDK-2009)
    Given container is started with env
    | variable  | value          |
    | JAVA_OPTS | --show-version |
    Then container log should not contain -XX:MaxRAMPercentage

  Scenario: Check empty JAVA_OPTS overrides defaults (OPENJDK-2009)
    Given container is started with env
    | variable  | value          |
    | JAVA_OPTS |                |
    Then container log should not contain -XX:MaxRAMPercentage
