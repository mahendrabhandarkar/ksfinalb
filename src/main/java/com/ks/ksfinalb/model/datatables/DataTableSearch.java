package com.ks.ksfinalb.model.datatables;

public class DataTableSearch {

    private String value;
    private boolean regex;

    // Getters & Setters

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public boolean isRegex() {
        return regex;
    }

    public void setRegex(boolean regex) {
        this.regex = regex;
    }

    @Override
    public String toString() {
        return "DataTableSearch{" +
                "value='" + value + '\'' +
                ", regex=" + regex +
                '}';
    }
}