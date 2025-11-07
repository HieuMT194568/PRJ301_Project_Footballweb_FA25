package Model; // Hoặc package DTO của bạn

import java.util.List;

public class RevenueData {
    private List<String> labels;
    private List<Double> data;

    public RevenueData(List<String> labels, List<Double> data) {
        this.labels = labels;
        this.data = data;
    }

    // Getters
    public List<String> getLabels() {
        return labels;
    }

    public List<Double> getData() {
        return data;
    }
}