package com.softeam.helloworld.dto;

public class MessageDTO {

    private int id;
    private String body;
    private String language;

    public MessageDTO() {
    }

    public MessageDTO(int id, String language, String body) {
        this.id = id;
        this.body = body;
        this.language = language;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public String getLanguage() {
        return language;
    }

    public void setLanguage(String language) {
        this.language = language;
    }
}
