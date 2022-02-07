package com.softserveinc.edu;

import org.junit.Test;

public class App {

	@Test
    public void checkApp() {
        // From OS
        System.out.println("***System.getenv(\"MY_PASSWORD\") = " + System.getenv("MY_PASSWORD"));
        System.out.println("***System.getenv(\"DEFAULT_PASS\") = " + System.getenv("DEFAULT_PASS"));
        // From Eclipse/Idea
        System.out.println("***System.getenv().MY_IDE = " + System.getenv().get("MY_IDE"));
    }
}
