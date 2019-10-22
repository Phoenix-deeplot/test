package com.kst.isms.vo;


import com.kst.isms.entity.Question;

public class QuestionVO extends Question {

    private String categoryLabel;

    private String typeLabel;

    public String getCategoryLabel() {
        return categoryLabel;
    }

    public void setCategoryLabel(String categoryLabel) {
        this.categoryLabel = categoryLabel;
    }

    public String getTypeLabel() {
        return typeLabel;
    }

    public void setTypeLabel(String typeLabel) {
        this.typeLabel = typeLabel;
    }
}
