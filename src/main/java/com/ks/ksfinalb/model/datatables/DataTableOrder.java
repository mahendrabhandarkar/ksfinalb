package com.ks.ksfinalb.model.datatables;

public class DataTableOrder {

    private int column;   // index of column
    private String dir;   // "asc" or "desc"

    // Getters & Setters

    public int getColumn() {
        return column;
    }

    public void setColumn(int column) {
        this.column = column;
    }

    public String getDir() {
        return dir;
    }

    public void setDir(String dir) {
        this.dir = dir;
    }

    @Override
    public String toString() {
        return "DataTableOrder{" +
                "column=" + column +
                ", dir='" + dir + '\'' +
                '}';
    }
}