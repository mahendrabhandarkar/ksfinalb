package com.ks.ksfinalb.util;

import java.io.File;
import java.io.IOException;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.Loader;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.openxml4j.opc.OPCPackage;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xwpf.extractor.XWPFWordExtractor;
import org.apache.poi.xwpf.usermodel.XWPFDocument;

public class ExtractTextFromSource {

    public String extractTextFromPdf(File file) throws IOException {
        try (PDDocument doc = Loader.loadPDF(file)) {
            PDFTextStripper stripper = new PDFTextStripper();
            return stripper.getText(doc);
        }
    }

    public String extractTextFromExcel(File file) throws IOException {
        StringBuilder sb = new StringBuilder();
        try (Workbook workbook = WorkbookFactory.create(file)) {
            for (Sheet sheet : workbook) {
                for (Row row : sheet) {
                    for (Cell cell : row) {
                        sb.append(cell.toString()).append(" ");
                    }
                }
            }
        }
        return sb.toString();
    }

    public String extractTextFromWord(File file) throws IOException {
        try (XWPFDocument doc = new XWPFDocument(OPCPackage.open(file))) {
            XWPFWordExtractor extractor = new XWPFWordExtractor(doc);
            return extractor.getText();
        } catch (InvalidFormatException e) {
            throw new RuntimeException(e);
        }
    }
}
