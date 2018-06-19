package teste;

import java.io.File;
import java.io.IOException;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;

public class Pdfbox {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		//Loading an existing document
	      File file = new File("d:/Temp/20140205_111600.pdf");
	      PDDocument document = PDDocument.load(file);

	      //Instantiate PDFTextStripper class
	      PDFTextStripper pdfStripper = new PDFTextStripper();

	      //Retrieving text from PDF document
	      String text = pdfStripper.getText(document);
	      System.out.println(text);

	      //Closing the document
	      document.close();
	}

}
