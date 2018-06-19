package br.jus.trerj.funcoes;

import java.io.FileInputStream;

import java.io.FileReader;

import java.io.IOException;

 

import org.apache.lucene.analysis.Analyzer;

import org.apache.lucene.analysis.standard.StandardAnalyzer;

import org.apache.lucene.document.Document;

import org.apache.lucene.document.Field;

import org.apache.lucene.index.IndexWriter;

import org.apache.lucene.store.Directory;

import org.apache.lucene.store.FSDirectory;

public class IndexadorPalavras {
	public static void main(String[] args) {

        Document document = new Document();

        try {

                 FileInputStream arquivo = new FileInputStream("c:/arquivo.txt");

                 //Directory directory = FSDirectory.getDirectory("c:/indice", true);
                 Directory directory = FSDirectory.open("c:/indice");

                 Analyzer analyzer = new StandardAnalyzer();

                 IndexWriter writer = new IndexWriter(directory, analyzer, true);

                 document.add(new Field("arquivo", "c:/arquivo.txt",Field.Store.YES, Field.Index.NO));

                 document.add(new Field("conteudo", new FileReader(arquivo.getFD())));

                 writer.addDocument(document);

                 writer.close();

arquivo.close();





        } catch (IOException e) {

                 e.printStackTrace();

        }

}
}
