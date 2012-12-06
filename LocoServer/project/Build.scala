import sbt._
import Keys._
import PlayProject._

object ApplicationBuild extends Build {

    val appName         = "VocoServerApp"
    val appVersion      = "1.0"

    val appDependencies = Seq(
      "postgresql" % "postgresql" % "9.1-901-1.jdbc4",
      "nl.rhinofly" %% "api-s3" % "1.5.0"
    )

    val main = PlayProject(appName, appVersion, appDependencies, mainLang = SCALA).settings(
      // Add your own project settings here

      resolvers += "Rhinofly Internal Repository" at "http://maven-repository.rhinofly.net:8081/artifactory/libs-release-local"      
    )

}
