// create PdfService.java trong services
package local.example.demo.service;

import com.itextpdf.kernel.font.PdfFont;
import com.itextpdf.kernel.font.PdfFontFactory;
import com.itextpdf.kernel.pdf.PdfDocument;
import com.itextpdf.kernel.pdf.PdfWriter;

import com.itextpdf.layout.Document;
import com.itextpdf.layout.element.Paragraph;
import com.itextpdf.layout.element.Table;
import com.itextpdf.layout.properties.UnitValue;
import local.example.demo.model.dto.OrderDetailDTO;
import org.springframework.stereotype.Service;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.text.Normalizer;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.regex.Pattern;

@Service
public class PdfService {

    public byte[] generateInvoicePdf(List<OrderDetailDTO> orderDetails) {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter writer = new PdfWriter(baos);
        PdfDocument pdf = new PdfDocument(writer);
        Document document = new Document(pdf);

        try {
            // Use Helvetica with WinAnsi encoding (built-in, no external font needed)
            PdfFont font = PdfFontFactory.createFont("Helvetica", "WinAnsi",
                    PdfFontFactory.EmbeddingStrategy.PREFER_EMBEDDED);

            // Check if orderDetails is empty
            if (orderDetails == null || orderDetails.isEmpty()) {
                document.add(new Paragraph("No order details available.").setFont(font));
                document.close();
                return baos.toByteArray();
            }

            OrderDetailDTO order = orderDetails.get(0);

            // Invoice title
            document.add(new Paragraph("INVOICE")
                    .setFont(font)
                    .setFontSize(20)
                    .setBold()
                    .setMarginBottom(20));

            // Order information
            document.add(new Paragraph("Order ID: " + order.getOrderId()).setFont(font));
            document.add(new Paragraph("Order Date: " +
                    (order.getOrderDate() != null
                            ? order.getOrderDate().format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"))
                            : "N/A"))
                    .setFont(font));
            document.add(
                    new Paragraph("Customer: " + removeDiacritics(order.getFirstName() + " " + order.getLastName()))
                            .setFont(font));
            document.add(new Paragraph("Email: " + order.getEmail()).setFont(font));
            document.add(
                    new Paragraph("Shipping Address: " + removeDiacritics(order.getShippingAddress())).setFont(font));
            document.add(new Paragraph("Payment Status: " +
                    (order.getPaymentStatus() == 1 ? "Paid" : "Unpaid")).setFont(font));
            document.add(new Paragraph("\n").setFont(font));

            // Product details table
            Table table = new Table(UnitValue.createPercentArray(new float[] { 40, 15, 15, 30 }));
            table.setWidth(UnitValue.createPercentValue(100));

            // Table headers
            table.addHeaderCell(new Paragraph("Product").setFont(font));
            table.addHeaderCell(new Paragraph("Quantity").setFont(font));
            table.addHeaderCell(new Paragraph("Price").setFont(font));
            table.addHeaderCell(new Paragraph("Subtotal").setFont(font));

            // Table data
            for (OrderDetailDTO detail : orderDetails) {
                table.addCell(new Paragraph(detail.getProductName()).setFont(font));
                table.addCell(new Paragraph(String.valueOf(detail.getQuantity())).setFont(font));
                table.addCell(new Paragraph(formatVND(detail.getOrderDetailPrice())).setFont(font));
                table.addCell(new Paragraph(formatVND(detail.getSubtotal())).setFont(font));
            }

            document.add(table);

            // Total amount
            document.add(new Paragraph("\nTotal Amount: " + formatVND(order.getTotalAmount()))
                    .setFont(font)
                    .setBold()
                    .setFontSize(14));

        } catch (IOException e) {
            e.printStackTrace();
            document.add(new Paragraph("Error generating PDF: " + e.getMessage()));
        } finally {
            document.close();
        }

        return baos.toByteArray();
    }

    // Format number to VND with dots
    private String formatVND(Number amount) {
        if (amount == null)
            return "0 VND";
        String formatted = String.format("%,.0f", amount.doubleValue());
        // Replace commas with dots to match desired format (e.g., 1.650.000)
        formatted = formatted.replace(",", ".");
        return formatted + " VND";
    }

    // Remove diacritics from Vietnamese text
    private String removeDiacritics(String text) {
        if (text == null)
            return "";
        String normalized = Normalizer.normalize(text, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{M}");
        return pattern.matcher(normalized)
                .replaceAll("")
                .replace("Đ", "D")
                .replace("đ", "d");
    }

    // Remove HTML tags from text
    private String stripHtmlTags(String text) {
        if (text == null)
            return "";
        return text.replaceAll("<[^>]+>", "");
    }
}