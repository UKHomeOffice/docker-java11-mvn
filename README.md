# docker-java11-mvn
base docker image with JDK 11 and Maven

Docker image with JDK 11 and Maven. Not intended to use as a base for java projects, just for building.

## Usage

This image is to be used to build your app using maven.

Contents of .drone.yml:
```
kind: pipeline
type: kubernetes

platform:
  os: linux
  arch: amd64

steps:
  - name: build_and_test
    pull: if-not-exists
    image: quay.io/ukhomeofficedigital/java11-mvn:v3.5.4 
    environment:
      ARTIFACTORY_USERNAME:
        from_secret: ARTIFACTORY_USERNAME
      ARTIFACTORY_PASSWORD:
        from_secret: ARTIFACTORY_PASSWORD
    commands:
      - mvn install -DskipTests=true -Dmaven.javadoc.skip=true -B -V
      - mvn test -B
    when:
      event:
        - push
        - pull-request

```

To authenticate with Artifactory, please pass valid credentials via the ARTIFACTORY\_USERNAME and ARTIFACTORY\_PASSWORD environment variables.

You'll also need to include the following in your POM file:
```
<distributionManagement>
        <repository>
                <id>artifactory</id>
                <name>libs-release-local</name>
                <url>https://artifactory.digital.homeoffice.gov.uk/artifactory/libs-release-local</url>
        </repository>
        <snapshotRepository>
                <id>artifactory</id>
                <name>libs-snapshot-local</name>
                <url>https://artifactory.digital.homeoffice.gov.uk/artifactory/libs-snapshot-local</url>
        </snapshotRepository>
</distributionManagement>
```
Maven should then deploy to Artifactory during the "deploy" lifecycle phase.

## Contributing

Feel free to submit pull requests and issues. If it's a particularly large PR, you may wish to
discuss it in an issue first.

Please note that this project is released with a
[Contributor Code of Conduct](https://github.com/UKHomeOffice/docker-java11-mvn/blob/master/CONTRIBUTING.md).

By participating in this project you agree to abide by its terms.

## Versioning

We use [SemVer](http://semver.org/) for the version tags available See the tags on this repository.

## Built With

* java-1.11.0-openjdk-devel

See also the list of
[contributors](https://github.com/UKHomeOffice/docker-java11-mvn/graphs/contributors) who participated
in this project.

## License

This project is licensed under the GPL v2 License - see the
[LICENSE.md](https://github.com/UKHomeOffice/docker-java11-mvn/blob/master/LICENSE) file for details
