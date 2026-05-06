package com.ks.ksfinalb.model.datatables;

import java.util.List;

public class DataTableRequest {

    private int draw;
    private int start;
    private int length;

    private List<DataTableColumn> columns;
    private List<DataTableOrder> order;

    private DataTableSearch search;

    // Getters & Setters

    public int getDraw() {
        return draw;
    }

    public void setDraw(int draw) {
        this.draw = draw;
    }

    public int getStart() {
        return start;
    }

    public void setStart(int start) {
        this.start = start;
    }

    public int getLength() {
        return length;
    }

    public void setLength(int length) {
        this.length = length;
    }

    public List<DataTableColumn> getColumns() {
        return columns;
    }

    public void setColumns(List<DataTableColumn> columns) {
        this.columns = columns;
    }

    public List<DataTableOrder> getOrder() {
        return order;
    }

    public void setOrder(List<DataTableOrder> order) {
        this.order = order;
    }

    public DataTableSearch getSearch() {
        return search;
    }

    public void setSearch(DataTableSearch search) {
        this.search = search;
    }

    @Override
    public String toString() {
        return "DataTableRequest{" +
                "draw=" + draw +
                ", start=" + start +
                ", length=" + length +
                ", columns=" + columns +
                ", order=" + order +
                ", search=" + search +
                '}';
    }
}