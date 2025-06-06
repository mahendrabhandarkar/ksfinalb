package com.ks.ksfinalb.service.graphdb;
/*
import com.ks.ksfinalb.util.ExtractTextFromSource;
import lombok.RequiredArgsConstructor;
import org.springframework.ai.document.Document;
import org.springframework.ai.vectorstore.VectorStore;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
@RequiredArgsConstructor
public class DocumentEmbeddingService implements IDocumentEmbedding{

    @Autowired
    private VectorStore vectorStore;

    public void storeDocumentEmbedding(File file) throws IOException {
        ExtractTextFromSource extractTextFromSource = new ExtractTextFromSource();
        String text = "";
        String fileName = file.getName();
        if (fileName.endsWith(".pdf")) {
            text = extractTextFromSource.extractTextFromPdf(file);
        } else if (fileName.endsWith(".xlsx") || fileName.endsWith(".xls")) {
            text = extractTextFromSource.extractTextFromExcel(file);
        } else if (fileName.endsWith(".docx") || fileName.endsWith(".doc")) {
            text = extractTextFromSource.extractTextFromWord(file);
        }
        Document document = new Document(text);
        document.getMetadata().put("filename", fileName);
        vectorStore.add(List.of(document));
    }
}
*/