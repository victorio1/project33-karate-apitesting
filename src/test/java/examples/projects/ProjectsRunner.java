package examples.projects;

import com.intuit.karate.junit5.Karate;

public class ProjectsRunner {

    @Karate.Test
    Karate testUsers() {
        return Karate.run("project").relativeTo(getClass());
    }
}
