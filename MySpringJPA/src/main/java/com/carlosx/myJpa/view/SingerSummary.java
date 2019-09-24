package com.carlosx.myJpa.view;

import java.io.Serializable;

@SuppressWarnings("serial")
public class SingerSummary implements Serializable {
    private String firstName;
    private String lastName;
    private String latestAlbum;

    /*
     * This constructor is used by hibernate to create the object through the query:
     * "select new com.apress.prospring5.ch8.view.SingerSummary("
				+ "s.firstName, s.lastName, a.title) from Singer s "
				+ "left join s.albums a "
				+ "where a.releaseDate=(select max(a2.releaseDate) "
				+ "from Album a2 where a2.singer.id = s.id)"
     */
    public SingerSummary(String firstName, String lastName,
            String latestAlbum) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.latestAlbum = latestAlbum;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getLatestAlbum() {
        return latestAlbum;
    }

    public String toString() {
        return "First name: " + firstName + ", Last Name: " + lastName
            + ", Most Recent Album: " + latestAlbum;
    }
}
