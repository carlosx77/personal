package com.carlosx.mvc.util;

import java.util.List;

import com.carlosx.mvc.entities.Singer;

public class SingerGrid {
    private int totalPages;
    private int currentPage;
    private long totalRecords;
    private List<Singer> singerData;

    public int getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(int totalPages) {
        this.totalPages = totalPages;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public long getTotalRecords() {
        return totalRecords;
    }

    public void setTotalRecords(long totalRecords) {
        this.totalRecords = totalRecords;
    }

    public List<Singer> getSingerData() {
        return singerData;
    }

    public void setSingerData(List<Singer> singerData) {
        this.singerData = singerData;
    }
}
